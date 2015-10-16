//
//  ChildViewController.m
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "ChildViewController.h"
#import "FirstViewController.h"
@interface ChildViewController ()

@end


@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setViews];
    
}

-(void)setViews
{
    self.navigationItem.title = @"妇科药方";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
