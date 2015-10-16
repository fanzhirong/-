//
//  FirstViewController.m
//  医药大典
//
//  Created by qf on 15/10/14.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "FirstViewController.h"
#import "ShadowView.h"


static const CGFloat kICSDrawerControllerDrawerDepth = 260.0f;
static const CGFloat kICSDrawerControllerLeftViewInitialOffset = -60.0f;
static const NSTimeInterval kICSDrawerControllerAnimationDuration = 0.5;
static const CGFloat kICSDrawerControllerOpeningAnimationSpringDamping = 0.7f;
static const CGFloat kICSDrawerControllerOpeningAnimationSpringInitialVelocity = 0.1f;
static const CGFloat kICSDrawerControllerClosingAnimationSpringDamping = 1.0f;
static const CGFloat kICSDrawerControllerClosingAnimationSpringInitialVelocity = 0.5f;

typedef NS_ENUM(NSUInteger,DrawerControllerState)
{
    DrawerControllerStateClosed = 0,
    DrawerControllerStateOpening,
    DrawerControllerStateOpen,
    DrawerControllerStateClosing
};
@interface FirstViewController ()


@property(nonatomic, strong) UIView *leftView;
@property(nonatomic, strong) ShadowView *centerView;

@property(nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@property(nonatomic, assign) CGPoint panGestureStartLocation;

@property(nonatomic, assign) DrawerControllerState drawerState;

@end

@implementation FirstViewController

-(id)initWithLeft:(UIViewController<DrawerControllerChild,DrawercontrollerHandler>*)leftViewController rightViewController:(UIViewController<DrawerControllerChild,DrawercontrollerHandler>*)rightViewController
{
    if (self = [super init]) {
        _leftViewController = leftViewController;
        _rightViewController = rightViewController;
        
        if ([_leftViewController respondsToSelector:@selector(setDrawer:)]) {
            _leftViewController.drawer = self;
        }
        if ([_rightViewController respondsToSelector:@selector(setDrawer:)]) {
            _rightViewController.drawer = self;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    self.leftView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.leftView.autoresizingMask = self.view.autoresizingMask;
    
    self.centerView = [[ShadowView alloc]initWithFrame:self.view.bounds];
    self.centerView.autoresizingMask = self.view.autoresizingMask;
    
    [self.view addSubview:self.centerView];
    
    [self addCenterViewController];
    
    [self setGestureRecognizers];
}

-(void)addCenterViewController
{
    [self.centerView addSubview:self.rightViewController.view];
    [self addChildViewController:self.rightViewController];
    [self.rightViewController didMoveToParentViewController:self];
}

-(void)setGestureRecognizers
{
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHandle:)];
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panHandle:)];
    [self.centerView addGestureRecognizer:self.panGestureRecognizer];
}

-(void)addClosingGestureRecognizer
{
    [self.centerView addGestureRecognizer:self.tapGestureRecognizer];
}
-(void)removeClosingGestureRecognizer
{
    [self.centerView removeGestureRecognizer:self.tapGestureRecognizer];
}
#pragma mark ----点击手势方法
-(void)tapHandle:(UITapGestureRecognizer *)tap
{
    if (tap.state == UIGestureRecognizerStateEnded) {
        [self close];
    }
}
#pragma mark  ----收起右边页面
-(void)close
{
    [self willClose];
    [self animationClose];
}
-(void)willClose
{
    [self.leftViewController willMoveToParentViewController:nil];
    self.drawerState = DrawerControllerStateClosing;
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerWillClose:)]) {
        [self.leftViewController drawerControllerWillClose:self];
    }
    if ([self.rightViewController respondsToSelector:@selector(drawerControllerWillClose:)]) {
        [self.rightViewController drawerControllerWillClose:self];
    }
}
#pragma mark ----动画收起右边页面过程
-(void)animationClose
{
    //断言
    NSParameterAssert(self.drawerState == DrawerControllerStateClosing);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    
    CGRect leftViewFinalFrame = self.leftView.frame;
    leftViewFinalFrame.origin.x = kICSDrawerControllerLeftViewInitialOffset;
    CGRect centerViewFinalFrame = self.view.bounds;
    
    [UIView animateWithDuration:kICSDrawerControllerAnimationDuration
                          delay:0
         usingSpringWithDamping:kICSDrawerControllerClosingAnimationSpringDamping
          initialSpringVelocity:kICSDrawerControllerClosingAnimationSpringInitialVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerView.frame = centerViewFinalFrame;
                         self.leftView.frame = leftViewFinalFrame;
                         
                         [self setNeedsStatusBarAppearanceUpdate];
                     }
                     completion:^(BOOL finished) {
                         [self didClose];
                     }];

}
#pragma mark ---- 收起右边页面结束
-(void)didClose
{
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.drawerState == DrawerControllerStateClosing);
    NSParameterAssert(self.rightViewController);
    
    [self.leftViewController.view removeFromSuperview];
    [self.leftViewController removeFromParentViewController];
    
    [self.leftView removeFromSuperview];
    
    self.drawerState = DrawerControllerStateClosed;
    
    [self removeClosingGestureRecognizer];
    
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerDidClose:)]) {
        [self.leftViewController drawerControllerDidClose:self];
    }
    if ([self.rightViewController respondsToSelector:@selector(drawerControllerDidClose:)]) {
        [self.rightViewController drawerControllerDidClose:self];
    }
}
#pragma mark ---- 拖动手势方法
-(void)panHandle:(UIPanGestureRecognizer *)pan
{
    CGPoint location = [pan locationInView:self.view];
    CGPoint velation = [pan velocityInView:self.view];
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.panGestureStartLocation = location;
            if(self.drawerState == DrawerControllerStateClosed)
            {
                [self willOpen];
            }
            else
            {
                [self willClose];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGFloat delta = 0.0f;
            if (self.drawerState == DrawerControllerStateOpening) {
                delta = location.x - self.panGestureStartLocation.x;
            }
            else if (self.drawerState == DrawerControllerStateClosing) {
                delta = kICSDrawerControllerDrawerDepth - (self.panGestureStartLocation.x - location.x);
            }
            
            CGRect l = self.leftView.frame;
            CGRect c = self.centerView.frame;
            if (delta > kICSDrawerControllerDrawerDepth) {
                l.origin.x = 0.0f;
                c.origin.x = kICSDrawerControllerDrawerDepth;
            }
            else if (delta < 0.0f) {
                l.origin.x = kICSDrawerControllerLeftViewInitialOffset;
                c.origin.x = 0.0f;
            }
            else {
                l.origin.x = kICSDrawerControllerLeftViewInitialOffset
                - (delta * kICSDrawerControllerLeftViewInitialOffset) / kICSDrawerControllerDrawerDepth;
                
                c.origin.x = delta;
            }
            self.leftView.frame = l;
            self.centerView.frame = c;
        }
            break;
        case UIGestureRecognizerStateEnded:
            if (self.drawerState == DrawerControllerStateOpening) {
                CGFloat centerViewLocation = self.centerView.frame.origin.x;
                if (centerViewLocation == kICSDrawerControllerDrawerDepth) {
                    [self setNeedsStatusBarAppearanceUpdate];
                    [self didOpen];
                }
                else if (centerViewLocation > self.view.bounds.size.width / 3
                         && velation.x > 0.0f) {
                    [self animationOpen];
                }
                else {
                    [self didOpen];
                    [self willClose];
                    [self animationClose];
                }
                
            } else if (self.drawerState == DrawerControllerStateClosing) {
                CGFloat centerViewLocation = self.centerView.frame.origin.x;
                if (centerViewLocation == 0.0f) {
                    [self setNeedsStatusBarAppearanceUpdate];
                    [self didClose];
                }
                else if (centerViewLocation < (2 * self.view.bounds.size.width) / 3
                         && velation.x < 0.0f) {
                    [self animationClose];
                }
                else {
                 
                    [self didClose];
                    
                    CGRect l = self.leftView.frame;
                    [self willOpen];
                    self.leftView.frame = l;
                    
                    [self animationOpen];
                }
            }

            break;
    
            
        default:
            break;
    }
}


