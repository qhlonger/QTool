//
//  UIView+QHUD.h
//  QTool
//
//  Created by pingguo on 2018/5/13.
//  Copyright © 2018年 hl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (QHUD)

@property(nonatomic, strong, readonly) UIActivityIndicatorView *actIndicator;
@property(nonatomic, strong, readonly) UIView *indicatorBgView;
@property(nonatomic, strong, readonly) UIView *indicatorCoverView;
/**
 防止HUD一闪而过
 */
@property(nonatomic, assign) BOOL isHudShow;


- (void)startLoadingWithCover;
- (void)startLoadingWithBg;
- (void)startLoading;
- (void)stopLoading;
- (void)stopLoadingAndRemove;

@end
