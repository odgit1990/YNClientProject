//
//  YNHealthFriendViewModel.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHealthFriendViewModel.h"
#import "Head.h"

@implementation YNHealthNewSModel
@end
@interface YNHealthFriendViewModel ()

@end

@implementation YNHealthFriendViewModel
#pragma mark - getter and setter
-(NSMutableArray *)docArr
{
    if (!_docArr) {
        _docArr=[NSMutableArray new];
    }
    return _docArr;
}
-(NSMutableArray *)healthArr
{
    if (!_healthArr) {
        _healthArr=[NSMutableArray new];
    }
    return _healthArr;
}
#pragma mark - method
-(void)requestRightData:(NSMutableDictionary *)para
{
    @WeakSelf;
    NSString *page = para[@"page"];
    [[InterfaceManager shareInterface] requetInterface:@"get_news_list" withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (infoModel.errorCode ==0)
        {
            NSDictionary *data = infoModel.data;
            NSInteger totlaCount=[[data objectForKey:@"total"] integerValue];
            if ([page integerValue]==1) {
                [selfp.healthArr removeAllObjects];
            }
            
            NSArray *datalist = data[@"list"];
            if ([datalist isKindOfClass:[NSArray class]])
            {
                if (self.healthArr.count<totlaCount) {
                    selfp.rightAdd=YES;
                }else
                {
                    selfp.rightAdd=NO;
                }
                NSMutableArray* myArr=[NSMutableArray new];
                for (NSDictionary* dic in datalist) {
                    YNHealthNewSModel* model=[YNHealthNewSModel yy_modelWithJSON:dic];
                    [myArr addObject:model];
                }
                [selfp.healthArr addObjectsFromArray:myArr];
            }else
            {
                selfp.rightAdd=NO;
            }
            
        }else
        {
            [FTIndicator showErrorWithMessage:infoModel.errorMsg];
        }
    }];;
}
-(void)requestLeftData:(NSMutableDictionary *)para
{
    @WeakSelf;
    NSString *page = para[@"page"];
    [[InterfaceManager shareInterface] requetInterface:@"get_news_list" withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (infoModel.errorCode ==0)
        {
            NSDictionary *data = infoModel.data;
            NSInteger totlaCount=[[data objectForKey:@"total"] integerValue];
            if ([page integerValue]==1) {
                [selfp.docArr removeAllObjects];
            }
            
            NSArray *datalist = data[@"list"];
            if ([datalist isKindOfClass:[NSArray class]])
            {
                if (self.docArr.count<totlaCount) {
                    selfp.leftAdd=YES;
                }else
                {
                    selfp.leftAdd=NO;
                }
                NSMutableArray* myArr=[NSMutableArray new];
                for (NSDictionary* dic in datalist) {
                    YNHealthNewSModel* model=[YNHealthNewSModel yy_modelWithJSON:dic];
                    [myArr addObject:model];
                }
                [selfp.docArr addObjectsFromArray:myArr];
            }else
            {
                selfp.leftAdd=NO;
            }
            
        }else
        {
            [FTIndicator showErrorWithMessage:infoModel.errorMsg];
        }
    }];;
}
#pragma mark - life
-(instancetype)init
{
    //
    if (self = [super init]) {
        
    }
    return self;
}
#pragma mark - delegate
@end