-(void)open
{
    NSParameterAssert(self.drawerState == DrawerControllerStateClosed);
    [self willOpen];
    [self animationOpen];
}
-(void)willOpen
{
    NSParameterAssert(self.drawerState == DrawerControllerStateClosed);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.rightViewController);
    
    
    self.drawerState = DrawerControllerStateOpening;
    
    CGRect f = self.view.bounds;
    f.origin.x = kICSDrawerControllerLeftViewInitialOffset;
    NSParameterAssert(f.origin.x < 0.0f);
    self.leftView.frame = f;
    
    [self addChildViewController:self.leftViewController];
    self.leftViewController.view.frame = self.view.bounds;
    [self.leftView addSubview:self.leftViewController.view];
    
    [self.view insertSubview:self.leftView belowSubview:self.centerView];
    
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerWillOpen:)]) {
        [self.leftViewController drawerControllerWillOpen:self];
    }
    if ([self.rightViewController respondsToSelector:@selector(drawerControllerWillOpen:)]) {
        [self.rightViewController drawerControllerWillOpen:self];
    }
    
}
-(void)animationOpen
{
    NSParameterAssert(self.drawerState == DrawerControllerStateOpening);
    NSParameterAssert(self.leftView);
    NSParameterAssert(self.centerView);
    
    CGRect leftViewFinalFrame = self.view.bounds;
    CGRect centerViewFinalFrame = self.view.bounds;
    centerViewFinalFrame.origin.x = kICSDrawerControllerDrawerDepth;
    
    [UIView animateWithDuration:kICSDrawerControllerAnimationDuration
                          delay:0
         usingSpringWithDamping:kICSDrawerControllerOpeningAnimationSpringDamping
          initialSpringVelocity:kICSDrawerControllerOpeningAnimationSpringInitialVelocity
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.centerView.frame = centerViewFinalFrame;
                         self.leftView.frame = leftViewFinalFrame;
                         
                         [self setNeedsStatusBarAppearanceUpdate];
                     }
                     completion:^(BOOL finished) {
                         [self didOpen];
                     }];

}
-(void)didOpen
{
    NSParameterAssert(self.drawerState == DrawerControllerStateOpening);
    NSParameterAssert(self.leftViewController);
    NSParameterAssert(self.rightViewController);
    
    // Complete adding the left controller to the container
    [self.leftViewController didMoveToParentViewController:self];
    
    [self addClosingGestureRecognizer];
    
    // Keep track that the drawer is open
    self.drawerState = DrawerControllerStateOpen;
    
    // Notify the child view controllers that the drawer is open
    if ([self.leftViewController respondsToSelector:@selector(drawerControllerDidOpen:)]) {
        [self.leftViewController drawerControllerDidOpen:self];
    }
    if ([self.rightViewController respondsToSelector:@selector(drawerControllerDidOpen:)]) {
        [self.rightViewController drawerControllerDidOpen:self];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
