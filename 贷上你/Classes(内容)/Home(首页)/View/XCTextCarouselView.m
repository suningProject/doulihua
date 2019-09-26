//
//  XCTextCarouselView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCTextCarouselView.h"

@interface XCTextCarouselView()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UILabel * topLabel;
@property (nonatomic,strong) UILabel * bottomLabel;
@property (nonatomic,strong) UIView * coverView;
@end

@implementation XCTextCarouselView
#define contentW 250

@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)arr{
    if (self = [super initWithFrame:frame]) {
        _textArray = arr;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    self.contentSize = CGSizeMake(contentW, 100*2);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;   
    self.pagingEnabled = YES;
    self.bounces = NO;
    self.scrollEnabled = NO;
    _count = 0;
    
    _coverView = [[UIView alloc] init];
    _coverView.frame = CGRectMake(0, 0, contentW, 200);
    [_coverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didselectIndex)]];
    
    _coverView.alpha = 0.4;
    [self addSubview:_coverView];
    for (int i = 0; i<2; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = colorFromRGB(0x373737);
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentRight;
        
        if (i==0) _topLabel = label;
        if (i==1) _bottomLabel = label;
        label.frame = CGRectMake(0, i*100, contentW, 27);
        [self addSubview:label];
    }
    
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(updateText) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
    [self setLabelText];
}

- (void)updateText {
    [self setLabelText];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentOffset = CGPointMake(0, 100);
    }completion:^(BOOL finished) {
        [self setLabelText];
        self.count++;
    }];
}

- (void)setLabelText {
    NSInteger idx = _count%self.textArray.count;
    NSInteger idx2 = (_count+1)%self.textArray.count;
    if (self.contentOffset.y==100) {
        _topLabel.text = _bottomLabel.text;
        self.contentOffset = CGPointMake(0, 0);// 每次滚动之后马上重置位置
    }else{
        _topLabel.text = self.textArray[idx];
        _bottomLabel.text = self.textArray[idx2];
    }
}

- (void)didselectIndex {
    NSInteger idx = _count%self.textArray.count;
    if ([self.delegate respondsToSelector:@selector(didSelectTextFromIndex:)]) {
        [self.delegate didSelectTextFromIndex:idx];
    }
}

@end
