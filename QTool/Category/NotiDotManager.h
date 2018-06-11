//
//  NotiDotManager.h
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotiDotNode.h"

static NSString *Q_ReloadNotiDotNoti;

@interface NotiDotManager : NSObject

+ (instancetype)sharedManager;

- (void)refreshNode:(NotiDotNode *)node;
- (void)reloadNoti;
- (NotiDotNode *)getNodeByID:(NSString *)nodeID;
- (void)setupNode:(NSString *)nodeId setup:(void(^)(NotiDotNode *node))setup;



/**
 app主节点,
 图标节点
 */
@property(nonatomic, strong) NotiDotNode *mainNotiNode;

@end
