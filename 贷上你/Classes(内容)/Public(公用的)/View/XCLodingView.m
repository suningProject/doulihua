//
//  XCLodingView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/1.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCLodingView.h"

@implementation XCLodingView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSelf];
    }
    return self;
}

+ (void) show{
    XCLodingView *loading = [[XCLodingView alloc]initWithFrame:CGRectMake((screenWidth-60)/2, (screenHeight-60)/2-50, 60, 60)];
    loading.backgroundColor = [UIColor clearColor];
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    [window addSubview:loading];
}

- (void)hidden{
    [self removeFromSuperview];
}

- (void) setupSelf{
   UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
   [self addSubview:imageView];
    // 加载所有的动画图片
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i<=76; i++) {
        NSString *filename = [NSString stringWithFormat:@"图层 %d",i];
        NSString *file = [[NSBundle mainBundle] pathForResource:filename ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:file];
        [images addObject:image];
    }
    // 设置动画图片
    imageView.animationImages = images;
    // 设置播放次数
    imageView.animationRepeatCount = MAX_CANON;
    // 设置图片
    imageView.image = [UIImage imageNamed:@"stand_1"];
    // 设置动画的时间
    imageView.animationDuration = 50 * 0.04;
    // 开始动画
    [imageView startAnimating];
}

@end

