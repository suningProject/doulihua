//
//  XCHomeController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCHomeController.h"
#import "XCCollectionViewCell.h"
#import "XCPromptView.h"
#import "XCProductTableView.h"
#import "XCTextCarouselView.h"
#import "XCHome.h"
#import "XCWebViewController.h"
#import "DES2.h"
#import "XCErrorView.h"
#import "XCThemeView.h"
#import "XCExhaustingView.h"
#import "XCWillCollectionViewCell.h"

@interface XCHomeController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,XCProductTableViewDelegate,SDCycleScrollViewDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)XCHome *home;
@property(nonatomic,strong)UIRefreshControl *refreshControl;


// 热门推荐的产品
@property(nonatomic,strong)XCProductTableView *tableView;

@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UICollectionView *willCollectionView;
@property(nonatomic,strong)XCPromptView *prompt;
@property(nonatomic,strong)UIButton *all;

@property(nonatomic,strong)UILabel *hotLabel;
@property(nonatomic,strong)UIImageView *best;
@property(nonatomic,strong)XCThemeView *theme;
@property(nonatomic,strong)XCExhaustingView *exhausting;
@property(nonatomic,strong)XCErrorView *error;

@property(nonatomic,strong)NSArray *titleArray;


@property(nonatomic,strong)UILabel *proLbl ;// 通知内容

@end

@implementation XCHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.delegate = self;
    [(XCNavigationController *)self.navigationController hideNavBarBottomLine];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.titleTextAttributes =dic;
    [self setupSubviews];
    [self getData];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setTranslucent:true];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void) viewWillDisappear:(BOOL)animated{
    [self.navigationController.navigationBar setTranslucent:NO];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)dealloc {
    self.navigationController.delegate = nil;
}

#pragma mark - 获取首页全部数据
- (void) getData{
    
    NSDictionary * dic = @{@"type":@2
                           };
    
    [XCNetworking post:@"/index/gethomepage" params:dic  success:^(id  _Nonnull responseObj) {
//        NSLog(@"responseObj-%@",responseObj);
        NSLog(@"当前线程 %@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([responseObj[@"status"] intValue] == 0) {
                [[XCErrorView shareInstance] hidden];
                            NSData *jsonData = [responseObj[@"data"] dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                options:NSJSONReadingMutableContainers
                                                                                  error:nil];
                NSLog(@"%@",dic);
           
                XCHome *home;
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"encryption"] intValue] == 1) {
                    NSString *str = [DES2 decrypt:responseObj[@"data"]];
                    home = [XCHome yy_modelWithJSON:str];
                }else{
                    home = [XCHome yy_modelWithJSON:responseObj[@"data"]];
                }
                [[NSUserDefaults standardUserDefaults]setObject:home.selfTitle forKey:@"selfTitle"];
                self.home = home;

                [self.error removeFromSuperview];
//                [self setupSubviews];
                [self load];
            }else{
            }
            [self.refreshControl endRefreshing];
        });
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


#pragma mark - 数据赋值
- (void) load{
//    NSString *str = [NSString stringWithFormat:@"%ld",(long)self.home.todayRecommendProduct.highMoney];
//    if (str.length>3) {
//        NSString *newMoney =  [str substringToIndex:str.length-2];
    //        self.theme.money.text = [NSString stringWithFormat:@"%0.2lf",[newMoney doubleValue]];
    //    }
//
    XCBanner * banner = self.home.banners[0];
    self.cycleScrollView.imageURLStringsGroup = [NSArray arrayWithObjects:banner.picHref, nil];
    [self.exhausting.logo sd_setImageWithURL:[NSURL URLWithString:self.home.todayRecommendProduct.logo]];
    self.exhausting.name.text =self.home.todayRecommendProduct.name;
    self.exhausting.tags.text =self.home.todayRecommendProduct.tag;
    NSString *str = [NSString stringWithFormat:@"%ld",(long)self.home.todayRecommendProduct.highMoney];
    if (str.length>3) {
        NSString *newMoney =  [str substringToIndex:str.length-2];
        self.exhausting.money.text = [NSString stringWithFormat:@"%0.2lf",[newMoney doubleValue]];
    }
    
    [self.willCollectionView reloadData];
    [self.collectionView reloadData];
    self.tableView.dataArray = self.home.hotProducts;
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.hotLabel.frame), screenWidth, 110*self.home.hotProducts.count);
    [self.tableView reloadData];
    self.scrollView.contentSize = CGSizeMake(screenWidth, CGRectGetMaxY(self.tableView.frame)+20);

    self.proLbl.text = self.home.selfTitle;
}

