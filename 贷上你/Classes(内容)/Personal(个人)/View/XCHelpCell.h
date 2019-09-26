//
//  XCHelpCell.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/27.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCHelp.h"
NS_ASSUME_NONNULL_BEGIN

@interface XCHelpCell : UITableViewCell
@property (weak, nonatomic) XCHelp *help;
@property (weak, nonatomic) IBOutlet UILabel *title;
+ (instancetype) helpCell:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UILabel *dies;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@end

NS_ASSUME_NONNULL_END
