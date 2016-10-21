//
//  Node.h
//  Realm+YYModel
//
//  Created by 黄少华 on 2016/10/21.
//  Copyright © 2016年 黄少华. All rights reserved.
//

#import <Realm/Realm.h>
#import <YYModel/YYModel.h>

@interface Node : RLMObject<YYModel>

@property NSString *ID;
@property NSString *name;
@property NSString *url;
@property NSString *title;
@property NSString *title_alternative;
@property NSInteger topics;
@property  NSString *header;
@property  NSString *footer;
@property NSDate *created;
@end
