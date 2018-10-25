//
//  GCPresenter.h
//  CBHGroupCar
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YNMainTabVC.h"
@class YNMainTabVC;
@interface GCPresenter : NSObject
//主视图控制器
@property (nonatomic,strong) YNMainTabVC *mainVC;

+(instancetype)shareInterface;

-(void)loadMain;
-(void)loadLead;
-(void)loadLogin;
///打电话
-(void)phoneCall:(NSString *)phone;
///查看大图
-(void)showOriginalImages:(NSArray *)originalImages andImageViews:(NSArray *)sourceImgageViews withIndex:(NSInteger)index;
-(void)showOriginalImages:(NSArray *)originalImages andImageViews:(NSArray *)sourceImgageViews;
///缓存大小
-(float)fileSizeAtPath:(NSString *)path;
-(float)folderSizeAtPath:(NSString *)path;
///清除缓存
-(void)clearCache:(NSString *)path;
@end
