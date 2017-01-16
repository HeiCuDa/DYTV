//
//  HomeViewModel.h
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject

+ (void)requestRecommendData:(void (^)(NSDictionary *))success;

@end
