//
//  UIView+Extension.m
//
//
//  Created by 李林杰 on 15-3-16.
//  Copyright (c) 2015年 李林杰. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(void)setSize:(CGSize)size{
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

-(CGSize)size{
    return self.bounds.size;
}

-(void)setW:(CGFloat)w{
    
    CGRect frm = self.frame;
    frm.size.width = w;
    self.frame = frm;
}

-(CGFloat)w{
    return self.size.width;
}

-(void)setH:(CGFloat)h{
    CGRect frm = self.frame;
    frm.size.height = h;
    self.frame = frm;
}

-(CGFloat)h{
    return self.size.height;
}

-(void)setX:(CGFloat)x{
    CGRect frm = self.frame;
    frm.origin.x = x;
    
    self.frame = frm;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect frm = self.frame;
    frm.origin.y = y;
    
    self.frame = frm;
    
}

-(CGFloat)y{
    return self.frame.origin.y;
}

@end

@implementation  UILabel (Extension)

+ (instancetype) labelWithText:(NSString *)text textClolor:(UIColor *)color font:(CGFloat)font frame:(CGRect)frame isAggravation:(BOOL)isAggravation{
    UILabel *label = [UILabel labelWithText:text textClolor:color font:font frame:frame];
    label.font = [UIFont fontWithName:isAggravation?@"PingFang-SC-Semibold":@"PingFang-SC-Medium" size:font];;
    return label;
}

+ (instancetype) labelWithText:(NSString *)text textClolor:(UIColor *)color font:(CGFloat)font frame:(CGRect)frame{
    UILabel *label = [[UILabel alloc]init];
    if (font) {
        label.font = [UIFont systemFontOfSize:font];
    }
    label.text = text;
    if (color) {
        label.textColor = color;
    }else{
        label.textColor = [UIColor blackColor];
    }
    label.frame = frame;
    return label;
}

@end

@implementation UIButton (Extension)

+ (instancetype) buttonWithText:(NSString *)text font:(CGFloat) font nmlTitleColor:(UIColor *)ntColor hightTitleColor:(UIColor *)htColor frame:(CGRect) frame {
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:text forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:font];
    [button setTitleColor:ntColor forState:UIControlStateNormal];
    [button setTitleColor:htColor forState:UIControlStateHighlighted];
    button.frame = frame;
    
    
    return button;
}

+ (instancetype) buttonWithText:(NSString *)text font:(CGFloat) font nmlTitleColor:(UIColor *)ntColor hightTitleColor:(UIColor *)htColor frame:(CGRect) frame target:(id)target  action:(SEL)action{
    
    UIButton *button =  [UIButton buttonWithText:text 
                                            font:font 
                                   nmlTitleColor:ntColor 
                                 hightTitleColor:htColor 
                                           frame:frame];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

@end

@implementation UITextField (Extension)

+ (instancetype) textFieldWithPlaceholder:(NSString *)placeholder textColor:(UIColor *)tColor borderStyle:(UITextBorderStyle)style frame:(CGRect)frame {
    UITextField *field = [[UITextField alloc]init];
    field.placeholder = placeholder;
    if (tColor) {
        field.textColor = tColor;
    }else{
        field.textColor = [UIColor blackColor];
    }
    field.borderStyle = style;
    field.frame = frame;
    
    return field;
}

@end

