//
//  DYZBHomeRecommendViewController.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//
#define kNormalCellID       @"DYZBHomeRecommendCellIdentifier"
#define kRecommendHeaderID  @"RecommendHeaderView"
#define KPrettyCellID       @"CollectionPrettyCell"

#define kItemMargin  10
#define kItemW       (SCREEN_WIDTH - 3*kItemMargin)/2
#define kHeaderViewH 50
#define kNormalItemH kItemW * 3 / 4
#define kPrettyItemH kItemW * 4 / 3

#import "RecommendModel.h"
#import "HomeViewModel.h"
#import "RecommendHeaderView.h"
#import "CollectionPrettyCell.h"
#import "CollectionNormalCell.h"
#import "DYZBHomeRecommendViewController.h"

@interface DYZBHomeRecommendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UICollectionView    *collectionView;
@property(nonatomic, strong) NSMutableArray     *recommendData;

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
    
    __weak typeof(self) weakself = self;
    [HomeViewModel requestRecommendData:^(NSDictionary * result) {
        __strong typeof(self) strongself = weakself;
        strongself.recommendData = [result objectForKey:@"recommend"];
        [strongself.collectionView reloadData];
    }];
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
        _collectionView.delegate = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionNormalCell" bundle:nil] forCellWithReuseIdentifier:kNormalCellID];
        [_collectionView registerNib:[UINib nibWithNibName:kRecommendHeaderID bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kRecommendHeaderID];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionPrettyCell" bundle:nil] forCellWithReuseIdentifier:KPrettyCellID];
    }
    return _collectionView;
}


#pragma mark ---------------------------UICollectionView DataSource Method--------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _recommendData.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    RecommendModel  *recomendModel = _recommendData[section];
    return recomendModel.room_list.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    RecommendModel  *recomendModel = _recommendData[indexPath.section];
    
    if (indexPath.section == 1) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:KPrettyCellID forIndexPath:indexPath];
        CollectionPrettyCell *prettyCell = (CollectionPrettyCell *)cell;
        prettyCell.recommendRoom = recomendModel.room_list[indexPath.row];

    }else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNormalCellID forIndexPath:indexPath];
        CollectionNormalCell *normalCell = (CollectionNormalCell *)cell;
        normalCell.roomModel = recomendModel.room_list[indexPath.row];

    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    RecommendHeaderView *recomnedHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kRecommendHeaderID forIndexPath:indexPath];
    recomnedHeader.remmondModel = [_recommendData objectAtIndex:indexPath.section];
    return recomnedHeader;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return  CGSizeMake(kItemW, kPrettyItemH);
    }else{
        return CGSizeMake(kItemW, kNormalItemH);
    }
}
@end
