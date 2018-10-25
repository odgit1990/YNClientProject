//
//  InterfaceManager.h
//  GYInterfaceManager
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InterfaceStatusModel.h"
#import <AFNetworking.h>
#import <YYModel.h>
#import <FTIndicator.h>

#define InterfaceStatusSuccess          @"0"
#define InterfaceStatusLogin            @"999"
#define strNetError                     @"网络出错了！请稍后重试！"


typedef enum : NSUInteger {
    NetStatusUnknown,
    NetStatusReachable,
    NetStatusWWAN,
    NetStatusWiFi
} NetStatusT;

typedef void(^InterfaceHandler)(NSDictionary *info,InterfaceStatusModel *infoModel);

@interface InterfaceModel : NSObject
@property (nonatomic,strong) NSString *interface;
@property (nonatomic,strong) NSMutableDictionary* para;
@property (nonatomic,copy) InterfaceHandler handler;
@end

@interface InterfaceManager : NSObject
/**
 *          默认情况下状态不为0的接口直接展示错误信息，特殊情况需回调
 */
@property (nonatomic,strong) NSMutableArray *specialInterfaces;
@property (nonatomic,strong) AFHTTPSessionManager *httpManager;
+(instancetype)shareInterface;
-(void)requetInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler;
-(void)requestUploadImageInterface:(NSString *)interface videoUrl:(NSString*)videoUrl withImage:(NSArray *)upImage handler:(InterfaceHandler)handler;
-(void)requestUploadVideoInterface:(NSString *)interface videoUrl:(NSString*)videoUrl handler:(InterfaceHandler)handler;
///根路径
-(NSString *)requestBase;
-(NSString *)requestAcitveDataBase;
///cookies保持
-(void)dealCookies;

@end
