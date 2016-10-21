//
//  SessionManager.h
//  Realm+YYModel
//
//  Created by 黄少华 on 2016/10/21.
//  Copyright © 2016年 黄少华. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^Success)(id data);
typedef void(^Failure)(NSURLSessionDataTask *task, NSError *error);

@interface SessionManager : AFHTTPSessionManager
+ (instancetype)shareManager;

- (NSURLSessionDataTask *)GETWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
- (NSURLSessionDataTask *)POSTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
- (NSURLSessionDataTask *)PUTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
- (NSURLSessionDataTask *)DELETEWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;

+ (NSURLSessionDataTask *)GETWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
+ (NSURLSessionDataTask *)POSTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
+ (NSURLSessionDataTask *)PUTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
+ (NSURLSessionDataTask *)DELETEWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure;
@end
