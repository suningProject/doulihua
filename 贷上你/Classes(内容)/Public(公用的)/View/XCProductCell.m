//
//  XCProductCell.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCProductCell.h"
@interface XCProductCell()


@end

@implementation XCProductCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.typeLab.layer.cornerRadius = 8;
    self.typeLab.layer.borderColor = CREATE_RGBA_COLOR(244, 149, 39, 1).CGColor;
    self.typeLab.textAlignment = NSTextAlignmentCenter;
    self.typeLab.layer.borderWidth = 0.5;
    self.money.font = FONT(@"PingFang-SC-Bold", 18);
    self.pass.font =FONT(@"PingFang-SC-Medium", 15);
    self.typeLab.font = FONT(@"PingFang-SC-Medium", 11);
    self.successRate.font =FONT(@"PingFang-SC-Medium", 15);
    self.typeLab.textColor = CREATE_RGBA_COLOR(135, 135, 135, 1);
    self.money.textColor = CREATE_RGBA_COLOR(255, 113, 57,1);
    self.pass.textColor = CREATE_RGBA_COLOR(255, 163, 57,1);
    self.successRate.textColor = CREATE_RGBA_COLOR(255, 113, 57,1);
    
    self.name.font = SYSTEMFONT(15);
    self.tags.font = SYSTEMFONT(12);
}

+ (instancetype) productCell:(UITableView *)tableView{
    static NSString *identifier = @"productCell";
    XCProductCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
    {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"XCProductCell" owner:nil options:nil]lastObject];
        cell.selectedBackgroundView = [[UIView alloc]init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
//        cell.money.font = [UIFont fontWithName:@"DINPro-Medium" size:17];
        NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc]init];
        [ps setAlignment:NSTextAlignmentCenter];
    }
    return cell;
}



- (void)setProduct:(XCHotProduct *)product{
    _product = product;
    
    [self.logo sd_setImageWithURL:[NSURL URLWithString:product.logo] placeholderImage:[UIImage imageNamed:@"logo_image"]];
    self.name.text = product.name; //产品名称
    
    self.money.text = [NSString stringWithFormat:@"%@-%@",[self str:product.lowMoney],[self str:product.highMoney]];
    self.time.text = [NSString stringWithFormat:@"%@ 天",product.month];
    self.typeLab.text = product.tag; // 标签
    self.tags.text = product.introduce;// 产品介绍
    self.apply.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_btn"]];
    self.pass.text = [NSString stringWithFormat:@"%ld人",product.applyCount];
    self.successRate.text = [NSString stringWithFormat:@"%ld%%",product.passCount];
    
    CGSize size =  [ComTool getSizeWithString:product.tag withSize:CGSizeMake(200.f, MAXFLOAT) withFont:FONT(@"PingFang-SC-Medium", 11)];
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(size.width+20);
    }];
    
}



- (NSString *) str:(NSUInteger)money{
    NSString *str = [NSString stringWithFormat:@"%lu",money];
    NSString *newMoney =  [str substringToIndex:str.length-2];
    return newMoney;
}

@end
