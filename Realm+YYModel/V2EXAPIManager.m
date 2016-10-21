//
//  V2EXAPIManager.m
//  Realm+YYModel
//
//  Created by 黄少华 on 2016/10/21.
//  Copyright © 2016年 黄少华. All rights reserved.
//

#import "V2EXAPIManager.h"

static NSString *allNodelUrl = @"nodes/all.json";

@implementation V2EXAPIManager
- (NSURLSessionDataTask *)getAllNodeSuccess:(Success)success failurl:(Failure)failure {
    return [self GETWithUrl:allNodelUrl params:nil success:^(id data) {
        NSArray *allNodes = [NSArray yy_modelArrayWithClass:[Node class] json:data];
        if (success) {
            success(allNodes);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task,error);
        }
    }];
}
@end
