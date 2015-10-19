//
//  NetWorking.m
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "NetWorking.h"
#import <AFNetworking.h>

#import "DetailFirstBean.h"
@implementation NetWorking


+(void)getDetailFirstDataWithPath:(NSString *)path page:(NSUInteger)page back:(DetailFirstReturnBlock)block fail:(failBlock)falblock
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@&page=%ld",path,(long)page];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dic[@"posts"];
       NSArray *arr = [DetailFirstBean DetailNetDataToArray:array];
        block(arr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        falblock();
    }];
}
+(void)getVersionWith:(NSString *)path back:(versionBlock)block
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        block(dic[@"results"][0][@"version"]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}
@end
