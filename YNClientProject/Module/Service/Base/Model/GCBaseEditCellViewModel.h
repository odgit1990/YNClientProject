//
//  GCBaseEditCellViewModel.h
//  GYDemo
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseViewModel.h"
#import <UIKit/UIKit.h>
@interface GCBaseEditCellViewModel : GCBaseViewModel
///标题
@property (nonatomic,strong) NSString *title;
///是否是必选
@property (nonatomic,assign) BOOL necessary;
///显示值
@property (nonatomic,strong) NSString *value;
///placeholder
@property (nonatomic,strong) NSString *placeholder;
///对应操作model的键
@property (nonatomic,strong) NSString *modelKey;
///点击动作（为空时为点击输入）
@property (nonatomic,strong) NSString *tapAction;
///cell高度
@property (nonatomic,assign) CGFloat cellheight;
///为输入类型时键盘类型
@property (nonatomic,assign) UIKeyboardType inputType;
///单位
@property (nonatomic,strong) NSString *unit;
///是否可输入
@property (nonatomic,assign) BOOL canEdit;
///cell高度是否可调
@property (nonatomic,assign) BOOL canExpandable;
///cell是否可编辑
@property (nonatomic,assign) BOOL canCommit;
///特殊信息
@property (nonatomic,strong) NSMutableDictionary *temInfo;
///是否是特殊视图
@property (nonatomic,assign) BOOL isSpecialView;
///特殊视图
@property (nonatomic,strong) UIView *specialView;
@end
