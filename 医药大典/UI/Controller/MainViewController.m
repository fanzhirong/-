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
#import "FacialNavigationController.h"
#import "FacialFirstViewController.h"
#import "ChildNavigationController.h"
#import "ChildViewController.h"
#import "InternalNavigationController.h"
#import "InternalViewController.h"
#import "ChirurgeryNavigationController.h"
#import "ChirurgeryViewController.h"
#import "GynaecologyNavigationController.h"
#import "GynaecologyViewController.h"
#import "MaleNavigationController.h"
#import "MaleViewController.h"
#import "SkinNavigationController.h"
#import "SkinViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self setViews];
}

-(void)setViews
{
    TitleViewController *titleVc = [[TitleViewController alloc]init];
    
    
    DetailOneViewController *detailOVc = [[DetailOneViewController alloc]init];
    DetailViewController *detailVc = [[DetailViewController alloc]initWithRootViewController:detailOVc];
    
    FacialFirstViewController *facialVc = [[FacialFirstViewController alloc]init];
    FacialNavigationController *facialNVc = [[FacialNavigationController alloc]initWithRootViewController:facialVc];
    
    ChildViewController *childVc = [[ChildViewController alloc]init];
    ChildNavigationController *childNVc = [[ChildNavigationController alloc]initWithRootViewController:childVc];
    
    InternalViewController *interVc = [[InternalViewController alloc]init];
    InternalNavigationController *interNvc = [[InternalNavigationController alloc]initWithRootViewController:interVc];
    
    ChirurgeryViewController *chiruVc = [[ChirurgeryViewController alloc]init];
    ChirurgeryNavigationController *chiruNvc = [[ChirurgeryNavigationController alloc]initWithRootViewController:chiruVc];
    
    GynaecologyViewController *gyVc = [[GynaecologyViewController alloc]init];
    GynaecologyNavigationController *gyNvc = [[GynaecologyNavigationController alloc]initWithRootViewController:gyVc];
    
    MaleViewController *maleVc = [[MaleViewController alloc]init];
    MaleNavigationController *maleNvc = [[MaleNavigationController alloc]initWithRootViewController:maleVc];
    
    SkinViewController *skinVc = [[SkinViewController alloc]init];
    SkinNavigationController *skinNvc = [[SkinNavigationController alloc]initWithRootViewController:skinVc];
    
    FirstViewController *firstVc = [[FirstViewController alloc]initWithLeft:titleVc rightViewController:detailVc];
    
    [firstVc.controllArr addObject:detailVc];
    [firstVc.controllArr addObject:facialNVc];
    [firstVc.controllArr addObject:childNVc];
    [firstVc.controllArr addObject:interNvc];
    [firstVc.controllArr addObject:chiruNvc];
    [firstVc.controllArr addObject:gyNvc];
    [firstVc.controllArr addObject:maleNvc];
    [firstVc.controllArr addObject:skinNvc];
  
    
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
