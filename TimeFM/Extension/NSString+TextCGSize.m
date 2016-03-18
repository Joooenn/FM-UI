//
//  NSString+TextCGSize.m
//  Shareling
//
//  Created by 深圳市深软信息技术有限公司 on 16/1/18.
//  Copyright © 2016年 深圳市深软信息技术有限公司. All rights reserved.
//

#import "NSString+TextCGSize.h"

@implementation NSString (TextCGSize)

//返回字符串所占用的尺寸.
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
