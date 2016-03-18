//
//  BannerViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/18.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "BannerViewController.h"
#import <WebKit/WebKit.h>

@interface BannerViewController ()
<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong)WKWebView *webView;

@property (weak, nonatomic) IBOutlet UILabel *bannerName;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImg;
@property (weak, nonatomic) IBOutlet UITextView *ContontsTextView;

@end

@implementation BannerViewController

- (void)loadView {
    [super loadView];
    
    if (self.isHtml) {
        //网页
        
        [self.bannerName removeFromSuperview];
        [self.bannerImg removeFromSuperview];
        [self.ContontsTextView removeFromSuperview];
        
        [self setWKWebView];
        
    }else {
        //原生界面
        
        
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setWKWebView {
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight - 64)];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.webView];
}
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
