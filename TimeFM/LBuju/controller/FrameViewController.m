//
//  FrameViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/15.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "FrameViewController.h"
#import "LoginViewController.h"
#import "FMMusicViewController.h"
#import "FatherCell.h"
#import "MineCell.h"
#import "SceneCell.h"

@interface FrameViewController ()
<UIScrollViewDelegate, UITableViewDataSource,UITableViewDelegate>

//布局View
@property (weak, nonatomic) IBOutlet UIScrollView *bujuScrollView;
@property (weak, nonatomic) IBOutlet UIView *navView;

//布局子控件
@property (weak, nonatomic) IBOutlet UILabel *lineLable;
@property (weak, nonatomic) IBOutlet UIButton *recomBtn;
@property (weak, nonatomic) IBOutlet UIButton *classBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *mineBtn;

//控件约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLableCenterX;

//tableView
@property (weak, nonatomic) IBOutlet UITableView *recomTableView;//推荐
@property (weak, nonatomic) IBOutlet UITableView *classTableView;//分类
@property (weak, nonatomic) IBOutlet UITableView *collectTableView;//收藏
@property (weak, nonatomic) IBOutlet UITableView *mineTableView;//我的

//navBar按钮的标识
@property (nonatomic, assign)NSInteger ctlIndex;

//推荐界面


//我的界面
@property (weak, nonatomic) IBOutlet UIView *headerView;


@end

@implementation FrameViewController

- (void)pushToMusic {
    
    [self.navigationController pushViewController:[FMMusicViewController shareMusicViewController] animated:YES];
}

#pragma mark - 视图控制器生命周期
- (void)loadView {
    
    [super loadView];
    
    //取消自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //初始化
    [self.recomBtn setTitleColor:RGBACOLOR(28, 155, 205, 1.0) forState:UIControlStateNormal];
    self.ctlIndex = 0;
    
    //调整nav视图层次
    [self.view bringSubviewToFront:self.navView];
    
    //隐藏NavigationBar
    [self.navigationController setNavigationBarHidden:YES];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //我的界面，头部视图
    if (![LHTTPManager isLogin]) {
        //登录
        
        UIImageView *headerImg = [[UIImageView alloc] init];
        headerImg.backgroundColor = RGBACOLOR(28, 155, 205, 1.0);
        
        [self.headerView addSubview:headerImg];
        [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.headerView);
            make.size.mas_equalTo(CGSizeMake(KMainScreenWidth * 0.24, KMainScreenWidth * 0.24));
            make.top.mas_equalTo(18);
            
        }];
        [headerImg.layer setCornerRadius:KMainScreenWidth * 0.24 / 2];
        
        UILabel *userName = [[UILabel alloc] init];
        userName.text = @"用户名";
        [userName setTextColor:[UIColor grayColor]];
        userName.textAlignment = NSTextAlignmentCenter;
        [userName setFont:[UIFont systemFontOfSize:14]];
        
        [self.headerView addSubview:userName];
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(headerImg);
            make.top.mas_equalTo(headerImg.mas_bottom).offset(10);
            
        }];
        
    }else {
        //未登录
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        loginBtn.layer.cornerRadius = 5.0f;
        [loginBtn.layer setBorderWidth:1.0f];
        [loginBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        loginBtn.tag = 10;
        [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.headerView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.center.equalTo(self.headerView);
            make.size.mas_equalTo(CGSizeMake(140, 40));
        }];
        
    }
    
    switch (self.ctlIndex) {
        case 0:
            [self updateButtonState];
            self.bujuScrollView.contentOffset = CGPointMake(0, 0);
            [self.lineLable setCenter:CGPointMake(self.recomBtn.center.x, self.lineLable.center.y)];
            break;
        case 1:
            [self updateButtonState];
            self.bujuScrollView.contentOffset = CGPointMake(KMainScreenWidth, 0);
            [self.lineLable setCenter:CGPointMake(self.classBtn.center.x, self.lineLable.center.y)];
            break;
        case 2:
            [self updateButtonState];
            self.bujuScrollView.contentOffset = CGPointMake(KMainScreenWidth * 2, 0);
            [self.lineLable setCenter:CGPointMake(self.collectBtn.center.x, self.lineLable.center.y)];
            break;
        case 3:
            [self updateButtonState];
            self.bujuScrollView.contentOffset = CGPointMake(KMainScreenWidth * 3, 0);
            [self.lineLable setCenter:CGPointMake(self.mineBtn.center.x, self.lineLable.center.y)];
            break;
            
        default:
            break;
    }
    
    //隐藏NavigationBar
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击事件
//推荐
- (IBAction)recomendAction:(id)sender {
    
    [self.recomBtn setTitleColor:RGBACOLOR(28, 155, 205, 1.0) forState:UIControlStateNormal];
    
    //刷新按钮状态
    self.ctlIndex = 0;
    [self updateButtonState];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bujuScrollView.contentOffset = CGPointMake(0, 0);
        [self.lineLable setCenter:CGPointMake(self.recomBtn.center.x, self.lineLable.center.y)];
        
    }];
    
}
//分类
- (IBAction)classifyAction:(id)sender {
    
    [self.classBtn setTitleColor:RGBACOLOR(28, 155, 205, 1.0) forState:UIControlStateNormal];
    
    //刷新按钮状态
    self.ctlIndex = 1;
    [self updateButtonState];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bujuScrollView.contentOffset = CGPointMake(KMainScreenWidth, 0);
        [self.lineLable setCenter:CGPointMake(self.classBtn.center.x, self.lineLable.center.y)];
    }];
    
}

