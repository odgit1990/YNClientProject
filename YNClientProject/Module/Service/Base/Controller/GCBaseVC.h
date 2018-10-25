//
//  GCBaseVC.h
//  CBHGroupCar
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCBaseTableView.h"
#import "GCAdaptLabel.h"
#import "GCBaseObservationModel.h"
#import "GYExpandableCell.h"
#import "Library.h"

typedef void(^GCPBaseVCCallback)(NSDictionary *info);

@interface GCBaseVC : UIViewController<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic,copy) GCPBaseVCCallback callback;
@property (nonatomic,strong) GCBaseTableView *baseTable;
@property (nonatomic,assign) BOOL isGroup;
@property (nonatomic,strong) NSMutableDictionary *observationSource;

-(void)initilization;
-(void)viewModelBand;
-(void)reloadData;
-(void)leftBarButtonItemTap:(id)sender;
-(void)dissmissFTIndicatorProgress;
- (void)setRightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(void (^)(void))block;
- (void)setBacKBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(void (^)(void))block;
///注册观察者模式和取消
-(void)registObservation:(GCBaseObservationModel *)observation;
/*
 *       设置导航条主题，可扩充
 *       0深色（深色背景，白色字体，白色状态栏）
 *       1浅色（浅色背景，黑色字体，黑色状态栏）
 *       2透明（浅色背景，白色字体，黑色状态栏）
 */
-(void)setNavgationTheme:(NSInteger)theme;
///顶部遮挡高度
-(CGFloat)topShelterHeight;
///底部遮挡高度
-(CGFloat)bottomShelterHeight;
///右上角菜单
-(void)gotoMenMu;
@end
