//
//  RecommendModel.h
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

@interface RecomemndRoom : NSObject 
@property(nonatomic, strong) NSString    *specific_catalog;
@property(nonatomic, strong) NSString    *vertical_src;
@property(nonatomic, strong) NSString    *nickname;
@property(nonatomic, strong) NSString    *room_src;
@property(nonatomic, strong) NSString    *game_name;
@property(nonatomic, strong) NSString    *avatar_small;
@property(nonatomic, strong) NSString    *online;
@property(nonatomic, strong) NSString    *avatar_mid;
@property(nonatomic, strong) NSString    *room_name;
@property(nonatomic, strong) NSString    *show_time;
@property(nonatomic, strong) NSString    *show_status;
@property(nonatomic, strong) NSString    *anchor_city;

@end

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

@property(nonatomic, strong) NSArray     *room_list;
@property(nonatomic, strong) NSString    *push_vertical_screen;
@property(nonatomic, strong) NSString    *icon_url;
@property(nonatomic, strong) NSString    *tag_name;
@property(nonatomic, strong) NSString    *push_nearby;
@property(nonatomic, strong) NSString    *tag_id;

@end
