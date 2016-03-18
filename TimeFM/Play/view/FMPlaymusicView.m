//
//  FMPlaymusicView.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/18.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "FMPlaymusicView.h"

#define Picker_Height (KMainScreenHeight - 64)

@interface FMPlaymusicView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *musicViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgLeftWidth;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation FMPlaymusicView

- (UIView *)initWithData{
    
    if (self = [super init]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"FMPlaymusicView" owner:nil options:nil][0];
        self.frame = [UIScreen mainScreen].bounds;
        
    }
    
    
    [self customView];
    return self;
}
- (void)customView{
    
    if (KMainScreenHeight == 480) {
        //4s
        self.imgLeftWidth.constant = 90;
        self.imgViewHeight.constant = KMainScreenWidth - 180;
        self.imgView.layer.cornerRadius = (KMainScreenWidth - 180) / 2
        ;
        
    }else {
        //5s或5s以上
        
        self.imgViewHeight.constant = KMainScreenWidth - 80;
        self.imgView.layer.cornerRadius = (KMainScreenWidth - 80) / 2;
        
    }
    
    [self setSwipe];
    self.musicViewHeight.constant = 0;
    [self layoutIfNeeded];
}
- (void)setSwipe {
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDownAction:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    
    [self addGestureRecognizer:swipeDown];
}
- (void)swipeDownAction:(UISwipeGestureRecognizer *)swipe {
    
    [self hide];
    
}

- (void)show{
    
    UIApplication *app = [UIApplication sharedApplication];
    AppDelegate *del = app.delegate;
    UIWindow *win = del.window;
    
    [win addSubview:self];
    [win makeKeyAndVisible];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.musicViewHeight.constant = Picker_Height;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.musicViewHeight.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

@end
