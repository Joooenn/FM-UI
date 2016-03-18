//
//  FFCyleView.h
//
//  Created by 深圳市深软信息技术有限公司 on 15/12/31.
//  Copyright © 2015年 深圳市深软信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol refreshRing <NSObject>

- (void)refreshRingDeatailWithIndex:(NSInteger )index;

@end

//回调block
typedef void (^runBlockType)(NSInteger index);

@interface FFCyleView : UIView


@property (nonatomic, strong)id <refreshRing>delegate;
/**
 *  通过装载图片名称的数组实例化循环视图(图片数要超过3张)
 *
 *  @param frame                        视图大小
 *  @param imageNameArr     装载图片名称的数组
 *
 */
- (instancetype)initWithFrame:(CGRect)frame imageUrlArr:(NSArray *)imageArr;

/**
 *  设置是否分页
 *
 *  @param pagingEnabled YES 分页 NO不分页
 */
-(void)setPagingEnabled:(BOOL)pagingEnabled;


/**
 *  启动定时滑动模式
 *
 *  @param NSTimeInterval   时间间隔
 *  @param block                    定时器执行的内容
 */
-(void)startTimerWithTimeInterval:(NSTimeInterval)NSTimeInterval runBLock:(runBlockType)block;

/**
 *  停止定时器
 */
-(void)stopTimer;

@end
