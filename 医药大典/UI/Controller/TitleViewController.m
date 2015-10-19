//
//  TitleViewController.m
//  医药大典
//
//  Created by qf on 15/10/14.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "TitleViewController.h"
#import "AlertManager.h"
#import "NetWorking.h"

#define APP_STORE_ID @"id1044488392"
#define VERSION_UPDATE @"http://itunes.apple.com/lookup?id=1044488392"

@interface TitleViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger previousRow;


@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DCOLOR(146, 206, 248, 1);
    [self initData];
    [self setTableView];
}

-(void)initData
{
    self.dataArray = [[NSMutableArray alloc]initWithArray:@[@"首页",@"五官偏方",@"儿科偏方",@"内科偏方",@"外科偏方",@"妇科偏方",@"男科偏方",@"皮肤偏方",@"软件版本"]];
}
-(void)setTableView
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 260.0f, 9*40+30)];
    _table.delegate = self;
    _table.dataSource = self;
    _table.bounces = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_table];
    
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy = @"cell";
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identy];
        
    }
    cell.backgroundColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    if (indexPath.row == 8) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        NSString *str = [NSString stringWithFormat:@"%@    V%@",self.dataArray[indexPath.row],version];
        cell.textLabel.text = str;
    }
    else
    {
         cell.textLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *hview = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    hview.backgroundColor = DCOLOR(146, 206, 248, 1);
    hview.text = @"   药典大全";
    hview.font = [UIFont systemFontOfSize:20];
    hview.textColor = [UIColor whiteColor];
    return hview;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(void)updateVersion{
    [NetWorking getVersionWith:VERSION_UPDATE back:^(NSString *object) {
        [AlertManager hidden];
        
        //获取app当前版本号
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        
        
        
        float v1 = version.floatValue;
        float v2 = object.floatValue;
        if (v2 > v1) {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"版本提示" message:@"发现新版本！" delegate:self cancelButtonTitle:@"下次提醒" otherButtonTitles:@"现在更新", nil];
            view.tag = 888;
            [view show];
        } else {
            UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"版本提示" message:@"当前已是最新版本！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            view.tag = 888;
            [view show];
        }
    }];
}
//提示框 itms-apps://itunes.apple.com/app/id1044488392
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1 && alertView.tag == 888) {
        NSString * url = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", APP_STORE_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 8) {
        [self updateVersion];
    }
    else
    {
    if (indexPath.row == self.previousRow) {
        [self.drawer close];
    }
    else
    {
    [self.drawer reloadCenterControllerWithViewController:indexPath.row];
    }
    self.previousRow = indexPath.row;
    }
}
-(void)drawerControllerWillOpen:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = NO;
}
-(void)drawerControllerDidOpen:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = YES;
}
-(void)drawerControllerWillClose:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = NO;
}
-(void)drawerControllerDidClose:(FirstViewController *)drawrController
{
    drawrController.view.userInteractionEnabled = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
