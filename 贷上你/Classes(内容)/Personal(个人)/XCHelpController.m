//
//  XCHelpController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/27.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCHelpController.h"
#import "XCHelpCell.h"
#import "XCHelp.h"
#import "DES2.h"
@interface XCHelpController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation XCHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    self.view.backgroundColor = [UIColor whiteColor];
    [self getInfo];
}


- (void)getInfo{
    [XCNetworking get:@"/user/getqas" params:nil  success:^(id  _Nonnull responseObj) {
        if ([responseObj[@"status"] intValue] == 0) {
            
            NSArray *helps;
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"encryption"] intValue] == 1) {
                  NSString *str = [DES2 decrypt:responseObj[@"data"]];
                  helps = [NSArray yy_modelArrayWithClass:[XCHelp class] json:str];
            }else{
                 helps = [NSArray yy_modelArrayWithClass:[XCHelp class] json:responseObj[@"data"]];
            }
           
            self.dataArray = [[NSMutableArray alloc]initWithArray:helps];
            [self setupTableView];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void) setupTableView{
    self.tableView =[[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.frame = CGRectMake(0, 0, screenWidth, screenHeight- tabbarHeight);
    [self.view addSubview:self.tableView];
}

#pragma mark -UITableView datasource & delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XCHelpCell *cell = [XCHelpCell helpCell:tableView];
    cell.help = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XCHelp *help = self.dataArray[indexPath.row];
    if (help.isOpen) {
        XCHelp *help = self.dataArray[indexPath.row];
        return help.height;
    }
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XCHelp *help = self.dataArray[indexPath.row];
    help.isOpen =  !help.isOpen;
    self.dataArray[indexPath.row] = help;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end
