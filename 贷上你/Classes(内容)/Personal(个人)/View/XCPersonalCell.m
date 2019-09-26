//
//  XCPersonalCell.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCPersonalCell.h"

@implementation XCPersonalCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype) personalCell:(UITableView *)tableView{
    static NSString *identifier = @"XCPersonalCell";
    XCPersonalCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"XCPersonalCell" owner:nil options:nil]lastObject];
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
