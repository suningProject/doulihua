//
//  XCHelpCell.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/27.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCHelpCell.h"

@implementation XCHelpCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype) helpCell:(UITableView *)tableView{
    static NSString *identifier = @"XCHelpCell";
    XCHelpCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"XCHelpCell" owner:nil options:nil]lastObject];
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setHelp:(XCHelp *)help{
    self.title.text = help.question;
    self.dies.text = help.answer;
    [UIView animateWithDuration:0.25 animations:^{
        self.dies.hidden = !help.isOpen;
    }];
    self.arrow.image = [UIImage imageNamed:help.isOpen?@"help_center_open_s":@"help_center_open_n"];
    self.title.font = [UIFont fontWithName:help.isOpen?@"PingFang-SC-Medium":@"PingFang-SC-Regular" size:17];
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [help.answer boundingRectWithSize:CGSizeMake(screenWidth-30,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    help.height =rect.size.height+21+55;
}

@end