#pragma mark - 页面布局
- (void) setupSubviews{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight-tabbarHeight);
        [self.view addSubview:_scrollView];
    
        
        if (@available(iOS 11, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
#pragma mark - 轮播图
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,  screenWidth, 180)  delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
        self.cycleScrollView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview: self.cycleScrollView];
        
        
    
        UILabel *rectLab = [self rectLabWithCGRect:CGRectMake(7, 191, 5, 16)];
        [_scrollView addSubview:rectLab];
        
        //今日下款王
        UILabel *recommendLabel = [UILabel labelWithText:@"今日下款王" textClolor:nil font:16 frame:CGRectMake(18,190, screenWidth, 18) isAggravation:NO];
        [_scrollView addSubview:recommendLabel];

//       贷款王的section
        self.exhausting = [XCExhaustingView ExhaustingView];
        self.exhausting.frame = CGRectMake(0, CGRectGetMaxY(recommendLabel.frame)+15, screenWidth, 86);
        [_scrollView addSubview:self.exhausting];
        [self.exhausting themeClick:^{
            [self.exhausting.logo sd_setImageWithURL:[NSURL URLWithString:self.home.todayRecommendProduct.logo]];
            [self pushWeb:self.home.todayRecommendProduct.h5Href title:self.home.todayRecommendProduct.name productId:self.home.todayRecommendProduct.productId type:3];
        }];

        UIImageView *pro = [[UIImageView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.exhausting.frame)+15, 60, 18)];
        pro.image = [UIImage imageNamed:@"notice"];
        [_scrollView addSubview:pro];

        
//         通知内容
        self.proLbl = [UILabel labelWithText:self.home.selfTitle textClolor:colorFromRGB(0x757575) font:12 frame:CGRectMake(CGRectGetMaxX(pro.frame)+7, CGRectGetMaxY(self.exhausting.frame)+17, screenWidth, 15)];
         [_scrollView addSubview:self.proLbl];
        
        UILabel *rectLab1 = [self rectLabWithCGRect:CGRectMake(7, CGRectGetMaxY(self.proLbl.frame)+21, 5, 16)];
        [_scrollView addSubview:rectLab1];

        //必过其一
        UILabel *WillLabel = [UILabel labelWithText:@"必过其一" textClolor:nil font:16 frame:CGRectMake(18, CGRectGetMaxY(self.proLbl.frame)+20, screenWidth, 18) isAggravation:NO];
        [_scrollView addSubview: WillLabel];

        UICollectionViewFlowLayout *wlayout = [[UICollectionViewFlowLayout alloc]init];
        wlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        wlayout.itemSize = CGSizeMake((screenWidth-40)/2, 65);
        wlayout.minimumInteritemSpacing = 10;
        self.willCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(WillLabel.frame)+15,screenWidth-30, 65) collectionViewLayout:wlayout];
        self.willCollectionView.backgroundColor = [UIColor clearColor];
        self.willCollectionView.dataSource = self;
        self.willCollectionView.delegate = self;
        self.willCollectionView.showsHorizontalScrollIndicator = NO;
        [_scrollView addSubview:self.willCollectionView];
        [self.willCollectionView registerClass:[XCWillCollectionViewCell class] forCellWithReuseIdentifier:@"XCWillCollectionViewCell"];

        
        UILabel *rectLab2 = [self rectLabWithCGRect:CGRectMake(7, CGRectGetMaxY(self.willCollectionView.frame)+21, 5, 16)];
        [_scrollView addSubview:rectLab2];
        //热门推荐
        self.hotLabel = [UILabel labelWithText:@"热门推荐" textClolor:nil font:16 frame:CGRectMake(18, CGRectGetMaxY(self.willCollectionView.frame)+20, screenWidth, 18) isAggravation:NO];
        [_scrollView addSubview: self.hotLabel];

        self.all = [UIButton buttonWithText:@"更多产品" font:12 nmlTitleColor:colorFromRGB(0x6F6F6F) hightTitleColor:[UIColor lightGrayColor] frame:CGRectMake(0, CGRectGetMaxY(self.willCollectionView.frame)+20, screenWidth-22, 18) target:self action:@selector(allTouchUpinside)];
        self.all.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_scrollView addSubview:self.all];

        UIImageView *arrow = [[UIImageView alloc]init];
        arrow.frame = CGRectMake(screenWidth-20, CGRectGetMaxY(self.willCollectionView.frame)+23, 6, 12);
        arrow.image = [UIImage imageNamed:@"arrow"];
        [_scrollView addSubview:arrow];

        self.tableView = [[XCProductTableView alloc]init];
        self.tableView.dataArray = self.home.hotProducts;
        self.tableView.pdelegate = self;
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.hotLabel.frame)+15, screenWidth, 110*self.home.hotProducts.count);
        [_scrollView addSubview:self.tableView];

        UIRefreshControl *rc = [[UIRefreshControl alloc]init];
        [rc addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
        self.refreshControl = rc;
        if (@available(iOS 10.0, *)) {
            _scrollView.refreshControl = rc;
        } else {
            [_scrollView addSubview:rc];
        }
    }
}

