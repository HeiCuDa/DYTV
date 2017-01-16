//
//  PageCotentView.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/13.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#define kContentCellID      @"kContentCellID"

#import "PageCotentView.h"

@interface PageCotentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong) UICollectionView  *collectionView;
@property(nonatomic, assign) CGFloat startOffsetX;
@property(nonatomic, assign) BOOL    isStreching;
@end
@implementation PageCotentView

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentViewController:(UIViewController *)parentViewController
{
    if (self = [super initWithFrame:frame]) {
        _childVcs = childVcs;
        _parentViewController = parentViewController;
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI
{
    //1.添加所有的控制器
    for(UIViewController *childVc in _childVcs)
    {
        if (_parentViewController) {
            [_parentViewController addChildViewController:childVc];
        }
    }
    
    //2.添加collectionView
    [self addSubview:self.collectionView];
}


#pragma mark --------------------------Lazy Load--------------------------------------------
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        //1.创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]  init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        //2.创建collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
    }
    return _collectionView;
}

- (void)scrollToIndex:(NSInteger)index
{
    CGPoint offset = CGPointMake((CGFloat)index * _collectionView.bounds.size.width, 0);
    [_collectionView setContentOffset:offset animated:NO];
}

#pragma mark -------------------CollectionView DataSource And Delegate Methods ---------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _childVcs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    
    //移除之前的
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    // 取出控制器
    UIViewController *childVc = _childVcs[indexPath.item];
    childVc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVc.view];
    

    return cell;
}


#pragma mark ----------------ScrollView Delegate Method---------------------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startOffsetX = scrollView.contentOffset.x;
    _isStreching = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isStreching = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_isStreching) {
        return;
    }
    
    //1.定义要获取的内容
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    CGFloat   progress    = 0;
    
    //2.获取进度
    CGFloat   offsetX = scrollView.contentOffset.x;
    
    if (offsetX >= scrollView.bounds.size.width*(_childVcs.count-1)) {
        return;
    }
    
    
    CGFloat   radio   = offsetX / scrollView.bounds.size.width;
    progress= radio - floor(radio);
    
    //3.判断活动的方向
    if (offsetX > _startOffsetX) {   //向左滑动
        sourceIndex = (NSInteger)(offsetX / scrollView.bounds.size.width);
        targetIndex = sourceIndex + 1;
        
        if (targetIndex >= _childVcs.count) {
            targetIndex = _childVcs.count-1;
        }
        
        if (offsetX - _startOffsetX == scrollView.bounds.size.width) {
            progress = 1.0;
            targetIndex = sourceIndex;
            sourceIndex-=1;
        }
    }else{      //向右滑动
        targetIndex = (NSInteger)(offsetX / scrollView.bounds.size.width);
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= _childVcs.count) {
            sourceIndex = _childVcs.count - 1;
        }
        progress = 1 - progress;
    }
    
    
    //4.通知代理
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageCotentView:sourceIndex:targetIndex:progress:)]) {
        [self.delegate pageCotentView:self sourceIndex:sourceIndex targetIndex:targetIndex progress:progress];
    }
}
@end
