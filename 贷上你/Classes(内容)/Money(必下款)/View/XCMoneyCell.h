//
//  XCMoneyCell.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCHotProduct.h"
NS_ASSUME_NONNULL_BEGIN

@interface XCMoneyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *num;

@property (weak, nonatomic) IBOutlet UIImageView *champion;

+ (instancetype) moneyCell:(UITableView *)tableView;

@property(nonatomic,strong)XCHotProduct* product;


@end

NS_ASSUME_NONNULL_END
