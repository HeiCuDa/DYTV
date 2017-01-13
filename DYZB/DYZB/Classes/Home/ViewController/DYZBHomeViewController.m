//
//  DYZBHomeViewController.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/12.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//
#import "PageTitleView.h"
#import "PageCotentView.h"
#import "UIBarButtonItem+DYZB.h"

#import "DYZBHomePlayViewController.h"      //趣玩
#import "DYZBHomeGameViewController.h"      //游戏
#import "DYZBHomeFunnyViewController.h"     //娱乐
#import "DYZBHomeRecommendViewController.h" //推荐

#import "DYZBHomeViewController.h"

@interface DYZBHomeViewController ()<PageTitleViewDelegate,PageCotentViewDelegate>

@property(nonatomic, strong) PageTitleView  *titleView;
@property(nonatomic, strong) PageCotentView *contentView;

@end

@implementation DYZBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets=NO; 
    [self setupNavigationBar];
    [self setupPageTitleView];
    [self setupPageContentView];
}


#pragma mark ---------------配置导航栏-----------------------
- (void)setupNavigationBar
{
    [self setupNavigationLeftBar];
    [self setupNavigationRightBar];
}


- (void)setupNavigationLeftBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImageName:@"logo" highImageName:nil size:CGSizeMake(66, 26) target:self action:@selector(leftItemClick)];
}


- (void)setupNavigationRightBar
{
    CGSize size = CGSizeMake(40, 40);
    
    UIBarButtonItem *historyItem = [[UIBarButtonItem alloc] initWithImageName:@"image_my_history" highImageName:@"image_my_history_click" size:size target:self action:@selector(historyItemClick)];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImageName:@"btn_search" highImageName:@"btn_search_click" size:size target:self action:@selector(searchItemClick)];
    UIBarButtonItem *qrCodeItem = [[UIBarButtonItem alloc] initWithImageName:@"image_scan" highImageName:@"image_scan_click" size:size target:self action:@selector(qrCodeItemClick)];
    
    self.navigationItem.rightBarButtonItems = @[qrCodeItem,historyItem,searchItem];
}

//配置Title菜单栏
- (void)setupPageTitleView
{
    _titleView = [[PageTitleView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 44) isScrollEnable:NO titles:@[@"推荐",@"游戏",@"娱乐",@"趣玩"]];
    _titleView.backgroundColor = [UIColor whiteColor];
    _titleView.delegate = self;
    [self.view addSubview:_titleView];
}

- (void)setupPageContentView
{
    
    DYZBHomeGameViewController      *gameVC         =   [[DYZBHomeGameViewController alloc] init];
    DYZBHomePlayViewController      *playVC         =   [[DYZBHomePlayViewController alloc] init];
    DYZBHomeFunnyViewController     *funnyVC        =   [[DYZBHomeFunnyViewController alloc] init];
    DYZBHomeRecommendViewController *recommendVC    =   [[DYZBHomeRecommendViewController alloc] init];
    
    CGFloat contentY = CGRectGetMaxY(_titleView.frame);
    _contentView = [[PageCotentView alloc] initWithFrame:CGRectMake(0, contentY, self.view.bounds.size.width, self.view.bounds.size.height - contentY - 44)
                                                childVcs:@[gameVC,playVC,funnyVC,recommendVC]
                                    parentViewController:self];
    _contentView.delegate = self;
    [self.view addSubview:_contentView];
    
}

#pragma mark -------------------------------导航栏响应方法--------------------------------------------------------------
- (void)leftItemClick
{
    NSLog(@"chenlaoshi");
    NSLog(@"%s",__FUNCTION__);
}


- (void)historyItemClick
{
    NSLog(@"%s",__FUNCTION__);
}


- (void)searchItemClick
{
    NSLog(@"%s",__FUNCTION__);
}


- (void)qrCodeItemClick
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark ---------------------PageTitleView Delegate Method------------------------------------------------------
- (void)pageTitleView:(PageTitleView *)pageTitleView didSelectedIndex:(NSInteger)index
{
    [self.contentView scrollToIndex:index];
}


#pragma mark ---------------------PageContentView Delegate Method----------------------------------------------------
- (void)pageCotentView:(PageCotentView *)pageContentView sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress
{
    [self.titleView setCurrentTitleWithSourceIndex:sourceIndex targetIndex:targetIndex progress:progress];
}

@end
