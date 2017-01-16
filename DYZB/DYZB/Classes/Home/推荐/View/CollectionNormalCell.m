//
//  CollectionNormalCell.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#import "CollectionNormalCell.h"

@interface CollectionNormalCell()
@property(nonatomic,weak) IBOutlet     UIImageView *defaultImgView;

@end
@implementation CollectionNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _defaultImgView.layer.cornerRadius = 4;
    _defaultImgView.clipsToBounds = YES;
}

@end
