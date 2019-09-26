//
//  XCPersonalController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCPersonalController.h"
#import "XCPersonalCell.h"
#import "XCPersonalHeardView.h"
#import "XCInformationController.h"
#import "XCHelpController.h"
@interface XCPersonalController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)XCPersonalHeardView *heardView;
@end

@implementation XCPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self setupTableView];
}

- (void) viewWillAppear:(BOOL)animated{
    XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
    if (get.status == 1) {
        self.heardView.title.text = @"您好!";
        self.heardView.logo.image = [UIImage imageNamed:@"Headportrait_s"];
        NSString *numberString = [[NSString stringWithFormat:@"%ld",get.phone] stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        self.heardView.user.text = numberString;
    }else{
        self.heardView.title.text = @"立即登录";
        self.heardView.logo.image = [UIImage imageNamed:@"Headportrait"];
        self.heardView.user.text = @"多种产品任您选择!";
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void) setupTableView{
    CGFloat statusRect = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.heardView = [[XCPersonalHeardView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 149+statusRect)];
    [self.heardView heardClick:^{
        XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
        XCLoginController *logon = [[XCLoginController alloc]init];
        [logon backBlock:^{
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }];
        [logon loginBlock:^{
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
            }];
        }];
        if (get.status == 1) {
            [self.navigationController pushViewController:[XCInformationController new] animated:YES];
        }else{
            [self.navigationController presentViewController:logon animated:YES completion:^{
            }];
        }
    }];
    [self.view addSubview:self.heardView];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.frame = CGRectMake(0,CGRectGetMaxY(self.heardView.frame), screenWidth, screenHeight- tabbarHeight + statusRect);
    [self.view addSubview:self.tableView];
    
    [XCNetworking phone:^(NSString * _Nonnull key) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1  inSection:0];
        XCPersonalCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.des.text = key;
    }];
}

#pragma mark -UITableView datasource & delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XCPersonalCell *cell = [XCPersonalCell personalCell:tableView];
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image  = [UIImage imageNamed:@"qes"];
            cell.textLabel.text = @"帮助中心";

            cell.des.hidden = YES;
            break;
        case 1:
            cell.imageView.image  = [UIImage imageNamed:@"kefu"];
            cell.textLabel.text = @"联系客服";
             cell.des.hidden = YES;
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [self.navigationController pushViewController:[[XCHelpController alloc]init] animated:YES];
        }break;
        case 1:{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"0755-86570650"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            });
        }break;
    }
}

@end

