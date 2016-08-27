//
//  ABSWaitingButton.h
//  ABSWaitingButton
//
//  Created by absolute on 16/8/27.
//  Copyright © 2016年 Absolute. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABSWaitingButton : UIButton

/** 等待动画时间 */
@property (nonatomic, assign) CGFloat waitAniamtionDuration;

/** 开始创建按钮 */
+ (instancetype)startInitWithBackgroundColor:(UIColor *)color
                          withCenter:(CGPoint)center
                          withBounds:(CGRect)bounds
                  withTitleLableFont:(UIFont *)font
                     withNormalTitle:(NSString *)normalTitle
                           withColor:(UIColor *)normalColor
                   withSelectedTitle:(NSString *)selectedTitle
                           withColor:(UIColor *)selectedColor;


/** 开始等待 */
- (void)startWaiting;

/** 结束等待 */
- (void)endWaiting;

@end
