//
//  XCProductTableView.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCProductTableView.h"
#import "XCProductCell.h"
@interface XCProductTableView()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation XCProductTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSelf];
    }
    return self;
}

- (instancetype)init{
    if (self= [super init]) {
        [self setupSelf];
    }
    return self;
}

- (void) setupSelf{
    self.separatorStyle = UITableViewCellAccessoryNone;
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = NO;
    self.showsVerticalScrollIndicator = NO;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XCProductCell *cell = [XCProductCell productCell:tableView];
   

    XCHotProduct *pro = self.dataArray[indexPath.row];
    cell.product = pro;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.pdelegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]){
        [self.pdelegate didSelectRowAtIndexPath:indexPath];
    }
}



@end

