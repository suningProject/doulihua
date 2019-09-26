//
//  XCHelp.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/27.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCHelp.h"

@implementation XCHelp
+(NSMutableArray *)data{
    
    NSArray *titleArray =  [[ NSArray alloc]initWithObjects:@"如何提高贷款成功率？",@"申请的借款能否循环使用？",@"无信用卡、公积金、工作可以申请借款吗？", @"暂不符合申请条件，请30天后再试？",@"审核时间？",nil];
    NSArray *desArray =  [[ NSArray alloc]initWithObjects:@"你可以结合自己的资质选择适合的贷款产品，并仔细阅读详情页的申请条件和新手攻略。再者建议您申请多个产品，申请3个以上贷款产品的用户，审核率高达99%",@"申请的借款能否循环使用？",
                          @"部分产品支持循环额度，申请一次，可循环申请。具体看产品详情", @"贷上你中的每款产品要求均有不同，每个产品点开均有申请条件说明，您可以根据每个产品要求来挑选，或者也可以进行筛选，选择合适的产品。", @"贷上你提供多种产品供您选择，同时每种产品会有各自不同审核的流程以及时间，审核时间通常不超过3个工作日，如需了解每款产品的具体时间，可咨询申请产品方的客服 热线或登录产品方APP咨询每款产品的具体审核时间",nil];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0 ; i <5; i++) {
        XCHelp *help = [[XCHelp alloc] init];
        help.question = titleArray[i];
        help.answer = desArray[i];
        [arr addObject:help];
    }
    return arr;
}

@end
