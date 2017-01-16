//
//  RecommendHeaderView.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#import "RecommendHeaderView.h"

@interface RecommendHeaderView ()
@property(nonatomic,weak) IBOutlet         UILabel *categroyName;
@end
@implementation RecommendHeaderView

- (void)setRemmondModel:(RecommendModel *)remmondModel
{
    _remmondModel = remmondModel;
    _categroyName.text = _remmondModel.tag_name;
}

@end
