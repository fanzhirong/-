//
//  TitleViewController.m
//  医药大典
//
//  Created by qf on 15/10/14.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "TitleViewController.h"

@interface TitleViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UITableView *table;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,assign)NSInteger previousRow;


@end

@implementation TitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self initData];
    [self setTableView];
}

-(void)initData
{
    self.dataArray = [[NSMutableArray alloc]initWithArray:@[@"首页",@"五官偏方",@"儿科偏方",@"内科偏方",@"外科偏方",@"妇科偏方",@"男科偏方",@"皮肤偏方",@"关于我们"]];
}
-(void)setTableView
{
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 260.0f, 9*50+44)];
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
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"药典大全";
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
