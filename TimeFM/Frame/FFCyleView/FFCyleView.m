//
//  FFCyleView.h
//
//  Created by 深圳市深软信息技术有限公司 on 15/12/31.
//  Copyright © 2015年 深圳市深软信息技术有限公司. All rights reserved.
//

#import "FFCyleView.h"

@interface FFCyleView ()<UIScrollViewDelegate>

//中间视图显示的图片的下标
@property (nonatomic,assign)NSInteger showIndex;
//图片名称数组
@property (nonatomic,copy)NSArray *imageArr;
//主滚动视图
@property (nonatomic,strong)UIScrollView *scrollView;
//定时器
@property (nonatomic,strong)NSTimer *myTimer;
//定时器执行的代码段
@property (nonatomic,copy)runBlockType block;

@end

@implementation FFCyleView

#pragma mark-  懒加载
//懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * self.imageArr.count, self.frame.size.height);
        _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    
    return _scrollView;
}


#pragma mark- 布局相关
- (instancetype)initWithFrame:(CGRect)frame imageUrlArr:(NSArray *)imageArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (imageArr.count >= 3) {
            
            //默认值
            self.imageArr = imageArr;
            
            [self layoutScrollView:frame];
            
           
        }else{
            
            NSLog(@"\nFunction:%s\nLineNumber:%d\nError:图片数量少于3",__FUNCTION__,__LINE__);
            
            return nil;
            
        }
        
       
        
    }
    return self;
}

/**
 *  布局
 *
 */
-(void)layoutScrollView:(CGRect)frame{
    
    [self addSubview:self.scrollView];
    
    for (NSInteger i = 0; i < self.imageArr.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
        
        imageView.tag = 1000 + i;
        
        if (i == 0) {
            
            [LHTTPManager setImageView:imageView withUrlString:[self.imageArr lastObject]];
        }else{
            
            [LHTTPManager setImageView:imageView withUrlString:self.imageArr[i - 1]];
        }
        
        [self.scrollView addSubview:imageView];
        
    }
    
}


#pragma mark- FFCyleView其他方法
//处理下标
-(NSInteger)getIndex:(NSInteger)index{
    
    if (index > (NSInteger)self.imageArr.count - 1) {
        
        return 0;
        
    }else if (index < 0){
        
        return (NSInteger)self.imageArr.count - 1;
    }
    
    
    return index;
}

/**
 *  刷新UI
 */
-(void)updateUI{
    
    NSArray *imageUrlArr = @[self.imageArr[[self getIndex:self.showIndex - 1]],self.imageArr[self.showIndex],self.imageArr[[self getIndex:self.showIndex + 1]]];
    
    //换图
    for (NSInteger i = 1000; i < 1000 + 3; i ++) {
        
        UIImageView *imageView =(UIImageView *) [self viewWithTag:i];
        
        [LHTTPManager setImageView:imageView withUrlString:imageUrlArr[i - 1000]];
    }
    
}

-(void)setPagingEnabled:(BOOL)pagingEnabled{
    
    self.scrollView.pagingEnabled = pagingEnabled;
    
}
#pragma mark- 定时器相关

-(void)startTimerWithTimeInterval:(NSTimeInterval)NSTimeInterval runBLock:(runBlockType)block{
    
    if (!self.myTimer) {
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:NSTimeInterval target:self selector:@selector(play:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSRunLoopCommonModes];
        //KVO监听偏移量
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
        self.block = block;
    }
    
    
    
}
//KVO回调方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"] && object == self.scrollView) {
        
        CGFloat offset = [change[@"new"] CGPointValue].x;
        
        if (offset == self.scrollView.frame.size.width * 2) {
            
            self.showIndex = [self getIndex:++self.showIndex];
            self.block(self.showIndex);
            
            [self updateUI];
            
            //回到中间
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
            
        }
        
    }
    
    
}


//定时器事件
-(void)play:(NSTimer *)timer{
    
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 2, 0) animated:YES];

}

-(void)stopTimer{
    
    if (self.myTimer) {
        [self.myTimer invalidate];
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    
    
}



#pragma mark-  析构函数
- (void)dealloc
{
    if (self.myTimer) {
        [self.myTimer invalidate];
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    
    
}

#pragma mark- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //改变偏移量
    if (scrollView.contentOffset.x >  scrollView.frame.size.width * 2 || scrollView.contentOffset.x < 0) {
        
        self.showIndex  = (scrollView.contentOffset.x >  scrollView.frame.size.width * 2)?[self getIndex:++self.showIndex]:[self getIndex:--self.showIndex];
        
        //回到中间
        scrollView.contentOffset = CGPointMake(scrollView.frame.size.width, 0);
        
    }
    
    //刷新UI
    [self updateUI];
    
 
}



@end
