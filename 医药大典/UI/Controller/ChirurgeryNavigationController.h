//
//  ChirurgeryNavigationController.h
//  医药大典
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
@interface ChirurgeryNavigationController : UINavigationController<DrawerControllerChild,DrawercontrollerHandler>
@property (nonatomic,weak)FirstViewController *drawer;
@end
