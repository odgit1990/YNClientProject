//
//  HealthPeoPleViewModel.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "HealthPeoPleViewModel.h"


@implementation YNDrugModel
@end
@implementation YNDrugListModel
@end

@interface HealthPeoPleViewModel ()

@end

@implementation HealthPeoPleViewModel
#pragma mark - getter and setter
-(NSMutableArray *)typeData
{
    if (!_typeData) {
        _typeData=[NSMutableArray new];
    }
    return _typeData;
}
-(NSMutableArray *)datas
{
    if (!_datas) {
        _datas=[NSMutableArray new];
    }
    return _datas;
}
#pragma mark - method
-(void)requestType
{
    @WeakSelf;
    [[InterfaceManager shareInterface] requetInterface:@"get_health_type" withParameter:nil handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (infoModel.errorCode ==0)
        {
            NSMutableArray* arr=[NSMutableArray new];
            NSArray* myArr=[info objectForKey:@"data"];
            for (NSDictionary* dci in myArr) {
                YNDrugModel* model=[YNDrugModel yy_modelWithJSON:dci];
                [arr addObject:model];
            }
            [selfp setTypeData:arr];
        }else
        {
            [FTIndicator showErrorWithMessage:infoModel.errorMsg];
        }
    }];;
}
-(void)requestData:(NSMutableDictionary *)para
{
    @WeakSelf;
    [[InterfaceManager shareInterface] requetInterface:@"get_drug_list" withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (infoModel.errorCode ==0)
        {
            NSMutableArray* arr=[NSMutableArray new];
            NSArray* myArr=[[info objectForKey:@"data"] objectForKey:@"list"];
            for (NSDictionary* dci in myArr) {
                YNDrugListModel* model=[YNDrugListModel yy_modelWithJSON:dci];
                [arr addObject:model];
            }
            [selfp setDatas:arr];
        }else
        {
            [FTIndicator showErrorWithMessage:infoModel.errorMsg];
        }
    }];;
}
#pragma mark - life
-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
#pragma mark - delegate
@end
