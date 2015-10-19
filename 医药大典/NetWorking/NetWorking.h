//
//  NetWorking.h
//  医药大典
//
//  Created by qf on 15/10/16.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DetailFirstReturnBlock)(NSArray *arr);
typedef void(^versionBlock)(NSString *object);
typedef void(^failBlock)(void);
@interface NetWorking : NSObject


+(void)getDetailFirstDataWithPath:(NSString *)path page:(NSUInteger)page back:(DetailFirstReturnBlock)block fail:(failBlock)falblock;
+(void)getVersionWith:(NSString *)path back:(versionBlock)block;
@end
