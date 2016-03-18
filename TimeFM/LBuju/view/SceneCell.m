//
//  SceneCell.m
//  TimeFM
//
//  Created by 深圳市深软信息技术有限公司 on 16/3/17.
//  Copyright © 2016年 Liang Zhicheng. All rights reserved.
//

#import "SceneCell.h"
#import "SceneCollecCell.h"

@interface SceneCell ()
<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation SceneCell

- (void)awakeFromNib {
    
    
}

#pragma mark - UICollectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 6;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SceneCollecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SceneCollecCell" forIndexPath:indexPath];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((KMainScreenWidth - 40)/2, 70);
    
}
@end
