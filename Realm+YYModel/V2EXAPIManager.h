//
//  V2EXAPIManager.h
//  Realm+YYModel
//
//  Created by 黄少华 on 2016/10/21.
//  Copyright © 2016年 黄少华. All rights reserved.
//

#import "SessionManager.h"
#import <AFNetworking.h>
#import "Node.h"

@interface V2EXAPIManager : SessionManager

- (NSURLSessionDataTask *)getAllNodeSuccess:(Success)success failurl:(Failure)failure;
@end
