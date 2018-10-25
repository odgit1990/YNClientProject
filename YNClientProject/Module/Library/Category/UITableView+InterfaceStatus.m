//
//  UITableView+InterfaceStatus.m
//  CBHGroupCar
//
//  Created by mac on 2018/3/1.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UITableView+InterfaceStatus.h"
#import "Pods.h"

@implementation UITableView (InterfaceStatus)
-(void)layoutSubviews
{
    [super layoutSubviews];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(InterfaceStatusCange) name:Noti_UITableView_InterfaceStatus_Change object:nil];
}
-(void)InterfaceStatusCange
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    [self reloadData];
}
@end
