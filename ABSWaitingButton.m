//
//  ABSWaitingButton.m
//  ABSWaitingButton
//
//  Created by absolute on 16/8/27.
//  Copyright © 2016年 Absolute. All rights reserved.
//

#import "ABSWaitingButton.h"

@implementation ABSWaitingButton {
    BOOL _isWaiting;
    UIView * _waitingView;
    CALayer * _waitingLayer;
    UIActivityIndicatorView * _indicator;
}

+ (instancetype)startInitWithBackgroundColor:(UIColor *)color
                          withCenter:(CGPoint)center
                          withBounds:(CGRect)bounds
                  withTitleLableFont:(UIFont *)font
                     withNormalTitle:(NSString *)normalTitle
                           withColor:(UIColor *)normalColor
                   withSelectedTitle:(NSString *)selectedTitle
                           withColor:(UIColor *)selectedColor {
    ABSWaitingButton *waitingButton = [ABSWaitingButton buttonWithType:UIButtonTypeCustom];
    waitingButton.backgroundColor = [UIColor blueColor];
    waitingButton.center = center;
    waitingButton.bounds = bounds;

    waitingButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [waitingButton setTitle:normalTitle forState:UIControlStateNormal];
    [waitingButton setTitle:selectedTitle forState:UIControlStateSelected];
    
    [waitingButton setTitleColor:normalColor forState:UIControlStateNormal];
    [waitingButton setTitleColor:selectedColor forState:UIControlStateSelected];
    
    [waitingButton setBackgroundImage:[self colorToImage:[UIColor colorWithRed:120/255.0 green:180/255.0 blue:130/255.0 alpha:1]] forState:UIControlStateNormal];
    [waitingButton setBackgroundImage:[self colorToImage:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1]] forState:UIControlStateSelected];
    return waitingButton;
}

- (void)startWaiting {
    if (_isWaiting)  return;
    _isWaiting = YES;
    [self startWaitingAnimation];
}

- (void)endWaiting {
    if (!_isWaiting) return;
    _indicator.alpha = 0;
    _isWaiting = NO;
    [self endWaitingAnimation];
}

- (void)startWaitingAnimation {
    [self addSubview:[self waitingView]];
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue  = @(5);
    scaleAnimation.duration = self.waitAniamtionDuration;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    scaleAnimation.delegate = self;
    [_waitingLayer addAnimation:scaleAnimation forKey:@"ABSWaitingButtonStartWaiting_scale"];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @(0);
    opacityAnim.toValue = @(1);
    opacityAnim.duration = self.waitAniamtionDuration;
    opacityAnim.fillMode = kCAFillModeForwards;
    opacityAnim.removedOnCompletion = NO;
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_waitingLayer addAnimation:opacityAnim forKey:@"ABSWaitingButtonStartWaiting_opacity"];
}

- (void)endWaitingAnimation {
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue  = @(1);
    scaleAnimation.duration = self.waitAniamtionDuration;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.delegate = self;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_waitingLayer addAnimation:scaleAnimation forKey:@"ABSWaitingButtonEndWaiting_scale"];
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnim.fromValue = @(1);
    opacityAnim.toValue = @(0);
    opacityAnim.duration = self.waitAniamtionDuration;
    opacityAnim.fillMode = kCAFillModeForwards;
    opacityAnim.removedOnCompletion = NO;
    opacityAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [_waitingLayer addAnimation:opacityAnim forKey:@"ABSWaitingButtonEndWaiting_opacity"];
}

- (void)setHighlighted:(BOOL)highlighted {
    self.alpha = highlighted? 0.85: 1;
}

// core animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (_isWaiting) {
        _indicator.alpha = 1;
    } else {
        [[self waitingView] removeFromSuperview];
    }
}

// lazy load
- (UIView *)waitingView {
    if (!_waitingView) {
        _waitingView = [UIView new];
        _waitingView.frame = (CGRect){CGPointZero, self.frame.size};
        _waitingView.clipsToBounds = YES;
        [_waitingView.layer addSublayer:[self waitingLayer]];
        _waitingLayer.frame = (CGRect){CGPointMake((_waitingView.frame.size.width - [self deafultWaitingViewSize].width)/2.0, (_waitingView.frame.size.height - [self deafultWaitingViewSize].width)/2.0), [self deafultWaitingViewSize]};
        [_waitingView addSubview:[self indicator]];
        [_indicator startAnimating];
    }
    return _waitingView;
}

- (CALayer *)waitingLayer {
    if (!_waitingLayer) {
        _waitingLayer = [CALayer layer];
        _waitingLayer.backgroundColor = [UIColor grayColor].CGColor;
        _waitingLayer.cornerRadius = [self deafultWaitingViewSize].height/2.0;
    }
    return _waitingLayer;
}

- (UIActivityIndicatorView *)indicator {
    if (!_indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _indicator.backgroundColor = [UIColor whiteColor];
        _indicator.frame = (CGRect){CGPointMake((_waitingView.frame.size.width - [self deafultIndicatorSize].width)/2.0, (_waitingView.frame.size.height - [self deafultIndicatorSize].width)/2.0), [self deafultIndicatorSize]};
        _indicator.backgroundColor = [UIColor clearColor];
        _indicator.alpha = 0;
    }
    return _indicator;
}

- (CGSize)deafultWaitingViewSize {
    return CGSizeMake(self.frame.size.height * 0.8, self.frame.size.height * 0.8);
}


- (CGSize)deafultIndicatorSize {
    return CGSizeMake(self.frame.size.height * 0.8, self.frame.size.height * 0.8);
}

- (CGFloat)waitAniamtionDuration {
    if (_waitAniamtionDuration == 0) {
        _waitAniamtionDuration = 1;
    }
    return _waitAniamtionDuration;
}

+ (UIImage *)colorToImage:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
