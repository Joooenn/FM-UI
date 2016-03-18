//
//  SRHTTPManager.h
//  Shareling
//
//  Created by 深圳市深软信息技术有限公司 on 15/12/10.
//  Copyright © 2015年 深圳市深软信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^returnBlock)(id obj, NSError *error);

@interface LHTTPManager : NSObject

//发起get请求
+ (void)getWithUrlString:(NSString *)urlStr andParam:(NSDictionary *)param returnBlock:(returnBlock)block;
//发起post请求
+ (void)postWithUrlString:(NSString *)urlStr andParam:(NSDictionary *)param returnBlock:(returnBlock)block;

//发起get(session)请求
+ (void)sessionGetWithUrlString:(NSString *)urlStr andparam:(NSDictionary *)param returnBlock:(returnBlock)block;
//发起post(session)请求
+ (void)sessionPostWithUrlString:(NSString *)urlStr andparam:(NSDictionary *)param returnBlock:(returnBlock)block;

//异步加载图片
+ (void)setImageView:(UIImageView *)imageView withUrlString:(NSString *)imageUrlStr;

//获取userid
+ (NSString *)userNum;
//alert
+ (void)alertWithString:(NSString *)str onCtl:(UIViewController *)ctl;
//获取sb控制器
+ (UIViewController *)getCtl:(NSString *)ctlStr;
//字典转字符串
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
//获取拼接、加密后的url
+ (NSString *)getUrlByHost:(NSString *)host andParam:(NSMutableDictionary *)param;

//获取拼接了加密sign的字典
+ (NSDictionary *)getDictWithMethod:(NSString *)method andParamDict:(NSDictionary *)dict;

//判别手机号验证码邀请码状态
+ (NSString *)stateForNumber:(NSString *)number andCheckCode:(NSString *)checkCode;
//验证码验证
+ (BOOL)stateForCheckCode:(NSString *)code withCtl:(UIViewController *)ctl;
//名字验证
+ (BOOL)stateForName:(NSString *)name withCtl:(UIViewController *)ctl;
//邮政编码验证
+ (BOOL)stateForMail:(NSString *)mail withCtl:(UIViewController *)ctl;
//手机号码验证
+ (BOOL)stateForPhoneNumber:(NSString *)number withCtl:(UIViewController *)ctl;

//展示没有相关信息
+ (void)showMessageNoneInView:(UIView *)view;

//是否登录
+ (BOOL)isLogin;

@end
