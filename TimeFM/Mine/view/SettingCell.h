//
//  SettingCell.h
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/16.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SettingCell : UITableViewCell

//设置界面
- (void)refreshUIWithSection:(NSInteger)section andRow:(NSInteger)row;

//个人资料界面
- (void)refreshPercardUI:(NSInteger)section andRow:(NSInteger)row;
@end
