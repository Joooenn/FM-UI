//
//  RegisterViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/16.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "RegisterOrFoegetPwViewController.h"

@interface RegisterOrFoegetPwViewController ()

@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UITextField *pwTf;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
@property (weak, nonatomic) IBOutlet UITextField *checkCodeTf;

//标识,是否已发送短信验证码
@property (nonatomic, assign)NSInteger isSendcode;

@end

@implementation RegisterOrFoegetPwViewController

- (void)loadView {
    
    [super loadView];
    
    //title
    if (self.flag == 0) {
        
        self.titleLable.text = @"快速注册";
    }else {
        
        self.titleLable.text = @"重置密码";
    }
    
    //圆角
    [self.okBtn.layer setCornerRadius:5.0];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击事件
//点击屏幕使键盘落下
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
//获取验证码
- (IBAction)getCheckcodeAction:(id)sender {
    
    [self.view endEditing:YES];
    __block int timeout = 60; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){
            //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置

                [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.codeBtn setBackgroundColor:RGBACOLOR(70, 187, 255, 1.0)];
                self.codeBtn.highlighted = NO;
                self.codeBtn.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout;
            
            NSString *strTime = [NSString stringWithFormat:@"重新获取(%.2ds)", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置界面的按钮显示 根据自己需求设置
                
                self.codeBtn.titleLabel.text = [NSString stringWithFormat:@"%@",strTime];
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                [self.codeBtn setBackgroundColor:RGBACOLOR(153, 153, 153, 1.0)];
                self.codeBtn.highlighted = NO;
                self.codeBtn.userInteractionEnabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
    
    //获取验证码请求(做手机号判别)
    if ([LHTTPManager stateForPhoneNumber:self.phoneNumTf.text withCtl:self]) {
    
        [LHTTPManager getWithUrlString:HOST andParam:[LHTTPManager getDictWithMethod:@"user.check" andParamDict:@{@"number":self.phoneNumTf.text}] returnBlock:^(id obj, NSError *error) {
            
            if (error) {
                
                NSLog(@"error = %@",error);
            }else {
                
                if (obj[@"codeFlag"]) {
                    
                    if ([obj[@"codeFlag"] integerValue] == 1) {
                        //请求成功
                        NSLog(@"success obj = %@",obj);
                        
                        [self.view makeToast:obj[@"message"] duration:2.0 position:nil];
                        
                    }else {
                        //失败。后台返回错误信息
                        
                        NSLog(@"%@",obj);
                    }
                    
                }else{
                    //系统错误
                    
                    
                    NSLog(@" obj = %@, message = %@",obj, obj[@"message"]);
                }
                
                NSLog(@"obj-code = %@, obj-object = %@, obj-message = %@",obj[@"code"],obj[@"object"],obj[@"message"]);
                
            }
            
        }];
    
    }
    
    
    
    if (self.flag == 0) {
        //注册
        
        
    }else {
        //重置密码
        
        
    }
    
}
//确定
- (IBAction)okAction:(id)sender {
    
    if (self.flag == 0) {
        //注册
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }else {
        //重置密码
        
        
        
    }
    
}
//返回上一界面
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
