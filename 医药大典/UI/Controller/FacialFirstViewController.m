//
//  FacialFirstViewController.m
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "FacialFirstViewController.h"
#import "FirstViewController.h"
@interface FacialFirstViewController ()

@end

@implementation FacialFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setViews];
    // Do any additional setup after loading the view.
}
-(void)setViews
{
    self.navigationItem.title = @"五官药方";
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"reveal-icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setSelected:NO];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftItem];
}

-(void)buttonClick:(UIButton *)button
{
    UINavigationController <DrawerControllerChild,DrawercontrollerHandler>*viewController = (UINavigationController<DrawerControllerChild,DrawercontrollerHandler>*)self.navigationController;
    
    [viewController.drawer drawController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
