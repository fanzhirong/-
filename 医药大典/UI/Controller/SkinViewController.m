//
//  SkinViewController.m
//  医药大典
//
//  Created by qf on 15/10/17.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "SkinViewController.h"
#import <MJRefresh.h>
#import "NetWorking.h"
#import "DetailFirstBean.h"
#import "DetailFirstTableViewCell.h"
#import "DetailSecondViewController.h"
#import "FirstViewController.h"
@interface SkinViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,assign)NSUInteger page;
@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UITableView *table;

@end

@implementation SkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setViews];
    [self setTableView];
    [self getNetData];
    
}
-(void)initData
{
    self.page = 0;
    self.dataArray = [[NSMutableArray alloc]init];
}
-(void)getNetData
{
    if (self.page == 0)
    {
        [NetWorking getDetailFirstDataWithPath:SkinPath page:self.page back:^(NSArray *arr) {
            self.dataArray = [NSMutableArray arrayWithArray:arr];
            [self.table.header endRefreshing];
            [_table reloadData];
        } fail:^{
            [self.table.header endRefreshing];
        }];
    }
    else
    {
        [NetWorking getDetailFirstDataWithPath:SkinPath page:self.page back:^(NSArray *arr) {
            for (id object in arr) {
                [self.dataArray addObject:object];
                [self.table.footer endRefreshing];
                [_table reloadData];
                
            }
        } fail:^{
           
        }];
    }
    
    
}


-(void)setViews
{
    self.navigationItem.title = @"皮肤科药方";
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:[UIImage imageNamed:@"reveal-icon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setSelected:NO];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    
      [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"blur.jpg"] forBarMetrics:UIBarMetricsDefault];
}

-(void)buttonClick:(UIButton *)button
{
    UINavigationController <DrawerControllerChild,DrawercontrollerHandler>*viewController = (UINavigationController<DrawerControllerChild,DrawercontrollerHandler>*)self.navigationController;
    
    [viewController.drawer drawController];
}
-(void)setTableView
{
    _table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
    
    _table.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headFresh)];
    [_table.header beginRefreshing];
    
    _table.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footFresh)];
}

-(void)headFresh
{
    self.page = 0;
    [self getNetData];
}

-(void)footFresh
{
    self.page ++;
    [self getNetData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy = @"cell";
    DetailFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell = [[DetailFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    [cell setCellData:self.dataArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailSecondViewController *DetailSVc = [[DetailSecondViewController alloc]init];
    DetailFirstBean *bean = self.dataArray[indexPath.row];
    DetailSVc.object = bean;
    [self.navigationController pushViewController:DetailSVc animated:YES];
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
