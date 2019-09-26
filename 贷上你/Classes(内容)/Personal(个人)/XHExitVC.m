//
//  XHExitVC.m
//  贷上你
//
//  Created by 叶子 on 2019/9/26.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XHExitVC.h"

@interface XHExitVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;

@end

@implementation XHExitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"设置";
    [self uiCreate];
}
#pragma mark - uiCreate
- (void)uiCreate
{
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}



#pragma mark - UITableViewDelegate

#pragma mark didSelectRow
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [MNCacheClass mn_saveModel:[[XCUser alloc]init] key:@"XCUser"];
        [XCNetworking get:@"/user/logout" params:nil success:^(id  _Nonnull responseObj) {
            NSLog(@"%@",responseObj);
        } failure:^(NSError * _Nonnull error) {
        }];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = [[XCLoginController alloc] init];

    }];
    [alertDialog addAction:cancelAction];
    [alertDialog addAction:sureAction];
    [self presentViewController:alertDialog animated:YES completion:nil];


    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{ return 1; }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"cell"];
    }
    cell.textLabel.text = @"退出登录";
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
