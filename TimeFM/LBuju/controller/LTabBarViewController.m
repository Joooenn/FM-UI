//
//  LTabBarViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/16.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "LTabBarViewController.h"
#import "FMMusicViewController.h"
#import "FrameViewController.h"
#import "FMPlaymusicView.h"

@interface LTabBarViewController ()

@property (nonatomic, strong)UIButton *playBtn;
@property (nonatomic, strong)UILabel *songName;
@property (nonatomic, strong)UILabel *authorLable;
@property (nonatomic, strong)UIButton *nextBtn;
@property (nonatomic, strong)UIButton *heartBtn;


@end

@implementation LTabBarViewController

static UIView *tabBarView = nil;

- (UIView *)tabBarView {
    
    //GCD写法 (执行效率高)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarView = [[UIView alloc]init];
    });
    return tabBarView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBar setHidden:YES];
    
    [self createTabBarView];
}

- (void)createTabBarView {
    
    //背景View
    self.tabBarView.backgroundColor = RGBACOLOR(227, 227, 227, 1.0);
    self.tabBarView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTapAction:)];
    [self.tabBarView addGestureRecognizer:oneTap];
    
    [self.view addSubview:self.tabBarView];
    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo(48);
    }];
    
    //播放/暂停按钮
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    
    [self.tabBarView addSubview:self.playBtn];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.tabBarView);
        make.left.mas_equalTo(self.view).offset(10);
    }];
    
    //音频名称
    self.songName = [[UILabel alloc] init];
    self.songName.text = @"歌曲名称";
    [self.songName setTextAlignment:NSTextAlignmentLeft];
    [self.songName setFont:[UIFont systemFontOfSize:13.0]];
    [self.tabBarView addSubview:self.songName];
    [self.songName mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.tabBarView).offset(8);
        make.leading.equalTo(self.playBtn.mas_trailing).offset(10);
        
    }];
    
    //音频作者
    self.authorLable = [[UILabel alloc] init];
    self.authorLable.text = @"艺术家";
    [self.authorLable setTextAlignment:NSTextAlignmentLeft];
    [self.authorLable setFont:[UIFont systemFontOfSize:12.0]];
    [self.authorLable setTextColor:[UIColor grayColor]];
    [self.tabBarView addSubview:self.authorLable];
    [self.authorLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.equalTo(self.songName.mas_leading);
        make.top.equalTo(self.songName.mas_bottom).offset(2);
        
    }];
    
    //下一首
    self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
    [self.tabBarView addSubview:self.nextBtn];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(self.tabBarView);
        make.right.mas_equalTo(self.view).offset(-10);
    }];
    
    
    //收藏按钮
    self.heartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.heartBtn setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
    [self.tabBarView addSubview:self.heartBtn];
    [self.heartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(35, 35));
        make.centerY.equalTo(self.tabBarView);
        make.trailing.equalTo(self.nextBtn.mas_leading).offset(-30);
        
    }];
    
}
- (void)oneTapAction:(UITapGestureRecognizer *)tap {
    
    NSLog(@"taptaptaptaptaptpatpatpat");
//    UINavigationController *frameCtl = self.viewControllers[0];
//    
//
//    [frameCtl pushViewController:[FMMusicViewController shareMusicViewController] animated:YES];
    
    FMPlaymusicView *musicView = [[FMPlaymusicView alloc] initWithData];
    
    
    [musicView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
