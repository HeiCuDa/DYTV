//
//  ZHHttpTool.m
//  真好
//
//  Created by apple on 15-10-19.
//  Copyright (c) 2015年 zhenhao. All rights reserved.
//  封装整个项目的GET\POST请求

#import "DYZBHttpTool.h"
#import "AFNetworking.h"
@implementation DYZBHttpTool



+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 10;
    [session POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }

    }];
   
}



+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer =  [AFHTTPRequestSerializer serializer];
    session.requestSerializer.timeoutInterval = 10;

    
    [session POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (ZHFormData *postData in formDataArray) {
            [formData appendPartWithFileData:postData.data name:postData.name fileName:postData.filename mimeType:postData.mimeType];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }

    }];
    
 
}




+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 30;
    
    [session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}


@end

/**
 *  用来封装文件数据的模型
 */
@implementation ZHFormData

@end
