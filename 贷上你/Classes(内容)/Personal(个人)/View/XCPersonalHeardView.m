//
//  XCPersonalHeardView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCPersonalHeardView.h"

@implementation XCPersonalHeardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSelf];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
    }
    return self;
}

- (void)tap{
    if (self.heardClick) {
        self.heardClick();
    }
}

- (void)heardClick:(heardClickBlock)block {
    self.heardClick  = block;
}

-(void) setupSelf{
    self.backgroundColor = CREATE_RGB_COLOR(255, 137, 64);
    UILabel *title = [UILabel labelWithText:@"立即登录" textClolor:[UIColor whiteColor] font:22 frame:CGRectMake(15, 15, 150, 23) isAggravation:YES];
    UILabel *user = [UILabel labelWithText:@"多种产品任你选择!" textClolor:[UIColor whiteColor] font:14 frame:CGRectMake(15, 20, 150, 14)];
    UIImageView *logo = [[UIImageView alloc]init];
    logo.image = [UIImage imageNamed:@"Headportrait"];
    logo.layer.cornerRadius = 30;
    
    [self addSubview:logo];
    [self addSubview:title];
    [self addSubview:user];
    
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.bottom.mas_equalTo(-27);
        make.width.height.mas_equalTo(62);
    }];
    
    [user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-35);
        make.left.equalTo(logo.mas_right).mas_offset(15);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(user.mas_top).mas_offset(-5);
        make.left.equalTo(logo.mas_right).mas_offset(15);
        make.height.mas_equalTo(23);
    }];
    

    
    self.title = title;
    self.logo = logo;
    self.user = user;
    
}

@end
