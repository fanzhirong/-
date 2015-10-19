//
//  GynaecologyNavigationController.m
//  医药大典
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "GynaecologyNavigationController.h"

@interface GynaecologyNavigationController ()

@end

@implementation GynaecologyNavigationController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
