//
//  XCThemeView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/16.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCThemeView.h"

@implementation XCThemeView

- (void)themeClick:(themeClickBlock)block{
    self.themeClick = block;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth-30, 168)];
        image.image = [UIImage imageNamed:@"bg"];
        [self addSubview:image];
        
        self.top = [UILabel labelWithText:@"最高可借金额" textClolor:[UIColor whiteColor] font:15 frame:CGRectMake(0, 29, self.w, 16)];
        self.top.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        self.top.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.top];

        self.money = [UILabel labelWithText:@"2000.00" textClolor:[UIColor whiteColor] font:40 frame:CGRectMake(0, CGRectGetMaxY(self.top.frame)+15, self.w/2+65, 32)];
        self.money.font = [UIFont fontWithName:@"DIN-Medium" size:40];
        self.money.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.money];

        UILabel *unit= [UILabel labelWithText:@"元" textClolor:[UIColor whiteColor] font:18 frame:CGRectMake(CGRectGetMaxX(self.money.frame)+5, CGRectGetMaxY(self.money.frame)-17.5, 17, 16)];
        unit.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
        unit.textAlignment = NSTextAlignmentLeft;
        [self addSubview:unit];

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((self.w-134)/2, CGRectGetMaxY(self.money.frame)+19, 134, 35)];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 18;
        [self addSubview:view];

        self.done = [UILabel labelWithText:@"立即申请" textClolor:colorFromRGB(0xFF2726) font:15 frame:CGRectMake(0, 10, view.w, 14)];
        self.done.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
        self.done.textAlignment = NSTextAlignmentCenter;
        [view addSubview:self.done];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
    }
    return self;
}

- (void) tap{
    if (self.themeClick) {
        self.themeClick();
    }
}
@end
