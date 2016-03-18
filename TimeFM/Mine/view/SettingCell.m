//
//  SettingCell.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/16.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "SettingCell.h"

@interface SettingCell ()

@property (weak, nonatomic) IBOutlet UILabel *selectName;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;


@end

@implementation SettingCell

- (void)awakeFromNib {
    // Initialization code
    
    self.textLabel.font = [UIFont systemFontOfSize:13.0];
}
//刷新设置界面
- (void)refreshUIWithSection:(NSInteger)section andRow:(NSInteger)row {
    
    if (section == 0) {
        
        switch (row) {
            case 0:
                
                self.selectName.text = @"使用流量播放";
                break;
            case 1:
                
                self.selectName.text = @"WiFi网络自动下载每日更新";
                break;
            case 2:
                
                self.selectName.text = @"开启后台自动播放";
                break;
            case 3:
                
                self.selectName.text = @"清除缓存";
                self.contentLable.text = [NSString stringWithFormat:@"%luMB",(unsigned long)[[SDImageCache sharedImageCache] getSize]/1024/1024];
                
                break;
            default:
                break;
        }
        
        
    }else {
        
        switch (row) {
            case 0:
                
                self.selectName.text = @"反馈问题";
                break;
            case 1:
                
                self.selectName.text = @"关于";
                break;
                
            default:
                break;
        }
        
    }
    
}
//刷新个人资料界面
- (void)refreshPercardUI:(NSInteger)section andRow:(NSInteger)row {
    
    if (section == 0) {
        
        switch (row) {
            case 0:
                self.selectName.text = @"帐号";
                self.contentLable.text = @"";
                break;
            case 1:
                self.selectName.text = @"密码";
                self.contentLable.text = @"修改密码";
                break;
            case 2:
                self.selectName.text = @"昵称";
                self.contentLable.text = @"";
                break;
            case 3:
                self.selectName.text = @"性别";
                self.contentLable.text = @"";
                break;
            default:
                break;
        }
        
    }else {
        
        switch (row) {
            case 0:
                self.selectName.text = @"微信";
                self.contentLable.text = @"未绑定";
                break;
            case 1:
                self.selectName.text = @"QQ";
                self.contentLable.text = @"未绑定";
                break;
            case 2:
                self.selectName.text = @"新浪微博";
                self.contentLable.text = @"未绑定";
                break;

            default:
                break;
        }
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
