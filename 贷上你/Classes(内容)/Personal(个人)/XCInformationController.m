//
//  XCInformationController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/26.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCInformationController.h"
#import "DES2.h"
@interface XCInformationController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phonetext;
@property (weak, nonatomic) IBOutlet UITextField *idcardText;

@end

@implementation XCInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
   
    [self setupSubviews];
    [self getUserInfo];
    
}

- (void) setupSubviews{
    UIButton *save = [UIButton buttonWithType:UIButtonTypeCustom];
    [save setTitle:@"保存" forState:UIControlStateNormal];
    [save setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [save setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    save.titleLabel.font = [UIFont systemFontOfSize:15];
    [save addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:save];
}

- (void)getUserInfo{
    [XCNetworking get:@"/user/getuserinfo" params:nil  success:^(id  _Nonnull responseObj) {
        if ([responseObj[@"status"] intValue] == 0) {
            
            XCUser *user;
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"encryption"] intValue] == 1) {
                NSString *str = [DES2 decrypt:responseObj[@"data"]];
                user = [XCUser mj_objectWithKeyValues:str];
            }else{
                user = [XCUser mj_objectWithKeyValues:responseObj[@"data"]];
            }
            [MNCacheClass mn_saveModel:user key:@"XCUser"];
            if (user.phone) {
                self.phonetext.text =[NSString stringWithFormat:@"%ld",user.phone];
            }
            if (user.realName) {
                self.nameText.text =user.realName;
            }
            if (user.cardId) {
                self.idcardText.text =user.cardId;
            }
        }else{
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

// 修改个人信息
- (void)save:(UIButton *)sender{
    XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
    NSDictionary *dic = @{@"userId":[NSNumber numberWithInteger:get.userId],
                          @"phone":self.phonetext.text,
                          @"devType":@2,
                          @"realName":self.nameText.text,
                          @"cardId":self.idcardText.text
                          };
    [XCNetworking post:@"/user/modifyuserinfo" params:dic success:^(id  _Nonnull responseObj) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        if ([dic[@"status"] intValue] != 0) {
             [XCRemindView show:dic[@"msg"]];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (IBAction)exit:(id)sender {
    [MNCacheClass mn_saveModel:[[XCUser alloc]init] key:@"XCUser"];
//    [self.navigationController popViewControllerAnimated:YES];
    [XCNetworking get:@"/user/logout" params:nil success:^(id  _Nonnull responseObj) {
        NSLog(@"%@",responseObj);
    } failure:^(NSError * _Nonnull error) {
    }];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[XCLoginController alloc] init];
}

+ (BOOL)cly_verifyIDCardString:(NSString *)idCardString {
    NSString *regex = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isRe = [predicate evaluateWithObject:idCardString];
    if (!isRe) {
        //身份证号码格式不对
        return NO;
    }
    //加权因子 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    NSArray *weightingArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //校验码 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2
    NSArray *verificationArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    NSInteger sum = 0;//保存前17位各自乖以加权因子后的总和
    for (int i = 0; i < weightingArray.count; i++) {//将前17位数字和加权因子相乘的结果相加
        NSString *subStr = [idCardString substringWithRange:NSMakeRange(i, 1)];
        sum += [subStr integerValue] * [weightingArray[i] integerValue];
    }
    
    NSInteger modNum = sum % 11;//总和除以11取余
    NSString *idCardMod = verificationArray[modNum]; //根据余数取出校验码
    NSString *idCardLast = [idCardString.uppercaseString substringFromIndex:17]; //获取身份证最后一位
    
    if (modNum == 2) {//等于2时 idCardMod为10  身份证最后一位用X表示10
        idCardMod = @"X";
    }
    if ([idCardLast isEqualToString:idCardMod]) { //身份证号码验证成功
        return YES;
    } else { //身份证号码验证失败
        return NO;
    }
}
@end
