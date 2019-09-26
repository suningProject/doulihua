//
//  XCCollectionViewCell.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCCollectionViewCell.h"

@implementation XCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        XCCollectionViewCell *cell = [[NSBundle mainBundle]loadNibNamed:@"XCCollectionViewCell" owner:self options:nil].lastObject;
        cell.image.layer.cornerRadius = 20;
        return cell;
    }
    return self;
}


@end