//收藏
- (IBAction)collectAction:(id)sender {
    
    [self.collectBtn setTitleColor:RGBACOLOR(28, 155, 205, 1.0) forState:UIControlStateNormal];
    
    //刷新按钮状态
    self.ctlIndex = 2;
    [self updateButtonState];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bujuScrollView.contentOffset = CGPointMake(KMainScreenWidth * 2, 0);
        [self.lineLable setCenter:CGPointMake(self.collectBtn.center.x, self.lineLable.center.y)];
    }];

    
}

//我的
- (IBAction)mineAction:(id)sender {
    
    [self.mineBtn setTitleColor:RGBACOLOR(28, 155, 205, 1.0) forState:UIControlStateNormal];
    
    //刷新按钮状态
    self.ctlIndex = 3;
    [self updateButtonState];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bujuScrollView.contentOffset = CGPointMake(KMainScreenWidth * 3, 0);
        [self.lineLable setCenter:CGPointMake(self.mineBtn.center.x, self.lineLable.center.y)];
        
    }];
}
//刷新按钮状态
- (void)updateButtonState {
    
    switch (self.ctlIndex) {
        case 0:
            
            [self.classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.mineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            break;
        case 1:
            
            [self.recomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.mineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            break;
        case 2:
            
            [self.recomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.mineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        case 3:
            
            [self.recomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        
        default:
            break;
    }
    
}
- (void)loginAction {
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginCtl = [main instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    //[self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:loginCtl animated:YES];
}
#pragma mark - TableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    if (tableView.tag == 103) {
        //我的
        
        return 2;
    }else if (tableView.tag == 101) {
        //推荐
        
        return 2;
    }
    //其他
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //我的
    if (tableView.tag == 103) {
        
        if (section == 0) {
            
            return 1;
        }else {
            
            return 2;
        }
    }else if (tableView.tag == 101) {
        
        if (section == 0) {
            
            return 4;
        }else {
            
            return 1;
        }
        
    }
    //其他
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView.tag == 101) {
        //推荐
        
        if (indexPath.section == 0) {
            
            FatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FatherCell"];
            
            return cell;
            
        }else {
            
            SceneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SceneCell"];
            
            return cell;
        }
        
    }else if (tableView.tag == 100) {
        //分类
        
        FatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FatherCell"];
        
        return cell;
        
    }else if (tableView.tag == 102) {
        //收藏
        
        FatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FatherCell"];
        
        return cell;
        
    }else {
        //我的
        
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        
        if (indexPath.section == 0) {
            
            cell.textLabel.text = @"我的下载";
        }else {
            
            if (indexPath.row == 0) {
                
                cell.textLabel.text = @"个人资料";
            }else {
                
                cell.textLabel.text = @"其他设置";
            }
        }
        
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 103) {
        
        if (indexPath.section == 0) {
            //我的下载
            
            [self performSegueWithIdentifier:@"DownloadSugue" sender:nil];
        }else {
            
            if (indexPath.row == 0) {
                //个人资料
                
                [self performSegueWithIdentifier:@"PerCardSegue" sender:nil];
                
            }else {
                //其他设置
                
                [self performSegueWithIdentifier:@"SettingSegue" sender:nil];
            }
            
        }
    }
    
}
//组头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView.tag == 101) {
        //推荐
        if (section == 0) {
            
            return @"最新";
        }else {
            
            return @"场景";
        }
        
    }else if (tableView.tag == 100) {
        //分类
        
        return @"最新";
    }else if (tableView.tag == 102) {
        //收藏
        
        return @"xxx1首  xxx2个  xxx3个";
    }
    else {
        //其他
        
        return @"";
    }
    
}
//TableView每个cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 101) {
        //推荐
        if (indexPath.section == 0) {
            
            return 61.0;
        }else {
            
            return 214.0;
        }
        
    }else if (tableView.tag == 103) {
        //我的
        
        return 45.0;
    }
    else {
        //其他
        
        return 61.0;
    }
    
}
//组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView.tag == 103) {
        //我的
        
        return 10.0f;
    }else if (tableView.tag == 100 || tableView.tag == 101 || tableView.tag == 102) {
        //推荐&&分类
        
        return 30.0f;
    }
    return 0.001f;
}
//组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
@end
