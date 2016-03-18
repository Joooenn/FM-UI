//
//  SettingViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/16.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "OutLoginCell.h"

@interface SettingViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController

- (void)loadView {
    
    [super loadView];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];

}
#pragma mark - 点击事件
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchisChanged:(UISwitch *)switchBtn {
    
    
    
}

#pragma mark - TableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            
            return 4;
            break;
        case 1:
            
            return 2;
            break;
        case 2:
            
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 2) {
        
        OutLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutLoginCell"];
        cell.textLabel.text = @"退出";
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        return cell;
    }else {
        
        SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
        
        if (indexPath.section == 0) {
            
            
            if (indexPath.row == 0) {
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                UISwitch *switchOne = [[UISwitch alloc] init];
                [switchOne setOn:YES];
                switchOne.tag = 1001;
                
                [switchOne addTarget:self action:@selector(switchisChanged:) forControlEvents:UIControlEventValueChanged];;
                [cell addSubview:switchOne];
                [switchOne mas_makeConstraints:^(MASConstraintMaker *make) {
                   
                    make.centerY.equalTo(cell);
                    make.trailing.equalTo(cell.mas_trailing).offset(-8);
                    make.height.mas_equalTo(20);
                }];
                
            }else if (indexPath.row == 1) {
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                UISwitch *switchTwo = [[UISwitch alloc] init];
                [switchTwo setOn:YES];
                switchTwo.tag = 1002;
                
                [switchTwo addTarget:self action:@selector(switchisChanged:) forControlEvents:UIControlEventValueChanged];;
                [cell addSubview:switchTwo];
                [switchTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerY.equalTo(cell);
                    make.trailing.equalTo(cell.mas_trailing).offset(-8);
                    make.height.mas_equalTo(20);
                }];
                
            }else if (indexPath.row == 2) {
                
                cell.accessoryType = UITableViewCellAccessoryNone;
                UISwitch *switchThr = [[UISwitch alloc] init];
                [switchThr setOn:YES];
                switchThr.tag = 1003;
                
                [switchThr addTarget:self action:@selector(switchisChanged:) forControlEvents:UIControlEventValueChanged];;
                [cell addSubview:switchThr];
                [switchThr mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.centerY.equalTo(cell);
                    make.trailing.equalTo(cell.mas_trailing).offset(-8);
                    make.height.mas_equalTo(20);
                }];
            }
            
        }
        
        
        [cell refreshUIWithSection:indexPath.section andRow:indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        //退出登录
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        
        NSLog(@"SRSetting number = %@",[userDefault objectForKey:@"number"]);
        NSLog(@"SRSetting sessionId = %@",[userDefault objectForKey:@"sessionId"]);
        
        if ([userDefault objectForKey:@"number"] != nil && [userDefault objectForKey:@"sessionId"] != nil) {
            
            //加载提示
            [LHTTPManager postWithUrlString:HOST andParam:[LHTTPManager getDictWithMethod:@"user.logout" andParamDict:@{@"number":[userDefault objectForKey:@"number"],@"sessionId":[userDefault objectForKey:@"sessionId"]}] returnBlock:^(id obj, NSError *error) {
                
                if (error) {
                    
                    NSLog(@"error = %@",error);
                }else {
                    
                    NSLog(@"msg = %@,text = %@, obj = %@",obj[@"message"],obj[@"testField"],obj);
                    
                    if ([obj[@"message"] isEqualToString:@"请重新登陆"]) {
                        
                        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                        [userDefault removeObjectForKey:@"sessionId"];
                        [userDefault removeObjectForKey:@"number"];
                        [userDefault synchronize];
                        
                        [self presentViewController:[LHTTPManager getCtl:@"SRRegisterViewController"] animated:YES completion:nil];

                    }
                    
                    if (obj[@"codeFlag"]) {
                        
                        if ([obj[@"codeFlag"] integerValue] == 1) {
                            //成功，删除本地保存的sessionId
                            [userDefault removeObjectForKey:@"number"];
                            [userDefault removeObjectForKey:@"sessionId"];
                            [userDefault synchronize];
                            
                            //退出成功，先提示用户
                            [self.view makeToast:obj[@"message"] duration:2.0 position:nil];
         
                            
                            
                            NSLog(@"%@, %@",obj, obj[@"message"]);
                            
                        }else {
                            //失败
                            NSLog(@"%@, %@",obj, obj[@"message"]);
                        }
                        
                        
                    }else {
                        //若不存在codeFlag,则，返回的是系统错误
                        
                        NSLog(@"SRMine obj = %@",obj);
                    }
                    
                }
            }];
        }
        
        NSLog(@"点击了退出登录！");
        
        
        
    }else if (indexPath.section == 1) {
        //问题反馈，关于
        if (indexPath.row == 1) {
            
            [self performSegueWithIdentifier:@"AboutSegue" sender:nil];
            
        }else {
            
            
            [self performSegueWithIdentifier:@"FeedBackSegue" sender:nil];
        }
        
        
    }else {
        
        if (indexPath.row == 3) {
            
            UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"当前缓存%ldKB",[[SDImageCache sharedImageCache] getSize]/1024] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [[SDImageCache sharedImageCache] clearDisk];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertCtl addAction:okAction];
            [alertCtl addAction:cancelAction];
            
            [self presentViewController:alertCtl animated:YES completion:nil];
        }
    }
    
}
//组头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 30.0f;
    }
    return 0.001f;
}
//组尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    
    return 20.0f;
}
@end
