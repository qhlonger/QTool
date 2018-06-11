 //
//  UIView+NotiDot.m
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import "UIView+NotiDot.h"
#import <objc/runtime.h>
#import "NotiDotManager.h"
#import "Masonry.h"

@implementation UIView (NotiDot)

static NSString *Q_NotiDotLabelKey = @"Q_NotiDotLabelKey";
static NSString *Q_NotiKey = @"Q_NotiKey";
static NSString *Q_NotiNodeKey = @"Q_NotiNodeKey";


- (UILabel *)q_notiDotLabel{
    UILabel *q_notiDotLabel = objc_getAssociatedObject(self, &Q_NotiDotLabelKey);
    if(q_notiDotLabel)return q_notiDotLabel;
    
    q_notiDotLabel = [[UILabel alloc]init];
    q_notiDotLabel.backgroundColor = [UIColor redColor];
    q_notiDotLabel.textColor = [UIColor whiteColor];
    q_notiDotLabel.font = [UIFont systemFontOfSize:12];
    q_notiDotLabel.hidden = YES;
    q_notiDotLabel.frame = CGRectMake(0, 0, 50, 20);
    q_notiDotLabel.layer.cornerRadius = 10;
    q_notiDotLabel.layer.masksToBounds = YES;
    q_notiDotLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:q_notiDotLabel];
    [q_notiDotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.width.mas_greaterThanOrEqualTo(20);
        make.height.mas_equalTo(20);
    }];
    objc_setAssociatedObject(self, &Q_NotiDotLabelKey, q_notiDotLabel, OBJC_ASSOCIATION_RETAIN);
    return q_notiDotLabel;
}
- (void)setQ_notiDotLabel:(UIActivityIndicatorView *)q_notiDotLabel{
    objc_setAssociatedObject(self, &Q_NotiDotLabelKey, q_notiDotLabel, OBJC_ASSOCIATION_RETAIN);
}


- (void)setQ_noti:(NSString *)q_noti{
    objc_setAssociatedObject(self, &Q_NotiKey, q_noti, OBJC_ASSOCIATION_COPY);
}
- (NSString *)q_noti{
    return objc_getAssociatedObject(self, &Q_NotiKey);
}
- (void)setQ_notiNode:(NotiDotNode *)q_notiNode{
    objc_setAssociatedObject(self, &Q_NotiNodeKey, q_notiNode, OBJC_ASSOCIATION_RETAIN);
    NSLog(@"%@======================================================================%ld",q_notiNode.nodeID,(long)q_notiNode.count);
    
//    if (self.q_notiNode) {
//
//    }else{
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(q_notiNodeNoti:) name:Q_ReloadNotiDotNoti object:nil];
        [q_notiNode addObserver:self forKeyPath:@"nodeID" options:NSKeyValueObservingOptionNew context:nil];
        [q_notiNode addObserver:self forKeyPath:@"content" options:NSKeyValueObservingOptionNew context:nil];
        [q_notiNode addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
        [q_notiNode addObserver:self forKeyPath:@"father" options:NSKeyValueObservingOptionNew context:nil];
        [q_notiNode addObserver:self forKeyPath:@"childNodes" options:NSKeyValueObservingOptionNew context:nil];
    
//    }
    [self updateDot];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self updateDot];
    if ([keyPath isEqualToString:@"nodeID"]) {
        
    }else if ([keyPath isEqualToString:@"content"]) {
        
    }else if ([keyPath isEqualToString:@"count"]) {
        
    }else if ([keyPath isEqualToString:@"father"]) {
        
    }else if ([keyPath isEqualToString:@"childNodes"]) {
        
    }
    
}




- (void)updateDot{
//    self.q_notiDotLabel.backgroundColor = [UIColor redColor];
//    self.q_notiDotLabel.textColor = [UIColor whiteColor];
    NSLog(@"%@====%@======================================================================%ld",self.q_notiDotLabel,self.q_notiNode.nodeID,(long)self.q_notiNode.count);
    self.q_notiDotLabel.hidden = self.q_notiNode.count <= 0;
    if (self.q_notiNode.content) {
        self.q_notiDotLabel.text = [NSString stringWithFormat:@"%@", self.q_notiNode.content];
    }
//     reloadNoti
}
- (void)q_notiNodeNoti:(NSNotification *)noti{
    [self updateDot];
}
- (NotiDotNode *)q_notiNode{
    return objc_getAssociatedObject(self, &Q_NotiNodeKey);
}
- (void)layoutSubviews{
    
}


- (void)dealloc{
    if (self.q_notiNode) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
}




@end
