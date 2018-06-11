//
//  NotiDotNode.h
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotiDotNode : NSObject


/**
 节点id，可以通过id查找节点
 */
@property(nonatomic, copy) NSString *nodeID;

/**
 红点显示内容
 设置count时自动设置为对应数字
 若需自定义，在设置count之后设置content
 */
@property(nonatomic, copy) NSString *content;

/**
 计数
 若为0不显示红点
 */
@property(nonatomic, assign) NSInteger count;

/**
 节点的父节点
 */
@property(nonatomic, weak) NotiDotNode *father;

/**
 节点的子节点
 */
@property(nonatomic, strong) NSMutableArray <NotiDotNode *>*childNodes;


/**
 添加子节点

 @param node 节点
 @return 是否成功
 */
- (BOOL)addChildNode:(NotiDotNode *)node;
@end
