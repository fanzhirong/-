//
//  MainViewController.m
//  医药大典
//
//  Created by qf on 15/10/14.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "MainViewController.h"
#import "DetailViewController.h"
#import "FirstViewController.h"
#import "TitleViewController.h"
#import "DetailOneViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViews];
}

-(void)setViews
{
    TitleViewController *titleVc = [[TitleViewController alloc]init];
    DetailViewController *detailVc = [[DetailViewController alloc]init];
    FirstViewController *firstVc = [[FirstViewController alloc]initWithLeft:titleVc rightViewController:detailVc];
    [self.view addSubview:firstVc.view];
    [self addChildViewController:firstVc];
    
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
