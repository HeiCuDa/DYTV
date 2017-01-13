//
//  PageTitleView.h
//  DYZB
//
//  Created by Apple's Mac on 2017/1/13.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PageTitleView;

//PageTitleView 协议，点击回调
@protocol PageTitleViewDelegate <NSObject>
- (void)pageTitleView:(PageTitleView *)pageTitleView didSelectedIndex:(NSInteger)index;
@end


@interface PageTitleView : UIView
/*
 description:
            封装构造函数，让别人在创建对象时，就传入其实需要显示的内容
 params:
            frame：创建对象时确定了frame就可以直接设置子控件的位置和尺寸
            isScrollEnable：是否可以滚动。某些地方该控件是可以滚动的。
            titles：显示的所有标题
 *****************************************************************************************/

- (instancetype)initWithFrame:(CGRect)frame
               isScrollEnable:(BOOL)isScrollEnable
                       titles:(NSArray *)titles;

- (void)setCurrentTitleWithSourceIndex:(NSInteger)sourceIndex
                           targetIndex:(NSInteger)targetIndex
                              progress:(CGFloat)progress;


@property(nonatomic,assign) BOOL    isScrollEnable;
@property(nonatomic,strong) NSArray *titles;
@property(nonatomic,assign) id<PageTitleViewDelegate> delegate;

@end
