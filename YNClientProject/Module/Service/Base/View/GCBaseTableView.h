//
//  GCBaseTableView.h
//  CBHGroupCar
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBaseImageTitleCell.h"

@interface GCBaseTableView : UITableView
@property (nonatomic,weak) id parentVC;
@property (nonatomic,strong) UIButton *noDataBtn;
@end
