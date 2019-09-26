//
//  XCWillCollectionViewCell.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/23.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCWillCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *lines;
@end

NS_ASSUME_NONNULL_END
