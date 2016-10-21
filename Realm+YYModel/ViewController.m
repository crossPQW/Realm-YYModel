//
//  ViewController.m
//  Realm+YYModel
//
//  Created by 黄少华 on 2016/10/20.
//  Copyright © 2016年 黄少华. All rights reserved.
//

#import "ViewController.h"
#import "V2EXAPIManager.h"
#import "Node.h"
#import <RLMRealm.h>
#import <SafariServices/SafariServices.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) RLMResults *nodes;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Nodes";
    
    [self getNodes];
}

#pragma mark - private method
- (void)getNodes {
    [[V2EXAPIManager shareManager] getAllNodeSuccess:^(id data) {
        NSArray *nodes;
        if ([data isKindOfClass:[NSArray class]]) {
            nodes = data;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            @autoreleasepool {
                //delete old data
                RLMRealm *realm = [RLMRealm defaultRealm];
                [realm beginWriteTransaction];
                [realm deleteAllObjects];
                [realm commitWriteTransaction];
                
                //add new data
                [realm beginWriteTransaction];
                for (Node *node in nodes) {
                    [realm addObject:node];
                }
                [realm commitWriteTransaction];
                
                //retrieve data and reload data in main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    RLMRealm *mainThreadRealm = [RLMRealm defaultRealm];
                    self.nodes = [Node allObjectsInRealm:mainThreadRealm];
                    [self.tableview reloadData];
                });
            }
        });
    } failurl:^(NSURLSessionDataTask *task, NSError *error) {
        self.nodes = [Node allObjects];
        [self.tableview reloadData];
    }];
}

#pragma mark - UITableviewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Node *node = self.nodes[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NodeCell" forIndexPath:indexPath];
    cell.textLabel.text = node.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Node *node = self.nodes[indexPath.row];
    SFSafariViewController *vc = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:node.url]];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
