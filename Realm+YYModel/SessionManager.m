//
//  SessionManager.m
//  Realm+YYModel
//
//  Created by 黄少华 on 2016/10/21.
//  Copyright © 2016年 黄少华. All rights reserved.
//

#import "SessionManager.h"

static NSString *const kBaseURL = @"http://www.v2ex.com/api/";
typedef NS_ENUM(NSInteger, APIMethod) {
    APIMethodGET,
    APIMethodPOST,
    APIMethodPUT,
    APIMethodDELETE,
};

@implementation SessionManager
+ (instancetype)shareManager {
    static SessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.requestSerializer.timeoutInterval = 30;
    return self;
}

//instance method
- (NSURLSessionDataTask *)GETWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure {
    return [self requestWithMethod:APIMethodGET url:url params:params success:success failure:failure];
}
- (NSURLSessionDataTask *)POSTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure {
    return [self requestWithMethod:APIMethodPOST url:url params:params success:success failure:failure];;
}
- (NSURLSessionDataTask *)PUTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure {
    return [self requestWithMethod:APIMethodPUT url:url params:params success:success failure:failure];
}
- (NSURLSessionDataTask *)DELETEWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure {
    return [self requestWithMethod:APIMethodDELETE url:url params:params success:success failure:failure];
}

//class method
+ (NSURLSessionDataTask *)GETWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure {
    return [[self shareManager] GETWithUrl:url params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)POSTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    return [[self shareManager] POSTWithUrl:url params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)PUTWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    return [[self shareManager] PUTWithUrl:url params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)DELETEWithUrl:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure{
    return [[self shareManager] DELETEWithUrl:url params:params success:success failure:failure];
}


- (NSURLSessionDataTask *)requestWithMethod:(APIMethod)method url:(NSString *)url params:(NSDictionary *)params success:(Success)success failure:(Failure)failure {

    if (![url hasPrefix:@"http"]) {
        url = [[self class] reponseUrl:url];
    }
    if ([url rangeOfString:@":id"].length > 0 ) {
        NSAssert(NO, @"路径 「%@」中有需要替换的id", url);
    }
    NSURLSessionDataTask *task = nil;
    switch (method) {
        case APIMethodGET: {
            task = [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleTask:task response:responseObject success:success];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleTask:task error:error failure:failure];
            }];
            break;
        }
        case APIMethodPOST: {
            task = [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleTask:task response:responseObject success:success];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleTask:task error:error failure:failure];
            }];
            break;
        }
        case APIMethodPUT: {
            task = [self PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleTask:task response:responseObject success:success];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleTask:task error:error failure:failure];
            }];
            break;
        }
        case APIMethodDELETE: {
            task = [self DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleTask:task response:responseObject success:success];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleTask:task error:error failure:failure];
                
            }];
            break;
        }
    }
    return task;
}

+ (NSString *)reponseUrl:(NSString *)url{
    NSString *result = url;
    result = [NSString stringWithFormat:@"%@\%@", kBaseURL, result];
    return  result;
}

#pragma mark - handle response
- (void)handleTask:(NSURLSessionDataTask *)task response:(id)responseOject success:(Success)success {
    if (success) {
        success(responseOject);
    }
}
//!!!: 额外处理错误，上报和反馈给用户的信息区分
- (void)handleTask:(NSURLSessionDataTask *)task error:(NSError *)error failure:(Failure)failure{
   //handle error
}
@end
