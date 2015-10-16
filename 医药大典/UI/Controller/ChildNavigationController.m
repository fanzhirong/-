//
//  ChildNavigationController.m
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "ChildNavigationController.h"

@interface ChildNavigationController ()

@end

@implementation ChildNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)drawerControllerDidClose:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = YES;
}

-(void)drawerControllerWillOpen:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
