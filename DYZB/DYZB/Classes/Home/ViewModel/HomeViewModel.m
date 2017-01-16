//
//  HomeViewModel.m
//  DYZB
//
//  Created by Apple's Mac on 2017/1/16.
//  Copyright © 2017年 Apple's Mac. All rights reserved.
//

#import "RecommendModel.h"
#import "HomeViewModel.h"

@implementation HomeViewModel


+ (void)requestRecommendData:(void (^)(NSDictionary *))success
{
    NSMutableArray      *recommendArr = @[].mutableCopy;

    NSString *requestURLStr = [NSString stringWithFormat:@"%@%@",DYZB_URL_Base,DYZB_URL_HotData];
    [DYZBHttpTool postWithURL:requestURLStr params:nil success:^(id json) {
        
        if ([[json objectForKey:@"error"] integerValue] == 0) {
            
            [recommendArr addObjectsFromArray:[RecommendModel mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]]];

            success(@{@"recommend":recommendArr});
        }
        
    } failure:^(NSError *error) {
        
    }];

}


/*
+ (void)requestRecommendData:(void (^)(NSDictionary *))success
{

    __block NSMutableDictionary *recomemndDataDict = @{}.mutableCopy;
    NSMutableArray      *hotDataArr = @[].mutableCopy;
    NSMutableArray      *prettyDataArr = @[].mutableCopy;
    NSMutableArray      *bigDataArr = @[].mutableCopy;
    
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_group_t group=dispatch_group_create();

    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        NSString *requestURLStr = [NSString stringWithFormat:@"%@%@",DYZB_URL_Base,DYZB_URL_HotData];
        [DYZBHttpTool postWithURL:requestURLStr params:nil success:^(id json) {
            
            if ([[json objectForKey:@"error"] integerValue] == 0) {
                [hotDataArr addObjectsFromArray:[HotDataModel mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]]];
                [recomemndDataDict setObject:hotDataArr forKey:@"hotData"];
                
                }
            dispatch_group_leave(group);
            
        } failure:^(NSError *error) {
            dispatch_group_leave(group);

        }];

    });
    
    
    dispatch_group_enter(group);

    dispatch_group_async(group, queue, ^{
        NSString *requestURLStr = [NSString stringWithFormat:@"%@%@",DYZB_URL_Base,DYZB_URL_PrettyData];
        [DYZBHttpTool postWithURL:requestURLStr params:nil success:^(id json) {
            
            
            if ([[json objectForKey:@"error"] integerValue] == 0) {
                [prettyDataArr addObjectsFromArray:[PrettyDataModel mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]]];
                
                [recomemndDataDict setObject:prettyDataArr forKey:@"prettyData"];
            }
            
            dispatch_group_leave(group);

        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
        
    });

    dispatch_group_enter(group);

    dispatch_group_async(group, queue, ^{
        NSString *requestURLStr = [NSString stringWithFormat:@"%@%@",DYZB_URL_Base,DYZB_URL_HotData];
        [DYZBHttpTool postWithURL:requestURLStr params:nil success:^(id json) {
            
            if ([[json objectForKey:@"error"] integerValue] == 0) {
                [bigDataArr addObjectsFromArray:[BigDataModel mj_objectArrayWithKeyValuesArray:[json objectForKey:@"data"]]];
                [recomemndDataDict setObject:bigDataArr forKey:@"bigData"];

            }

            dispatch_group_leave(group);

        } failure:^(NSError *error) {
            dispatch_group_leave(group);
        }];
    });

    dispatch_notify(group, queue, ^{
    
        if (success) {
            success(recomemndDataDict);
        }
    });
    
}
 */
@end
