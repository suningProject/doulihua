//
//  XCPromptView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCPromptView.h"
@implementation XCPromptView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = colorFromRGB(0xFFF3E1);
        self.prompt = [UILabel labelWithText:title textClolor:colorFromRGB(0xFD8F44) font:12 frame:CGRectMake(15, 0, screenWidth-80, self.h) ];
        
        [self addSubview:self.prompt];
    }
    return self;
}

@end
