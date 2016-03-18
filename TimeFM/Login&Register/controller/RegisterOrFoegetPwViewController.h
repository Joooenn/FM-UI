//
//  RegisterViewController.h
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/16.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterOrFoegetPwViewController : UIViewController

//标识，判断注册或者重置密码状态
/**
 *  flag = 0 , 快速注册
 *  flag = 1 , 重置密码
 */
@property (nonatomic, assign)NSInteger flag;

@end
