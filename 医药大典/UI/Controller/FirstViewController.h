//
//  FirstViewController.h
//  医药大典
//
//  Created by qf on 15/10/14.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明协议
@protocol DrawerControllerChild ;
@protocol DrawercontrollerHandler;


@interface FirstViewController : UIViewController

//声明两个控制器
@property (nonatomic,strong)UIViewController<DrawerControllerChild,DrawercontrollerHandler> *leftViewController;
@property (nonatomic,strong)UIViewController<DrawerControllerChild,DrawercontrollerHandler> *rightViewController;


//声明方法
-(void)open;
-(void)close;

-(void)reloadCenterControllerUsingBlock:(void(^)(void))reloadBlock;
-(void)reloadCenterControllerWithViewController:(UIViewController<DrawerControllerChild,DrawercontrollerHandler>*)centerViewController;

-(id)initWithLeft:(UIViewController<DrawerControllerChild,DrawercontrollerHandler>*)leftViewController rightViewController:(UIViewController<DrawerControllerChild,DrawercontrollerHandler>*)rightViewController;
@end



//定义协议
@protocol DrawerControllerChild <NSObject>

@property (nonatomic,weak)FirstViewController *drawer;

@end

@protocol DrawercontrollerHandler <NSObject>

@optional

-(void)drawerControllerWillOpen:(FirstViewController *)drawrController;
-(void)drawerControllerDidOpen:(FirstViewController *)drawrController;
-(void)drawerControllerWillClose:(FirstViewController *)drawrController;
-(void)drawerControllerDidClose:(FirstViewController *)drawrController;

@end