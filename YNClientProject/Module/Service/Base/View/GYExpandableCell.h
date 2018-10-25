//
//  GYExpandableCell.h
//  GYDemo
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ACEExpandableTextCell.h"
#import "GCBaseEditCellViewModel.h"

@interface GYExpandableCell : ACEExpandableTextCell
@property (nonatomic,strong) UILabel *titleLB;
@property (nonatomic,strong) GCBaseEditCellViewModel *model;
@end
