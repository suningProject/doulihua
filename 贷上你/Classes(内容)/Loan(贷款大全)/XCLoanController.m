//
//  XCLoanController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCLoanController.h"
#import "XCPromptView.h"
#import "XCProductTableView.h"
#import "XCLoan.h"
#import "XCWebViewController.h"
#import "DES2.h"
#import "XCErrorView.h"
@interface XCLoanController ()<XCProductTableViewDelegate>
@property (nonatomic,strong)XCLoan *loan;
@property (nonatomic,strong)UIRefreshControl *refreshControl;
@property (nonatomic,strong)XCProductTableView *tableView ;
@property(nonatomic,strong)XCErrorView *error;
@end

@implementation XCLoanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [(XCNavigationController *)self.navigationController hideNavBarBottomLine];
    [self getData];
}

// 获取全部产品
- (void) getData{
    
    [XCNetworking post:@"/product/getallappproductmodel" params:@{@"shelfType":@2}  success:^(id  _Nonnull responseObj) {
        NSString *str = [[NSString alloc]initWithData:responseObj encoding:NSUTF8StringEncoding];
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        
        if ([dic[@"status"] intValue] == 0) {
            [self.error removeFromSuperview];
             if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"encryption"] intValue] == 1) {
                 NSString *str = [DES2 decrypt:dic[@"data"]];
                 self.loan = [XCLoan yy_modelWithJSON:str];
             }else{
                 self.loan = [XCLoan yy_modelWithJSON:dic[@"data"]];
             }
            if (self.tableView) {
                self.tableView.dataArray = self.loan.list;
                [self.tableView reloadData];
            }else{
                [self setupSubviews:self.loan];
            }
            [self.refreshControl endRefreshing];
        }
    } failure:^(NSError * _Nonnull error) {
        [self.view addSubview:self.error];
        [self.error clickBlock:^{
            [self getData];
        }];
        [self.refreshControl endRefreshing];
    }];
}

-(void)refreshTable{
    [self getData];
}

- (void) setupSubviews:(XCLoan *)loan{

    XCPromptView *prompt = [[XCPromptView alloc]initWithFrame:CGRectMake(0,0, screenWidth, 30) title:[[NSUserDefaults standardUserDefaults]objectForKey:@"selfTitle"]];
    [self.view addSubview:prompt];
    
    XCProductTableView *tableView = [[XCProductTableView alloc]init];
    tableView.pdelegate = self;
    tableView.dataArray = loan.list;
    tableView.scrollEnabled = YES;
    tableView.frame = CGRectMake(0, CGRectGetMaxY(prompt.frame), screenWidth, screenHeight-tabbarHeight-30);
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UIRefreshControl *rc = [[UIRefreshControl alloc]init];
    [rc addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    [tableView addSubview:rc];
    [self.refreshControl endRefreshing];
    
}

#pragma mark - XCProductTableViewDelegate
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
        XCHotProduct *product = self.loan.list[indexPath.row];
        if (get.status == 1 && product.productId != 0) {
            XCWebViewController *web = [[XCWebViewController alloc]init];
            web.title = product.name;
            web.productId = product.productId;
            web.url = product.h5Href;
            [self.navigationController pushViewController:web animated:YES];
        }else{
            if (product) {
                XCLoginController *logon = [[XCLoginController alloc]init];
                [logon backBlock:^{
                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    }];
                }];
                [logon loginBlock:^{
                    [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    }];
                }];
                [self.navigationController presentViewController:logon animated:YES completion:^{
                }];
            }else{
                 [XCRemindView show:@"该产品更新中"];
            }
        }
    });
}

- (XCErrorView *)error{
    if (!_error) {
        _error = [[XCErrorView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
        _error.backgroundColor = [UIColor clearColor];
    }
    return _error;
}



@end
