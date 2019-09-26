//
//  XCMoneyCell.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCMoneyCell.h"
@interface XCMoneyCell()

@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UILabel *money;

@end

@implementation XCMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype) moneyCell:(UITableView *)tableView{
    static NSString *identifier = @"XCMoneyCell"; 
    XCMoneyCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"XCMoneyCell" owner:nil options:nil]lastObject];
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.num.font = [UIFont fontWithName:@"DINPro-Medium" size:15];
        cell.money.font = [UIFont fontWithName:@"DINPro-Medium" size:19];
//        cell.name.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:16];
        cell.logo.layer.cornerRadius = 5;
    }
    return cell;
}

- (void)setProduct:(XCHotProduct *)product{
    _product = product;
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:product.logo]];
    self.name.text = product.name;
    self.tags.text = product.tag;
    self.money.text = [NSString stringWithFormat:@"%@-%@",[self str:product.lowMoney],[self str:product.highMoney]];
}

- (NSString *) str:(NSUInteger)money{
    NSString *str = [NSString stringWithFormat:@"%ld",money];
    NSString *newMoney =  [str substringToIndex:str.length-2];
    return newMoney;
}

@end
