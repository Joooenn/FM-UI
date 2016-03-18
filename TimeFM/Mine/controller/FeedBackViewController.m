//
//  FeedBackViewController.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/17.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()
<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *subLable;

@end

@implementation FeedBackViewController

- (void)loadView {
    
    [super loadView];
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

#pragma mark - UITextView代理方法
-(void)textViewDidChange:(UITextView *)textView
{
    self.textView.text =  textView.text;
    if (textView.text.length == 0) {
        self.subLable.text = @"亲，您的意见不能少于12个字，最多不能超过120个字，收到之后我们会认真听取您的意见，感谢您的支持！";
    }else{
        self.subLable.text = @"";
    }
}
#pragma mark - 点击事件
//键盘落下
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}
//返回
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
//发送
- (IBAction)sendAction:(id)sender {
    
    
}
@end
