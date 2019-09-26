//
//  XCRemindView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/26.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCRemindView.h"

@implementation XCRemindView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSelf];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = title;
        [self setupSelf];
    }
    return self;
}

+ (void)show:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGSize sizeToFit = [title sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 38) lineBreakMode:NSLineBreakByWordWrapping];
        
        XCRemindView *re = [[XCRemindView alloc]initWithFrame:CGRectMake((screenWidth-sizeToFit.width-40)/2/2, 0, sizeToFit.width+40, 38) title:title];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:re];
        
        [self animateWithDuration:0.15 animations:^{
            CGRect rect = re.frame;
            rect.origin.y = 78;
            re.frame = rect;
        } completion:^(BOOL finished) {
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self animateWithDuration:0.25 animations:^{
                [re removeFromSuperview];
            }];
        });
    });
 
}

- (void) setupSelf{
    UIView *background = [[UIView alloc]initWithFrame:self.frame];
    background.backgroundColor = colorFromRGB(0x000000);
    background.layer.cornerRadius = 18;
    background.alpha = 0.8;
    [self addSubview:background];
    
    UILabel *titlelbl = [UILabel labelWithText:self.title textClolor:[UIColor whiteColor] font:14 frame:self.frame];
    titlelbl.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titlelbl];
}

@end


