//
//  UIBarButtonItem+Extension.m
//
//
//  Created by 李林杰 on 15/10/21.
//  Copyright © 2015年 李林杰. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+(instancetype)barBarItemWithNromalImage:(NSString *)normalImage HeightLightImage:(NSString *)HeightLightImage  target:(id) target  action:(SEL)action{
    //自定义按钮
    UIButton *btn=[UIButton buttonWithType: UIButtonTypeCustom];
    //默认图片
    UIImage *nmlImage=[UIImage imageNamed:normalImage];
    [btn setImage:nmlImage forState:UIControlStateNormal];
    //高亮图片
    [btn setImage:[UIImage imageNamed:HeightLightImage] forState:UIControlStateHighlighted];
    //点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds= CGRectMake(0, 0, 30,30);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    return  [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(instancetype)barBarItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIFont *titleFont=[UIFont systemFontOfSize:16];
    //计算文字所需要的尺寸
    CGSize maxSize=CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize titlesize=[title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size;
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    
    //设置文本
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font=titleFont;
    //设置不可用文本
    [btn  setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    //位置w
    btn.bounds =CGRectMake(0, 0, titlesize.width, titlesize.height);
    //事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(instancetype)backItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //设置图片
    UIImage *image=[UIImage imageNamed:@"back"];
    [backBtn setImage:image forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateHighlighted];
    //设置字体
    [backBtn setTitle:title forState:UIControlStateNormal];
    UIFont *titlefont=[UIFont systemFontOfSize:16];
    backBtn.titleLabel.font=titlefont;
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    //计算文字所要的尺寸
    CGSize titleSize=[title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titlefont} context:nil].size;
    //设置按钮尺寸
    backBtn.bounds=CGRectMake(0, 0, image.size.width+titleSize.width, image.size.height);
    //监听事件
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

@end

