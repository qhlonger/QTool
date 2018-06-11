//
//  UIView+NotiDot.h
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotiDotNode.h"

@interface UIView (NotiDot)

@property(nonatomic, weak) UILabel *q_notiDotLabel;

@property(nonatomic, assign) NSString *q_noti;

@property(nonatomic, strong) NotiDotNode *q_notiNode;

//@property(nonatomic, copy) void(^onNotiNodeChanged) (NotiDotNode *q_notiNode);

- (void)updateDot;

@end
