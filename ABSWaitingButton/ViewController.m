//
//  ViewController.m
//  ABSWaitingButton
//
//  Created by absolute on 16/8/27.
//  Copyright © 2016年 Absolute. All rights reserved.
//

#import "ViewController.h"
#import "ABSWaitingButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ABSWaitingButton *waitingButton = [ABSWaitingButton startInitWithBackgroundColor:[UIColor blueColor]
                                                                          withCenter:self.view.center
                                                                          withBounds:CGRectMake(0, 0, 100, 40)
                                                                  withTitleLableFont:[UIFont systemFontOfSize:15]
                                                                     withNormalTitle:@"关注"
                                                                           withColor:[UIColor whiteColor]
                                                                   withSelectedTitle:@"已关注"
                                                                           withColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1]];
    [waitingButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    waitingButton.layer.cornerRadius = 3;
    waitingButton.clipsToBounds = YES;
    [self.view addSubview:waitingButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClick:(ABSWaitingButton *)sender {
    if (sender.selected == YES) {
        // - 取消关注时的按钮缩小效果
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.toValue  = @(0.9);
        scaleAnimation.duration = 0.3;
        scaleAnimation.autoreverses = YES;
        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [sender.layer addAnimation:scaleAnimation forKey:@"ABSWaitingButtonSelect_scale"];
    }
    
    [sender startWaiting];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.selected = !sender.selected;
        [sender endWaiting];
    });
}

//- (UIImage *)colorToImage:(UIColor *)color {
//    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}

@end
