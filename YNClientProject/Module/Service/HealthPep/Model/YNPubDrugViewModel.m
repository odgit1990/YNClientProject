//
//  YNPubDrugViewModel.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNPubDrugViewModel.h"
#import "Head.h"
@implementation YNPubModel

@end
@interface YNPubDrugViewModel ()

@end

@implementation YNPubDrugViewModel
#pragma mark - getter and setter
-(YNPubModel *)pubModel
{
    if (!_pubModel) {
        _pubModel=[YNPubModel new];
        _pubModel.nums=@"1";
    }
    return _pubModel;
}
#pragma mark - method
#pragma mark - life
-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}
#pragma mark - delegate
@end
