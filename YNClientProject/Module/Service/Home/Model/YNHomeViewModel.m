//
//  YNHomeViewModel.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHomeViewModel.h"
#import "Head.h"
@interface YNHomeViewModel ()

@end

@implementation YNHomeViewModel
#pragma mark - getter and setter
-(NSMutableDictionary *)datas
{
    if (!_datas) {
        _datas=[NSMutableDictionary new];
    }
    return _datas;
}
-(NSMutableArray *)itemArr
{
    if (!_itemArr) {
        _itemArr=[NSMutableArray new];
    }
    return _itemArr;
}
#pragma mark - method
-(void)requestData:(NSMutableDictionary *)para
{
    @WeakSelf;
    [[InterfaceManager shareInterface] requetInterface:@"get_home_data" withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (infoModel.errorCode ==0)
        {
            NSMutableArray* arr=[NSMutableArray new];
            if (![WFFunctions WFStrCheckEmpty:[[info objectForKey:@"data"] objectForKey:@"yizixun"]])
            {
                [arr addObject:[[info objectForKey:@"data"] objectForKey:@"yizixun"]];
            }
            if (![WFFunctions WFStrCheckEmpty:[[info objectForKey:@"data"] objectForKey:@"luntan"]])
            {
                [arr addObject:[[info objectForKey:@"data"] objectForKey:@"luntan"]];
            }
            [selfp setItemArr:arr];
            [selfp setDatas:[info objectForKey:@"data"]];
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
