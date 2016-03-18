//
//  FMMusicView.h
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/17.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSPlaylistItem;

@class FMMusicView;

@protocol FMMusicViewDelegate <NSObject>

- (void)musicView:(FMMusicView *)view musicStop:(NSInteger)playState;
- (void)musicView:(FMMusicView *)view musicUpdate:(UIButton *)updateBtn;
- (void)musicView:(FMMusicView *)view musicDownload:(NSInteger)downloadBtn;
- (void)musicView:(FMMusicView *)view musicShare:(NSInteger)shareBtn;
- (void)musicView:(FMMusicView *)view musicList:(NSInteger)listBtn;

@end

@interface FMMusicView : UIView

@property (nonatomic,assign) id <FMMusicViewDelegate>delegate;

@end
