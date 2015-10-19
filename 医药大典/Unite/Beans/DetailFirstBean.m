//
//  DetailFirstBean.m
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "DetailFirstBean.h"

@implementation DetailFirstBean

+(DetailFirstBean *)DetailNetDataToBean:(NSDictionary *)dict
{
    DetailFirstBean *bean = [[DetailFirstBean alloc]init];
    bean.title = dict[@"title"];
    bean.content = dict[@"content"];
    bean.date = dict[@"date"];
    bean.auther = dict[@"author"][@"name"];
    bean.url = dict[@"url"];
    return bean;
}
+(NSArray *)DetailNetDataToArray:(NSArray *)arr
{
    NSMutableArray *detailArr = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        DetailFirstBean *bean = [DetailFirstBean DetailNetDataToBean:dic];
        [detailArr addObject:bean];
    }
    return detailArr;
}
@end
