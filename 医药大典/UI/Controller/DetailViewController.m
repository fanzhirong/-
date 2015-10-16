//
//  DetailViewController.m
//  医药大典
//
//  Created by qf on 15/10/14.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self setViews];
}

-(void)setViews
{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20, 44, 44)];
    [button setImage:[UIImage imageNamed:@"reveal-icon"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}
-(void)drawerControllerWillOpen:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = NO;
}
-(void)drawerControllerDidClose:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = YES;
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
