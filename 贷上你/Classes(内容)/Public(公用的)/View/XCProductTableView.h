//
//  XCProductTableView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol XCProductTableViewDelegate <NSObject>
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface XCProductTableView : UITableView
@property(nonatomic,assign)id<XCProductTableViewDelegate> pdelegate;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

NS_ASSUME_NONNULL_END
