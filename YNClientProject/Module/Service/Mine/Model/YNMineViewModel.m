//
//  YNMineViewModel.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNMineViewModel.h"
#import "Head.h"

@implementation YNMineInfoModel
@end
@interface YNMineViewModel ()

@end

@implementation YNMineViewModel
#pragma mark - getter and setter
#pragma mark - method
-(void)requestData
{
    @WeakSelf;
    NSMutableDictionary *para = [NSMutableDictionary new];
    NSString *interface = @"get_user_info";
    [para setObject:[YNLoginViewModel shareInterface].token forKey:@"token"];
    [[InterfaceManager shareInterface]requetInterface:interface withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode)
        {
            NSDictionary *data = info[@"data"];
            YNMineInfoModel* model = [YNMineInfoModel yy_modelWithJSON:data];
            [selfp setInfoModel:model];

        }else
        {
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}
+(instancetype)shareInterface
{
    static YNMineViewModel *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [YNMineViewModel new];
        }
    });
    return manager;
}
#pragma mark - life
-(instancetype)init
{
    if (self = [super init]) {
        [[InterfaceManager shareInterface].specialInterfaces addObject:@"get_user_info"];
    }
    return self;
}
#pragma mark - delegate
@end
