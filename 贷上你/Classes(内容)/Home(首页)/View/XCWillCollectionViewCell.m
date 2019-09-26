//
//  XCWillCollectionViewCell.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/23.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCWillCollectionViewCell.h"
@interface XCWillCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *bg;

@end

@implementation XCWillCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.logo.layer.cornerRadius = 5;
    self.logo.clipsToBounds = YES;
    self.contentView.layer.shadowColor = [UIColor colorWithRed:228/255.0 green:0/255.0 blue:0/255.0 alpha:0.08].CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(0,0);
    self.contentView.layer.shadowOpacity = 1;
    self.contentView.layer.shadowRadius = 7;
    self.contentView.layer.cornerRadius = 5;
    self.contentView.clipsToBounds = NO;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        XCWillCollectionViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"XCWillCollectionViewCell" owner:self options:nil].lastObject;
        return cell;
    }
    return self;
}
@end
