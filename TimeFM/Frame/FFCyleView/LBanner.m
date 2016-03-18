//
//  LBanner.m
//
//  Created by 深圳市深软信息技术有限公司 on 15/12/31.
//  Copyright © 2015年 深圳市深软信息技术有限公司. All rights reserved.
//

#import "LBanner.h"

@implementation LBanner

- (void)setValue:(id)value forKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        [self setValue:value forKey:@"banner_id"];
    }else {
        
        [super setValue:value forKey:key];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"UndefinedKey:%@",key);
    
}

@end
