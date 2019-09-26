//
//  XCMoneyController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCMoneyController.h"
#import "XCMoneyCell.h"
#import "XCLoan.h"
#import "XCWebViewController.h"
#import "DES2.h"
#import "XCErrorView.h"
@interface XCMoneyController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)XCLoan *loan;
@property(nonatomic,strong)UIView *underView;
@property (nonatomic,strong)UIRefreshControl *refreshControl;
@property(nonatomic,strong)XCErrorView *error;
@end

@implementation XCMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [(XCNavigationController *)self.navigationController hideNavBarBottomLine];
    [self getData];
}

// 根据条件获取产品
- (void) getData{
    NSDictionary *dic = @{
                          @"isNecessarySubparagraph":[NSNumber numberWithInt:1],
                          @"shelfType":@2
                          };
    [XCNetworking post:@"/product/getappproductmodel" params:dic  success:^(id  _Nonnull responseObj) {
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
                [self.tableView reloadData];
            }else{
                [self setupSubviews];
            }
        }
        [self.refreshControl endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [self.view addSubview:self.error];
        [self.error clickBlock:^{
            [self getData];
        }];
        [self.refreshControl endRefreshing];
    }];
}

- (void) recordhits{
    XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
    NSDictionary *dic = @{@"userId":[NSNumber numberWithInteger:get.userId]};
    [XCNetworking post:@"/product/userclicknecessarysubparagraph" params:dic  success:^(id  _Nonnull responseObj) {
    } failure:^(NSError * _Nonnull error) {
    }];
}

-(void)refreshTable{
    [self getData];
}

- (void) setupSubviews{
    
    self.tableView =[[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = colorFromRGB(0xf96555);
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight- tabbarHeight-navigationBarHeight-statusRect.size.height);
    [self.view addSubview:self.tableView];
    
    UIRefreshControl *rc = [[UIRefreshControl alloc]init];
    [rc addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    if (@available(iOS 10.0, *)) {
        self.tableView.refreshControl = rc;
    } else {
        [self.tableView addSubview:rc];
    }
    
    UIImageView *heard =  [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 120)];
    heard.image = [UIImage imageNamed:@"banner2"];
    self.tableView.tableHeaderView = heard;

//    _underView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 0)];
//    _underView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:_underView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y<0){
        CGRect frame = _underView.frame;
        frame.size.height = 0-scrollView.contentOffset.y;
        _underView.frame = frame;
    }else{
        CGRect frame = _underView.frame;
        frame.size.height = 0;
        _underView.frame = frame;
    }
}

#pragma mark -UITableView datasource & delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.loan.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XCMoneyCell *cell = [XCMoneyCell moneyCell:tableView];
    cell.num.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    if (indexPath.row<=2) {
        cell.num.hidden = YES;
        cell.champion.hidden = NO;
        cell.champion.image = [UIImage imageNamed:[NSString stringWithFormat:@"hot_icon_number_%ld",indexPath.row+1]];
    }
    cell.product = self.loan.list[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 81;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
        XCHotProduct *product = self.loan.list[indexPath.row];
        if (get.status == 1 && product.productId != 0) {
            [self recordhits];
            XCWebViewController *web = [[XCWebViewController alloc]init];
            web.title = product.name;
            web.productId = product.productId;
            web.url = product.h5Href;
            [self.navigationController pushViewController:web animated:YES];
        }else{
            if(product.productId){
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
                [XCRemindView show:@"该产品更新"];
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
