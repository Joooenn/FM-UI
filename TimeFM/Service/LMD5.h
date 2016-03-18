//
//  MyMD5.h
//  Shareling
//
//  Created by 深圳市深软信息技术有限公司 on 16/1/14.
//  Copyright © 2016年 深圳市深软信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface LMD5 : NSObject

// MD5加密
+ (NSString *) md5:(NSString *)str;
// 文件MD5效验
+(BOOL)fileEffectWithMd5:(NSString *)md5 filePath:(NSString *)filePath;

// url编码
+ (NSString *) urlencode: (NSString *) url;

// base64编码
+ (NSString *)base64EncodedStringFrom:(NSData *)data;

// SHA1加密
+ (NSString *) sha1:(NSString *)str;

// 数字签名
+(NSString *)createSignWithDictionary:(NSMutableDictionary *)signInfo;
// 创建Url
+(NSString *)createUrlWithDictionary:(NSDictionary *)signInfo Sign:(NSString *)sign;
// 创建轨迹查看Url
+(NSString *)createTrackUrlWithDictionary:(NSDictionary *)signInfo Sign:(NSString *)sign;
// 创建意见反馈查看Url
+(NSString *)createSuggestUrlWithDictionary:(NSDictionary *)signInfo Sign:(NSString *)sign;

//判断邮箱格式的正则表达式
+(BOOL) validateEmail:(NSString *)email;
//判断邮政编码格式的正则表达式
+(BOOL)validateMail:(NSString *)mail;
//判断密码的正则表达式,请用下面那个
+(BOOL) validatePassword:(NSString *)passWord;
//判断密码强度
+(int)judgePasswordStrength:(NSString*)password;

//判断手机号码的正则表达式
+(BOOL)checkPhoneNumInput:(NSString *)phone;

//获取星期几
+(NSString *)getWeekStringWithDate:(NSDate *)date;

// 获取userAgent
+(NSString *)getUserAgent;
// 判断是否为确定位数纯数字
+(BOOL)isPureInt:(NSString *)string withNum:(int) num;
// 判断是否为一串数字
+(BOOL)isPureInt:(NSString *)string;

//在中国
+(BOOL)isInChina;

//中文环境
+ (BOOL)isChina;
// 坐标偏移算法
+ (CLLocationCoordinate2D)locationTransFromWGSToGCJ:(CLLocationCoordinate2D)wgLoc;
//判断手机号码的正则表达式
+ (BOOL)checkTelNumber:(NSString*) telNumber;
//验证码正则表达式
+ (BOOL)checkCode:(NSString *)code;
@end
