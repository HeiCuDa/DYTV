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
@property(nonatomic,weak) IBOutlet     UILabel     *nickNameLabel;
@property(nonatomic,weak) IBOutlet     UILabel     *roomNameLabel;
@property(nonatomic,weak) IBOutlet     UIButton    *onLineNumBtn;
@end

@implementation CollectionNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _defaultImgView.layer.cornerRadius = 4;
    _defaultImgView.clipsToBounds = YES;
}

- (void)setRoomModel:(RecomemndRoom *)roomModel
{
    _roomModel = roomModel;
    
    [self.defaultImgView sd_setImageWithURL:[NSURL URLWithString:roomModel.room_src] placeholderImage:[UIImage imageNamed:@"Img_default"]];
    self.nickNameLabel.text = roomModel.nickname;
    self.roomNameLabel.text = roomModel.room_name;
    [self.onLineNumBtn setTitle:roomModel.online forState:UIControlStateNormal];
}
@end
