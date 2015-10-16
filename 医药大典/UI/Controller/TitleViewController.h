//
//  TitleViewController.h
//  医药大典
//
//  Created by qf on 15/10/14.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
@interface TitleViewController : UIViewController<DrawerControllerChild,DrawercontrollerHandler>


@property (nonatomic,weak)FirstViewController *drawer;
@end
