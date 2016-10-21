//
//  Node.m
//  Realm+YYModel
//
//  Created by 黄少华 on 2016/10/21.
//  Copyright © 2016年 黄少华. All rights reserved.
//

#import "Node.h"

@implementation Node

+ (NSString *)primaryKey {
    return @"ID";
}

+ (NSArray<NSString *> *)indexedProperties {
    return @[@"ID"];
}

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end
