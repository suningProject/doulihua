//
//  XCProductCell.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCHotProduct.h"
NS_ASSUME_NONNULL_BEGIN



@interface XCProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *money; // 金额
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *tags; // 标记
@property (weak, nonatomic) IBOutlet UILabel *apply;
@property (weak, nonatomic) IBOutlet UILabel *pass; // 申请人数
@property (weak, nonatomic) IBOutlet UILabel *successRate; // 成功率
@property(nonatomic,strong)XCHotProduct* product;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
+ (instancetype) productCell:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
