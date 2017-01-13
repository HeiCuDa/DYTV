//
//  PageCotentView.h
//  DYZB
//
//  Created by Apple's Mac on 2017/1/13.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageCotentView;

@protocol PageCotentViewDelegate <NSObject>

- (void)pageCotentView:(PageCotentView *)pageContentView
           sourceIndex:(NSInteger)sourceIndex
           targetIndex:(NSInteger)targetIndex
              progress:(CGFloat)progress;

@end
@interface PageCotentView : UIView
/*
 description:
            封装构造函数，让别人在创建对象时，就传入其实需要显示的内容
 params:
            所有用于显示在UICollectionView的Cell的所有控制器
            控制器的父控制器
 *****************************************************************************************/

- (instancetype)initWithFrame:(CGRect)frame
                     childVcs:(NSArray *)childVcs
         parentViewController:(UIViewController *)parentViewController;


- (void)scrollToIndex:(NSInteger)index;

@property(nonatomic, strong) NSArray            *childVcs;
@property(nonatomic, strong) UIViewController   *parentViewController;
@property(nonatomic, assign) id<PageCotentViewDelegate> delegate;

@end
