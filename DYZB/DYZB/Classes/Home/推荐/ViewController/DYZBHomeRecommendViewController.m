//
//  DYZBHomeRecommendViewController.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//
#define kNormalCellID       @"DYZBHomeRecommendCellIdentifier"
#define kRecommendHeaderID  @"RecommendHeaderView"

#define kItemMargin  10
#define kItemW       (SCREEN_WIDTH - 3*kItemMargin)/2
#define kHeaderViewH 50
#define kNormalItemH kItemW * 3 / 4
#define kPrettyItemH kItemW * 4 / 3

#import "CollectionNormalCell.h"
#import "DYZBHomeRecommendViewController.h"

@interface DYZBHomeRecommendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView    *collectionView;

@end

@implementation DYZBHomeRecommendViewController

#pragma mark -----------------------------View CycleLife---------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}


#pragma mark ----------------------------Lazy Load -------------------------------------
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        //1.创建布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kItemW, kNormalItemH);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = kItemMargin;
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, kHeaderViewH);
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin);
        
        
        //2.创建UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionNormalCell" bundle:nil] forCellWithReuseIdentifier:kNormalCellID];
        [_collectionView registerNib:[UINib nibWithNibName:kRecommendHeaderID bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecommendHeaderID];
        
    }
    return _collectionView;
}


#pragma mark ---------------------------UICollectionView DataSource Method--------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellID forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kRecommendHeaderID forIndexPath:indexPath];
}


@end
