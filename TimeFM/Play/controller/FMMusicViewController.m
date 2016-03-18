//
//  FMMusicViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/17.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "FMMusicViewController.h"
#import "LTabBarViewController.h"
#import "FMMusicView.h"
#import "FMPlaymusicView.h"

@interface FMMusicViewController ()
<FMMusicViewDelegate>


@end

@implementation FMMusicViewController

+ (FMMusicViewController *)shareMusicViewController {
    
    static FMMusicViewController *musicViewController;
    if (!musicViewController) {
        
        musicViewController = [[FMMusicViewController alloc] init];
    }
    
    return musicViewController;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    LTabBarViewController *tabBarCtl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LTabBarViewController"];
    
    [tabBarCtl.tabBarView setHidden:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    LTabBarViewController *tabBarCtl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LTabBarViewController"];
    
    [tabBarCtl.tabBarView setHidden:NO];
}

- (void)loadView {
    [super loadView];
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    FMMusicView *musicView = [[FMMusicView alloc] initWithFrame:CGRectMake(0, 64, KMainScreenWidth, KMainScreenHeight)];
    musicView.delegate = self;
    
    [self.view addSubview:musicView];
    //[self.view sendSubviewToBack:musicView];
}

@end
