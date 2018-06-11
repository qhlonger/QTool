//
//  UIView+QHUD.m
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import "UIView+QHUD.h"
#import <objc/runtime.h>
@implementation UIView (QHUD)

#pragma mark - 属性的getter和setter
static NSString *actIndicatorKey = @"actIndicatorKey";
static NSString *indicatorBgViewKey = @"indicatorBgViewKey";
static NSString *indicatorCoverKey = @"indicatorCoverKey";
static NSString *isHudShowKey = @"isHudShowKey";


- (void)setIsHudShow:(BOOL)isHudShow{
    objc_setAssociatedObject(self, &isHudShowKey, [NSNumber numberWithInteger:isHudShow ? 1 : 0] , OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isHudShow{
    NSNumber *a =  objc_getAssociatedObject(self, &isHudShowKey);
    if(a)
        return [a boolValue];
    return NO;
}
//==
- (UIActivityIndicatorView *)actIndicator{
    UIActivityIndicatorView *actView = objc_getAssociatedObject(self, &actIndicatorKey);
    if(actView)return actView;
    
    actView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    actView.color = [UIColor darkGrayColor];
    actView.hidesWhenStopped = YES;
    actView.hidden = YES;
    [self addSubview:actView];
    objc_setAssociatedObject(self, &actIndicatorKey, actView, OBJC_ASSOCIATION_RETAIN);
    return actView;
}
- (void)setActIndicator:(UIActivityIndicatorView *)actIndicator{
    objc_setAssociatedObject(self, &actIndicatorKey, actIndicator, OBJC_ASSOCIATION_RETAIN);
}
//==
- (UIView *)indicatorBgView{
    UIView *indicatorBgView = objc_getAssociatedObject(self, &indicatorBgViewKey);
    if(indicatorBgView)return indicatorBgView;
    
    indicatorBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    indicatorBgView.layer.cornerRadius = 5;
    indicatorBgView.layer.masksToBounds = YES;
    indicatorBgView.hidden = YES;
    
    [self addSubview:indicatorBgView];
    objc_setAssociatedObject(self, &indicatorBgViewKey, indicatorBgView, OBJC_ASSOCIATION_RETAIN);
    return indicatorBgView;
}
- (void)setIndicatorBgView:(UIView *)indicatorBgView{
    objc_setAssociatedObject(self, &indicatorBgViewKey, indicatorBgView, OBJC_ASSOCIATION_RETAIN);
}
//==
- (UIView *)indicatorCoverView{
    UIView *indicatorCoverView = objc_getAssociatedObject(self, &indicatorCoverKey);
    if(indicatorCoverView)return indicatorCoverView;
    
    indicatorCoverView = [[UIView alloc]initWithFrame:self.bounds];
    indicatorCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    indicatorCoverView.hidden = YES;
    [self addSubview:indicatorCoverView];
    objc_setAssociatedObject(self, &indicatorCoverKey, indicatorCoverView, OBJC_ASSOCIATION_RETAIN);
    return indicatorCoverView;
}
- (void)setIndicatorCoverView:(UIView *)indicatorCoverView{
    objc_setAssociatedObject(self, &indicatorCoverKey, indicatorCoverView, OBJC_ASSOCIATION_RETAIN);
}









- (void)startLoadingWithCover{
    [self bringSubviewToFront:self.indicatorCoverView];
    [self bringSubviewToFront:self.indicatorBgView];
    [self bringSubviewToFront:self.actIndicator];
    
    
    self.indicatorCoverView.hidden = NO;
    self.indicatorBgView.hidden = YES;
    self.actIndicator.hidden = NO;
    
    self.indicatorCoverView.userInteractionEnabled = YES;
    
    self.indicatorCoverView.frame = self.bounds;
    self.indicatorBgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.actIndicator.frame = self.indicatorBgView.frame;
    self.actIndicator.color = [UIColor whiteColor];
    
    [self.actIndicator startAnimating];
    
    
    self.isHudShow = NO;
    
    
    self.indicatorBgView.alpha = 0;
    self.actIndicator.alpha = 0;
    
    
    
    [UIView animateWithDuration:0.25 animations:^{
        self.actIndicator.alpha = 1;
        self.indicatorCoverView.alpha = 0.6;
    }completion:^(BOOL finished) {
        self.isHudShow = YES;
    }];
    
    
}
- (void)startLoadingWithBg{
    [self bringSubviewToFront:self.indicatorBgView];
    [self bringSubviewToFront:self.actIndicator];
    
    
    self.indicatorCoverView.hidden = YES;
    self.indicatorBgView.hidden = NO;
    self.actIndicator.hidden = NO;
    
    self.indicatorBgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.actIndicator.frame = self.indicatorBgView.frame;
    self.actIndicator.color = [UIColor whiteColor];
    
    
    
    [self.actIndicator startAnimating];
    self.isHudShow = NO;
    
    self.actIndicator.alpha = 0;
    self.indicatorBgView.alpha = 0;
    
    
    self.indicatorBgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.actIndicator.alpha = 1;
        self.indicatorBgView.alpha = 0.8;
        self.indicatorBgView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
        self.isHudShow = YES;
    }];
}
- (void)startLoading{
    [self bringSubviewToFront:self.actIndicator];
    self.indicatorCoverView.hidden = YES;
    self.indicatorBgView.hidden = YES;
    self.actIndicator.hidden = NO;
    
    self.indicatorBgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.actIndicator.frame = self.indicatorBgView.frame;
    self.actIndicator.color = [UIColor darkGrayColor];
    
    [self.actIndicator startAnimating];
    
    
    
    self.isHudShow = NO;
    
    
    
    self.actIndicator.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.actIndicator.alpha = 1;
    }completion:^(BOOL finished) {
        self.isHudShow = YES;
    }];
}


- (void)stopLoading{
    self.indicatorCoverView.userInteractionEnabled = NO;
    
    
    void(^doHideAction)(void) = ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorCoverView.alpha = 0;
            self.indicatorBgView.alpha = 0;
            self.actIndicator.alpha = 0;
            
            
            self.indicatorBgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }completion:^(BOOL finished) {
            
            [self.actIndicator stopAnimating];
            self.isHudShow = NO;
            self.indicatorCoverView.hidden = YES;
            self.indicatorBgView.hidden = YES;
            self.actIndicator.hidden = YES;
            
        }];
    };
    
    if(self.isHudShow){
        doHideAction();
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            doHideAction();
        });
    }
    
}


- (void)stopLoadingAndRemove{
    self.indicatorCoverView.userInteractionEnabled = NO;
    
    
    void(^doHideAction)(void) = ^{
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorCoverView.alpha = 0;
            self.indicatorBgView.alpha = 0;
            self.actIndicator.alpha = 0;
            
            
            self.indicatorBgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        }completion:^(BOOL finished) {
            
            [self.actIndicator stopAnimating];
            self.isHudShow = NO;
            self.indicatorCoverView.hidden = YES;
            self.indicatorBgView.hidden = YES;
            self.actIndicator.hidden = YES;
            [self.indicatorBgView removeFromSuperview];
            self.indicatorBgView = nil;
            [self.indicatorCoverView removeFromSuperview];
            self.indicatorCoverView = nil;
            [self.actIndicator removeFromSuperview];
            self.actIndicator = nil;
            
        }];
    };
    
    if(self.isHudShow){
        doHideAction();
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            doHideAction();
        });
    }
}


@end
