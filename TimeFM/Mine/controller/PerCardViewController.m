//
//  PerCardViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/16.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "PerCardViewController.h"
#import "SettingCell.h"

@interface PerCardViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PerCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            
            return 4;
            break;
        case 1:
            
            return 3;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    
    [cell refreshPercardUI:indexPath.section andRow:indexPath.row];
    return cell;
}

//组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            
            return 30.0f;
            break;
        case 1:
            
            return 20.0f;
            break;
            
        default:
            break;
    }
    
    return 0.001f;
}
//组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
@end
