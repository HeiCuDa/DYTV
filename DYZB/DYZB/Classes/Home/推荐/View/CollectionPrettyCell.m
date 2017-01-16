//
//  CollectionPrettyCell.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#import "CollectionPrettyCell.h"

@interface CollectionPrettyCell ()
@property(nonatomic, weak) IBOutlet UIImageView *prettyImageView;
@property(nonatomic, weak) IBOutlet UILabel     *onlineLable;
@property(nonatomic, weak) IBOutlet UILabel     *nickNameLabel;
@property(nonatomic, weak) IBOutlet UILabel     *cityLabel;

@end
@implementation CollectionPrettyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendRoom:(RecomemndRoom *)recommendRoom
{
    _recommendRoom = recommendRoom;

    [_prettyImageView sd_setImageWithURL:[NSURL URLWithString:_recommendRoom.room_src] placeholderImage:[UIImage imageNamed:@"live_cell_default_phone"]];
    _onlineLable.text = [NSString stringWithFormat:@"%@在线",_recommendRoom.online];
    _nickNameLabel.text = _recommendRoom.nickname;
    _cityLabel.text = _recommendRoom.anchor_city;
}

@end
