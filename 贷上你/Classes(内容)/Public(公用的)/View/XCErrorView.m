
//
//  XCErrorView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/10.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCErrorView.h"
@interface XCErrorView()
@property(nonatomic,strong)UIImageView *image;
@property(nonatomic,strong)UILabel *title;
@property(nonatomic,strong)UIButton *des;
@end

@implementation XCErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Nonetwork"]];
        self.image.frame = CGRectMake((screenWidth-150)/2, 140, 152, 111);
        [self addSubview:self.image];
        
        self.title = [UILabel labelWithText:@"请检查网络并重试" textClolor:colorFromRGB(0xAAABB1) font:15 frame:CGRectMake(0, CGRectGetMaxY(self.image.frame)+25, screenWidth, 20)];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];

        self.des = [UIButton buttonWithText:@"重新加载" font:15 nmlTitleColor:colorFromRGB(0xFF2726) hightTitleColor:colorFromRGB(0xFF2726) frame:CGRectMake(0, CGRectGetMaxY(self.title.frame)+16, screenWidth, 20)];
        self.des.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.des addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.des];
    }
    return self;
}

- (void)clickBlock:(clickBlock)block{
  
     _clickBlock = block;
}

- (void) click{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程一
    });
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程二
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        // 汇总结果
    });
    [XCNetworking key:^(NSString * _Nonnull key) {
        [[NSUserDefaults standardUserDefaults]setObject:key forKey:@"key"];
    }];
    [XCNetworking encryption:^(NSString * _Nonnull key) {
        [[NSUserDefaults standardUserDefaults]setObject:key forKey:@"encryption"];
        }];
    if (self.clickBlock) {
        self.clickBlock();
    }
  
}


-(void)hidden{
    [self removeFromSuperview];
}

+ (instancetype)shareInstance {
    static XCErrorView *loading = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loading = [[XCErrorView alloc] init];
    });
    return loading;
}

@end
