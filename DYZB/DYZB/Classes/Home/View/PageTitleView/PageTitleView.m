//
//  PageTitleView.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/13.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#define kScrollLineH    2
#define kTitleMargin    5

#define kNormalRGB [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0]
#define kSelectRGB [UIColor colorWithRed:255/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]


#define kNormalTitleColor [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0]
#define kSelectTitleColor [UIColor colorWithRed:255.0/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]


#import "PageTitleView.h"

@interface PageTitleView ()

@property(nonatomic, strong) UIScrollView    *scrollView;
@property(nonatomic, strong) UIView          *scrollLine;
@property(nonatomic, strong) NSMutableArray  *titleLabels;
@property(nonatomic, assign) NSInteger       currentIndex;
@end
@implementation PageTitleView


- (instancetype)initWithFrame:(CGRect)frame isScrollEnable:(BOOL)isScrollEnable titles:(NSArray *)titles
{
    if (self = [super initWithFrame:frame]) {
        _isScrollEnable = isScrollEnable;
        _titles = titles;
        _titleLabels = [[NSMutableArray alloc] init];
        _currentIndex = 0;
        
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame isScrollEnable:NO titles:nil];;
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIView *)scrollLine
{
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] init];
        _scrollLine.backgroundColor = kSelectTitleColor;
    }
    return _scrollLine;
}


- (void)setupUI
{
    //1.添加scrollView
    [self addSubview:self.scrollView];
    
    //2.初始化labels
    [self setupTitleLabels];
    
    //3.添加下划线
    [self setupBottomlineAndScrollline];
}

- (void)setupTitleLabels
{
    CGFloat titleY = 0;
    CGFloat titleH = self.bounds.size.height - kScrollLineH;
    NSInteger count = _titles.count;
    
    for(int index = 0; index < count; index++)
    {
        NSString *title = _titles[index];
        
        //1.创建label
        UILabel *label = [[UILabel alloc] init];
        
        //2.设置label的属性
        label.text = title;
        label.tag = index;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = kNormalTitleColor;
        label.font = [UIFont systemFontOfSize:16];
        [self.titleLabels addObject:label];
        
        //3.设置label的frame
        CGFloat titleW = 0;
        CGFloat titleX = 0;
        
        if (!_isScrollEnable) {
            
            titleW = self.bounds.size.width/(CGFloat)count;
            titleX = (CGFloat)index * titleW;
            
        }else{
            
            CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
            titleW = size.width;
            
            if (index != 0) {
                titleX = CGRectGetMaxX([_titleLabels[index-1] frame]) + kTitleMargin;
            }
        }
        
        label.frame = CGRectMake(titleX, titleY, titleW, titleH);
        //4.将Label添加到父控件中
        [self.scrollView addSubview:label];

        //5.监听label的点击
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)]];
    }
}

- (void)setCurrentTitleWithSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress
{
    //1.取出两个Label
    UILabel *sourceLabel = _titleLabels[sourceIndex];
    UILabel *targetLabel = _titleLabels[targetIndex];
    
    sourceLabel.textColor = kNormalTitleColor;
    targetLabel.textColor = kSelectTitleColor;
    //2.移动scrollLine
    CGFloat moveMargin = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress;
    [UIView animateWithDuration:0.3 animations:^{
        _scrollLine.frame = CGRectMake(sourceLabel.frame.origin.x + moveMargin, _scrollLine.frame.origin.y, _scrollLine.bounds.size.width, _scrollLine.bounds.size.height);
    }];
    
    const CGFloat *selectColorComponents = CGColorGetComponents(kSelectRGB.CGColor);
    const CGFloat *normalColorComponents = CGColorGetComponents(kNormalRGB.CGColor);

    CGFloat deletaRed = selectColorComponents[0] - normalColorComponents[0];
    CGFloat deletaGreen = selectColorComponents[1] - normalColorComponents[1];
    CGFloat deletaBlue = selectColorComponents[2] - normalColorComponents[2];

    //3.颜色渐变
    sourceLabel.textColor = [UIColor colorWithRed:(selectColorComponents[0] - deletaRed *progress) green:selectColorComponents[1]-deletaGreen*progress blue:selectColorComponents[2] - deletaBlue*progress alpha:1];
    targetLabel.textColor = [UIColor colorWithRed:(normalColorComponents[0] + deletaRed *progress) green:normalColorComponents[1] + deletaGreen*progress blue:normalColorComponents[2] + deletaBlue*progress alpha:1];

    _currentIndex = targetIndex;
}

- (void)setupBottomlineAndScrollline
{
    // 1.添加bottomline
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.frame = CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width, 0.5);
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomLine];
    
    //2.设置滑块的view
    [self addSubview:self.scrollLine];
    UILabel *firstLabel = _titleLabels.firstObject;
    CGFloat lineX = firstLabel.frame.origin.x;
    CGFloat lineY = self.bounds.size.height - kScrollLineH;
    CGFloat lineW = firstLabel.frame.size.width;
    CGFloat lineH = kScrollLineH;
    self.scrollLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
    firstLabel.textColor = kSelectTitleColor;
}

//标题Label的响应处理事件
- (void)titleLabelClick:(UITapGestureRecognizer *)tapGesture
{
    //1.获取点击的下标
    UILabel *tapLabel = (UILabel *)tapGesture.view;
    NSInteger index = tapLabel.tag;
    
    //2.滚动到正确的位置
    [self scrollToIndex:index];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageTitleView:didSelectedIndex:)]) {
        [self.delegate pageTitleView:self didSelectedIndex:index];
    }

}

//内容滚动
- (void)scrollToIndex:(NSInteger)index
{
    //1.获取最新的Label和之前的label
    UILabel *newLabel = _titleLabels[index];
    UILabel *oldLabel = _titleLabels[_currentIndex];

    //2.设置label的颜色
    newLabel.textColor = kSelectTitleColor;
    oldLabel.textColor = kNormalTitleColor;
    
    //3.scrollLine滚动到正确的位置
    CGFloat scrollLineEndX = _scrollLine.frame.size.width * (CGFloat)index;
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollLine.frame = CGRectMake(scrollLineEndX, self.scrollLine.frame.origin.y, self.scrollLine.frame.size.width, self.scrollLine.frame.size.height);
    }];
    
    // 4.记录index
    _currentIndex = index;

}
@end