- (UILabel * )rectLabWithCGRect:(CGRect)rect
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.backgroundColor = CREATE_RGB_COLOR(255, 137, 64);
    return  label;
}
- (void) allTouchUpinside{
    self.tabBarController.selectedIndex = 1;
}

#pragma mark - CollectionView datasource & delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.collectionView]) {
        return self.home.menus.count;
    }
    return self.home.selfProducts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        XCCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"XCCollectionViewCell" forIndexPath:indexPath];
        XCMenu *menu = self.home.menus[indexPath.row];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:menu.categoryPic]];
        cell.name.text = menu.categoryName;
        return cell;
    }
    
    XCWillCollectionViewCell *wcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XCWillCollectionViewCell" forIndexPath:indexPath];
    XCHotProduct *product = self.home.selfProducts[indexPath.row];
    wcell.name.text = product.name;
    wcell.lines.text = [NSString stringWithFormat:@"最高额度:%@元",[self str:product.highMoney]];
    [wcell.logo sd_setImageWithURL:[NSURL URLWithString:product.logo]];
    return wcell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if([collectionView isEqual:self.collectionView]){
        XCMenu *menu = self.home.menus[indexPath.row];
        [self pushWeb:menu.menuHref title:menu.categoryName productId:menu.productId type:1];
        return;
    }
    XCHotProduct *product = self.home.selfProducts[indexPath.row];
    [self pushWeb:product.h5Href title:product.name productId:product.productId type:2];
}

#pragma mark - XCProductTableViewDelegate
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XCHotProduct *product = self.home.hotProducts[indexPath.row];
     [self pushWeb:product.h5Href title:product.name productId:product.productId type:4];
}

- (void) pushWeb:(NSString *)url title:(NSString *)title productId:(NSUInteger)productId type:(NSUInteger)type{
    dispatch_async(dispatch_get_main_queue(), ^{
        XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
        if (get.status == 1 &&  productId != 0) {
            XCWebViewController *web = [[XCWebViewController alloc]init];
            web.url = url;
            web.title = title;
            web.productId = productId;
            [self.navigationController pushViewController:web animated:YES];
        }else{
            if(productId){
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

- (NSString *) str:(NSUInteger)money{
    NSString *str = [NSString stringWithFormat:@"%lu",(unsigned long)money];
    NSString *newMoney =  [str substringToIndex:str.length-2];
    return newMoney;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point=scrollView.contentOffset;
//    NSLog(@"%lf",point.y);
//    if (point.y>-88) {
//         [self.navigationController.navigationBar setTranslucent:true];
//    }else{
//         [self.navigationController.navigationBar setTranslucent:NO];
//    }
}

#pragma mark - 点击轮播图链接
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
    
    XCBanner * banner = self.home.banners[0];
    XCWebViewController *web = [[XCWebViewController alloc]init];
    web.url = banner.pageHref;
    web.title = banner.bannerName;
    [self.navigationController pushViewController:web animated:YES];
    
}
@end
