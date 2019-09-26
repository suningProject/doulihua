//
//  XCLoginController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/21.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCLoginController.h"
#import "XCUser.h"
#import "DES2.h"
#import "AppDelegate.h"
#import "XCTabBarController.h"
@interface XCLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UILabel *promtLabel;
@property (strong, nonatomic) dispatch_source_t timer;
@end

@implementation XCLoginController
//17174374663
- (void)viewDidLoad {
    [super viewDidLoad];
    XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
    if(get.phone){
        self.phoneNum.text = [NSString stringWithFormat:@"%lu",(unsigned long)get.phone];
    }
    [self setTextField];
}  

- (void) setTextField{
    NSMutableAttributedString *phonePlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号"];
    [phonePlaceholder addAttribute:NSForegroundColorAttributeName
                             value:colorFromRGB(0x969696)
                             range:NSMakeRange(0, phonePlaceholder.length)];
    self.phoneNum.attributedPlaceholder = phonePlaceholder;
    self.phoneNum.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    NSMutableAttributedString *codePlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入验证码"];
    [codePlaceholder addAttribute:NSForegroundColorAttributeName
                             value:colorFromRGB(0x969696)
                             range:NSMakeRange(0, codePlaceholder.length)];
    self.code.attributedPlaceholder = codePlaceholder;
    self.promtLabel.textColor = colorFromRGB(0x969696);
    
}

- (IBAction)back:(id)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}

- (IBAction)login:(id)sender {
    [self login];
}

- (IBAction)senCode:(id)sender {
    [self sendCode:2];
}

- (void)backBlock:(backBlock)block {
    self.backBlock  = block;
}

- (void)loginBlock:(loginBlock)block{
    self.loginBlock = block;
}

#pragma mark - 开始计时器
-(void)startTime{
    __block int timeout=60;
    //创建一个全局并非队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个定时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //配置定时器，每秒执行
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    //创建事件处理器
    dispatch_source_set_event_handler(_timer, ^{
        timeout --;
        if (timeout <= 0) {
            //定时器结束，关闭
            dispatch_source_cancel(self.timer);
            self.timer = nil;
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.codeButton setEnabled:YES];;
            });
        }
        else
        {
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeButton setTitle:[NSString stringWithFormat:@"剩余%ds",timeout] forState:UIControlStateNormal];
                 [self.codeButton setEnabled:NO];;
            });
        }
    });
    //启动定时器
    dispatch_resume(_timer);
}

- (void) login{NSDictionary *dic = @{@"phone":self.phoneNum.text,@"code":self.code.text,@"devType":@2};
    dispatch_async(dispatch_queue_create("login", DISPATCH_QUEUE_SERIAL), ^{
        [XCNetworking post:@"/user/loginphone" params:dic success:^(id  _Nonnull responseObj) {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:nil];
            if ([dic[@"status"] intValue] == 0) {
                [self getUserInfo];
            }else{
                [XCRemindView show:dic[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
        }];
    });
}

//获取信息
- (void)getUserInfo{
    [XCNetworking get:@"/user/getuserinfo" params:nil  success:^(id  _Nonnull responseObj) {
        if ([responseObj[@"status"] intValue] == 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                XCUser *user;
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"encryption"] intValue] == 1) {
                    NSString *str = [DES2 decrypt:responseObj[@"data"]];
                    NSLog(@"%@",str);
                    user = [XCUser mj_objectWithKeyValues:str];
                }else{
                    user = [XCUser mj_objectWithKeyValues:responseObj[@"data"]];
                }
                [MNCacheClass mn_saveModel:user key:@"XCUser"];
                //            if (self.loginBlock) {
                //                self.loginBlock();
                //            }
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = [[XCTabBarController alloc] init];
            });
        }else{
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

//发送验证码 类型：0->注册，1->忘记密码，2->手机+短信登陆
- (void)sendCode:(NSUInteger)type{
    NSDictionary *dic = @{@"mobile":self.phoneNum.text,@"type":[NSNumber numberWithUnsignedLong:type]};
    [XCNetworking post:@"/sms/sendcode" params:dic success:^(id  _Nonnull responseObj) {
        NSLog(@"%@",responseObj);
        NSLog(@"%@",[[NSString alloc] initWithData:responseObj encoding:NSUTF8StringEncoding]);
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:nil];
        if ([dic[@"status"] intValue] == 0) {
            [XCRemindView show:@"验证码已发送"];
            [self startTime];
        }else{
            [XCRemindView show:dic[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

@end
