//
//  ShadowView.m
//  医药大典
//
//  Created by qf on 15/10/15.
//  Copyright (c) 2015年 fanzhirong. All rights reserved.
//

#import "ShadowView.h"

@implementation ShadowView


-(void)drawRect:(CGRect)rect
{
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 0.7f;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = shadowPath.CGPath;
}
@end
