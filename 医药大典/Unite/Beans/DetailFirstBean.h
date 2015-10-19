//
//  DetailFirstBean.h
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailFirstBean : NSObject


@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *date;
@property (nonatomic,copy)NSString *auther;
@property (nonatomic,copy)NSString *url;

+(DetailFirstBean *)DetailNetDataToBean:(NSDictionary *)dict;
+(NSArray *)DetailNetDataToArray:(NSArray *)arr;
@end
