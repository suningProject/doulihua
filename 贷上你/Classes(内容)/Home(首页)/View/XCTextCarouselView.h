//
//  XCTextCarouselView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZYTextPageScrollViewDelegate <UIScrollViewDelegate>

- (void)didSelectTextFromIndex:(NSInteger)index;

@end

@interface XCTextCarouselView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame textArray:(NSArray *)arr;

@property (nonatomic,strong) NSArray *textArray;

@property (nonatomic,weak) id<ZYTextPageScrollViewDelegate>delegate;

@end

