//
//  NotiDotManager.m
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import "NotiDotManager.h"
#import "MJExtension.h"
@implementation NotiDotManager
static NSString *Q_ReloadNotiDotNoti = @"Q_ReloadNotiDotNoti";


+ (instancetype)sharedManager{
    static NotiDotManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NotiDotManager alloc]init];
    });
    return manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initNotiTree];
        [self setupFather:self.mainNotiNode];
    }
    return self;
}

/**
 为目标节点的所有子节点设置父亲

 @param node 目标节点
 */
- (void)setupFather:(NotiDotNode *)node{
    for (NotiDotNode *n in node.childNodes) {
        n.father = node;
        [self setupFather:n];
    }
}

- (void)reloadNoti{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:Q_ReloadNotiDotNoti object:nil];
}

/**
 刷新目标节点

 @param node 节点
 */
- (void)refreshNode:(NotiDotNode *)node{
    
    [self updateFatherNode:node];
    if(node.count == 0)
        [self clearChildNodes:node];
    
    [self reloadNoti];
}

/**
 当节点count为0时，清空子节点

 @param node 节点
 */
- (void)clearChildNodes:(NotiDotNode *)node{
    if (node.childNodes && node.childNodes.count > 0) {
        for (NotiDotNode *n in node.childNodes) {
            n.count = 0;
            [self clearChildNodes:n];
        }
    }
}
/**
 更新节点
 
 @param node 从某个节点往上更新父亲节点
 */
- (void)updateFatherNode:(NotiDotNode *)node{
    if (node.father){
        NSInteger cnt = 0;
        //遍历兄弟节点
        for (NotiDotNode *n in node.father.childNodes) {
            cnt += n.count;
        }
        node.father.count = cnt;
        
        [self updateFatherNode:node.father];
    }
}

/**
 根据id获取节点，并在block中修改

 @param nodeId id
 @param setup block
 */
- (void)setupNode:(NSString *)nodeId setup:(void(^)(NotiDotNode *node))setup{
    NotiDotNode *node = [self getNodeByID:nodeId node:self.mainNotiNode];
    if (setup)setup(node);
    [self reloadNoti];
    
}
- (NotiDotNode *)getNodeByID:(NSString *)nodeID{
    if(!nodeID)return nil;
    return [self getNodeByID:nodeID node:self.mainNotiNode];
}
- (NotiDotNode *)getNodeByID:(NSString *)nodeID node:(NotiDotNode *)node{
    if([node.nodeID isEqualToString:nodeID]){
        return node;
    }
    if (!node.childNodes || node.childNodes.count == 0){
        return nil;
    }
    

    NotiDotNode *nd = nil;
    for (NotiDotNode *n in node.childNodes) {
        if([n.nodeID isEqualToString:nodeID]){
            nd = n;
            break;
        }else{
            nd = [self getNodeByID:nodeID node:n];
            if(nd)
                break;
        }
    }
    return nd;
}

- (void)initNotiTree{
    
    NSDictionary *mainNode = @{
                               @"nodeID":@"main",
                               @"content":@"",
                               @"count":@40,
                               @"childNodes":@[
                                       @{
                                           @"nodeID":@"msg",
                                           @"content":@"10",
                                           @"count":@20,
                                           @"childNodes":@[
                                                   @{
                                                       @"nodeID":@"msg1",
                                                       @"content":@"5",
                                                       @"count":@5,
                                                       },
                                                   @{
                                                       @"nodeID":@"msg2",
                                                       @"content":@"5",
                                                       @"count":@15,
                                                       },
                                                   
                                                   ]
                                           },
                                       @{
                                           @"nodeID":@"mine",
                                           @"content":@"10",
                                           @"count":@20,
                                           @"childNodes":@[
                                                   
                                                   @{
                                                       @"nodeID":@"mine1",
                                                       @"content":@"5",
                                                       @"count":@5,
                                                       },
                                                   @{
                                                       @"nodeID":@"mine2",
                                                       @"content":@"5",
                                                       @"count":@15,
                                                       },
                                                   
                                                   ]
                                           },
                                       
                                       ]
                               };
     
     
    self.mainNotiNode = [NotiDotNode mj_objectWithKeyValues:mainNode];
    
    
}
@end
