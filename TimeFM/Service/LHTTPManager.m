//
//  SRHTTPManager.m
//  Shareling
//
//  Created by 深圳市深软信息技术有限公司 on 15/12/10.
//  Copyright © 2015年 深圳市深软信息技术有限公司. All rights reserved.
//

#import "LHTTPManager.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "Toast+UIView.h"

@implementation LHTTPManager

//发起get请求
+ (void)getWithUrlString:(NSString *)urlStr andParam:(NSDictionary *)param returnBlock:(returnBlock)block{
    
    static AFHTTPRequestOperationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        manager = [AFHTTPRequestOperationManager manager];
        
    });
    
    //发起请求
    [manager GET:urlStr parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        //成功回调
        block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        //失败回调
        block(nil, error);
        
    }];
}

//发起post请求
+ (void)postWithUrlString:(NSString *)urlStr andParam:(NSDictionary *)param returnBlock:(returnBlock)block{
    
    static AFHTTPRequestOperationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken ,^{
    
        manager = [AFHTTPRequestOperationManager manager];
    });
    
    //发起请求
    [manager POST:urlStr parameters:param success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        //成功回调
        block(responseObject, nil);
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
       
        //失败回调
        block(nil, error);
        
    }];
    
}
//发起get(NSURLSession)请求
+ (void)sessionGetWithUrlString:(NSString *)urlStr andparam:(NSDictionary *)param returnBlock:(returnBlock)block{
    
    static AFHTTPSessionManager *sessionManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        sessionManager = [AFHTTPSessionManager manager];
    });

    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [sessionManager GET:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //成功
        block(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败
        block(nil, error);
    }];
}
//发起post(NSURLSession)请求
+ (void)sessionPostWithUrlString:(NSString *)urlStr andparam:(NSDictionary *)param returnBlock:(returnBlock)block{

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
#if 0
    [sessionManager POST:urlStr parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        
    }];
#else
    [sessionManager POST:urlStr parameters:param success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        //成功
        block(responseObject, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //失败
        block(nil, error);
    }];

#endif
}


//异步加载图片
+ (void)setImageView:(UIImageView *)imageView withUrlString:(NSString *)imageUrlStr{
    
    //给imageView设置图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:nil];
    
}
//获取userid
+(NSString *)userNum{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/infor.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    if ([dict[@"userid"] length] != 0) {
        return dict[@"userid"];
    } else {
        return @"";
    }
    
}


/**
 *  alertCtl
 *
 *  @param str 需要展示的文字信息
 */
+ (void)alertWithString:(NSString *)str onCtl:(UIViewController *)ctl{
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtl addAction:okAction];
    
    [ctl presentViewController:alertCtl animated:YES completion:nil];
}
/**
 *  获取sb中的控制器
 *
 *  @param ctlStr 想要得到的控制器名
 *
 *  @return 想要的控制器
 */
+ (UIViewController *)getCtl:(NSString *)ctlStr {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return  [main instantiateViewControllerWithIdentifier:ctlStr];
    
}
//字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
//获取URL
+ (NSString *)getUrlByHost:(NSString *)host andParam:(NSMutableDictionary *)param{

    NSMutableString *url = [NSMutableString stringWithString:host];
    
    //获取验证码
    if ([param[@"method"] isEqualToString:@"user.check"]) {
        
        for (NSString *key in [param allKeys]) {
            
            NSLog(@"%@%@",key, param[key]);
            [url appendString:[NSString stringWithFormat:@"%@%@%@%@",key,@"=",param[key],@"&"]];
            
        }
    }else if ([param[@"method"] isEqualToString:@"user.regist"]) {
        
        for (NSString *key in [param allKeys]) {
            
            NSLog(@"%@%@",key, param[key]);
            [url appendString:[NSString stringWithFormat:@"%@%@%@%@",key,@"=",param[key],@"&"]];
            
        }
        
    }
    
    //生成动态签名并拼接
    [url appendString:[NSString stringWithFormat:@"%@%@",@"sign=",[LMD5 createSignWithDictionary:param]]];
    NSLog(@"----->%@",url);

    return url;
}
//获取拼接了加密后的sign的字典param
+ (NSDictionary *)getDictWithMethod:(NSString *)method andParamDict:(NSDictionary *)dict{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"appKey":@"00001",@"v":@"1.0",@"method":method,@"messageFormat":@"json"}];
    
        
    [param addEntriesFromDictionary:dict];
    
    
    //签名
    NSString *sign = [LMD5 createSignWithDictionary:param];
    //NSLog(@"sign-->%@",sign);
    [param setValue:sign forKey:@"sign"];
    NSLog(@"param-->%@",param);
    
    return param;
}

//判别手机号验证码状态
+ (NSString *)stateForNumber:(NSString *)number andCheckCode:(NSString *)checkCode{

    if ([LMD5 checkTelNumber:number]) {
        
        if (checkCode.length == 4) {
            
            return @"right";
        }else {
            
            return @"验证码格式错误!";
        }
    }else {
        
        if (number.length == 0) {
            
            return @"手机号不能为空!";
        }
        return @"手机号格式错误!";
    }
    

}
//验证码验证
+ (BOOL)stateForCheckCode:(NSString *)code withCtl:(UIViewController *)ctl{
    
    if (code.length == 0) {
        
        [ctl.view makeToast:@"验证码不能为空!" duration:2.0 position:nil];
        return NO;
    }else {
    
        if ([LMD5 checkCode:code]) {
            
            NSLog(@"checkCode is right");
            return YES;
        }else {
            
            [ctl.view makeToast:@"验证码错误!" duration:2.0 position:nil];
            return NO;
        }
    }
    
}
//名字验证
+ (BOOL)stateForName:(NSString *)name withCtl:(UIViewController *)ctl{
    
    if (name.length != 0) {
        
        NSLog(@"name is right");
        return YES;
    }else {
        
        [ctl.view makeToast:@"收件人姓名不能为空!" duration:2.0 position:nil];
        return NO;
    }
}
//邮政编码验证
+ (BOOL)stateForMail:(NSString *)mail withCtl:(UIViewController *)ctl{
    
    if ([LMD5 validateMail:mail]) {
        
        NSLog(@"mail is right");
        return YES;
    }else {
        
        [ctl.view makeToast:@"邮政编码错误!" duration:2.0 position:nil];
        return NO;
    }
}
//手机号码验证
+ (BOOL)stateForPhoneNumber:(NSString *)number withCtl:(UIViewController *)ctl{
    
    if([LMD5 checkTelNumber:number] && number.length == 11){
        
        NSLog(@"number is right");
        return YES;
    }else{
        
        if (number.length != 0) {
            
            [ctl.view makeToast:@"请输入正确的手机号码!" duration:2.0 position:nil];
        }else {
            
            [ctl.view makeToast:@"手机号码不能为空!" duration:2.0 position:nil];
        }
        return NO;
    }
}

+ (void)showMessageNoneInView:(UIView *)view {
    
    UITableView *tableView = (UITableView *)view;
    
    static UILabel *msgLable;
    if (msgLable == nil) {
        
        msgLable = [[UILabel alloc] init];
        msgLable.text = @"暂时没有相关记录";
        msgLable.textAlignment = NSTextAlignmentCenter;
        [msgLable setTextColor:[UIColor grayColor]];
        msgLable.font = [UIFont systemFontOfSize:13.0];
        
        tableView.backgroundView = msgLable;
        [msgLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(tableView);
            
        }];

    }
    
}

+ (BOOL)isLogin {
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
}

@end
