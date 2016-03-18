//
//  LoginViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/15.
//  Copyright © 2016年 SR. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterOrFoegetPwViewController.h"
#import "LTabBarViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTf;
@property (weak, nonatomic) IBOutlet UITextField *pwTf;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController

- (void)loadView {
    
    [super loadView];
    
    self.loginBtn.layer.cornerRadius = 5.0;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LTabBarViewController *tabbarCtl = [main instantiateViewControllerWithIdentifier:@"LTabBarViewController"];
    
    
    tabbarCtl.tabBarView.hidden = YES;

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     LTabBarViewController *tabbarCtl = [main instantiateViewControllerWithIdentifier:@"LTabBarViewController"];
     
     
     tabbarCtl.tabBarView.hidden = NO;

}
#pragma mark - 点击事件
//点击屏幕使键盘落下
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
//登录
- (IBAction)loginAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
//    AppDelegate *del = [UIApplication sharedApplication].delegate;
//    del.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LTabBarViewController"];
//    [del.window makeKeyAndVisible];
}
//微信登录
- (IBAction)wetchatLoginAction:(id)sender {
    
    
    
}
//QQ登录
- (IBAction)QQLoginAction:(id)sender {
    
    
}
//新浪微博登录
- (IBAction)sinaLoginAction:(id)sender {
    
    
}
//忘记密码
- (IBAction)forgetPwAction:(id)sender {
    
    [self performSegueWithIdentifier:@"ForgetPw" sender:nil];
    
}
//快速注册
- (IBAction)registerAction:(id)sender {
    
    [self performSegueWithIdentifier:@"Register" sender:nil];
}
//传值方法
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    RegisterOrFoegetPwViewController *ctl = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"Register"]) {
        
        ctl.flag = 0;
    }else {
        
        ctl.flag = 1;
    }

}

@end
