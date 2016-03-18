//
//  FMMusicView.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/17.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "FMMusicView.h"

@interface FMMusicView ()

@property (nonatomic, strong)UIButton *playButton;
@property (nonatomic, strong)UISlider *progress;
@property (nonatomic, strong)UIButton *updateButton;
@property (nonatomic, strong)UIButton *downloadButton;
@property (nonatomic, strong)UIButton *shareButton;
@property (nonatomic, strong)UIButton *listButton;
@property (nonatomic, strong)UIButton *preButton;
@property (nonatomic, strong)UIButton *nextButton;
@property (nonatomic, strong)UIButton *heartButton;

@end

@implementation FMMusicView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self.backgroundColor = [UIColor orangeColor];
    self = [super initWithFrame:frame];
    if (self) {

//        _heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_heartButton setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateNormal];
//        [_heartButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _heartButton.tag = 10;
//        [self addSubview:_heartButton];
//        [_heartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.centerX.equalTo(self);
//            make.bottom.equalTo(self.mas_bottom).offset(-30);
//            make.size.mas_equalTo(CGSizeMake(35, 35));
//        }];
//        
//        _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_preButton  setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_preButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _preButton.tag = 11;
//        [self addSubview:_preButton];
//        [_preButton mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.centerY.equalTo(_heartButton);
//            make.right.equalTo(_heartButton.mas_leading).offset(-70);
//            make.size.mas_equalTo(CGSizeMake(40, 40));
//        }];
//        
//        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_nextButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_nextButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _preButton.tag = 12;
//        [self addSubview:_nextButton];
//        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.centerY.equalTo(_heartButton);
//            make.size.mas_equalTo(CGSizeMake(40, 40));
//            make.left.equalTo(_heartButton.mas_trailing).offset(70);
//            
//        }];
        
//        _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_updateButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_updateButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _updateButton.tag = 13;
//        [self addSubview:_updateButton];
//        [_updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.left.mas_equalTo(self).offset(35);
//            make.bottom.equalTo(_preButton.mas_top).offset(-50);
//            make.size.mas_equalTo(CGSizeMake(30, 30));
//        }];
//        
//        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_downloadButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_downloadButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _downloadButton.tag = 14;
//        [self addSubview:_downloadButton];
//        [_downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.centerY.equalTo(_updateButton);
//            make.left.mas_equalTo(_updateButton.mas_trailing).offset(45);
//            make.size.mas_equalTo(_updateButton);
//        }];
//        
//        _listButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_listButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_listButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _listButton.tag = 16;
//        [self addSubview:_listButton];
//        [_listButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.right.mas_equalTo(self).offset(-35);
//            make.centerY.mas_equalTo(_updateButton);
//            make.size.mas_equalTo(CGSizeMake(30, 30));
//            
//        }];
//        
//        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_shareButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_shareButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        _shareButton.tag = 15;
//        [self addSubview:_shareButton];
//        [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.centerY.mas_equalTo(_listButton);
//            make.right.equalTo(_listButton.mas_leading).offset(-45);
//            make.size.mas_equalTo(_listButton);
//            make.size.mas_equalTo(_downloadButton);
//        }];
//        
//       
//        
//        
//        
//        
//        _progress = [[UISlider alloc] init];
//        
//        _progress.continuous = YES;
//        _progress.minimumTrackTintColor = [UIColor colorWithRed:244.0f/255.0f green:147.0f/255.0f blue:23.0f/255.0f alpha:1.0f];
//        _progress.maximumTrackTintColor = [UIColor lightGrayColor];
//        [_progress setThumbImage:[UIImage imageNamed:@"player-progress-point-h"] forState:UIControlStateNormal];
//        
//        [self addSubview:_progress];
//        [_progress mas_makeConstraints:^(MASConstraintMaker *make) {
//           
//            make.left.mas_equalTo(self).offset(30);
//            make.right.mas_equalTo(self).offset(-30);
//            make.bottom.equalTo(_updateButton.mas_top).offset(-50);
//        }];
        

//        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        [_playButton setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
//        [_playButton setImage:[UIImage imageNamed:@"playHight.png"] forState:UIControlStateHighlighted];
//        [_playButton addTarget:self action:@selector(playButtonEvent) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_playButton];
        
        

        
    }
    return self;
    
    
}

- (void)buttonAction:(UIButton *)button {
    
    
    
}

@end
