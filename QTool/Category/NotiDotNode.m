//
//  NotiDotNode.m
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import "NotiDotNode.h"
#import "MJExtension.h"
@implementation NotiDotNode
@synthesize childNodes = _childNodes;
- (void)setChildNodes:(NSMutableArray *)childNodes{
    if (childNodes && childNodes.count > 0) {
        if([childNodes.firstObject isKindOfClass:[NSDictionary class]]){
            _childNodes = [NotiDotNode mj_objectArrayWithKeyValuesArray:childNodes];
            return;
        }
    }
    _childNodes = childNodes;
}
- (NSMutableArray<NotiDotNode *> *)childNodes{
    if (!_childNodes) {
        _childNodes = [@[] mutableCopy];
    }
    return _childNodes;
}
- (BOOL)addChildNode:(NotiDotNode *)node{
    if (!node){
        return NO;
    }
    [self.childNodes addObject:node];
    return YES;
    
}
- (void)setCount:(NSInteger)count{
    _count = count;
    self.content = [NSString stringWithFormat:@"%ld",(long)count];
}
@end
