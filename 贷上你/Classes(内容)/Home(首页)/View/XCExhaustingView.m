//
//  XCExhaustingView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/23.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCExhaustingView.h"
@interface XCExhaustingView()
@end

@implementation XCExhaustingView

+ (instancetype) ExhaustingView{
    return [[[NSBundle mainBundle]loadNibNamed:@"XCExhaustingView" owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.bg.image = [UIImage imageNamed:@"760"];
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(7.5);
        make.right.mas_offset(-7.5);
        make.top.bottom.mas_equalTo(self);
    }];
    
    
    self.logo.layer.cornerRadius = 26.5;
    self.logo.clipsToBounds = YES;
       [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
}

- (void)themeClick:(themeClickBlock)block{
    self.themeClick = block;
}

- (void) tap{
    if (self.themeClick) {
        self.themeClick();
    }
}


@end
