//
//  YNMineViewModel.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "GCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface YNMineInfoModel : NSObject
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * balance;
@property (nonatomic, strong) NSString * deposit;
@property (nonatomic, strong) NSString * gender;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * idcard;
@property (nonatomic, strong) NSString * mobile;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * status_auth;
@property (nonatomic, strong) NSString * username;
@end
@interface YNMineViewModel : GCBaseViewModel
@property(nonatomic,strong)YNMineInfoModel* infoModel;
+(instancetype)shareInterface;
-(void)requestData;
@end

NS_ASSUME_NONNULL_END
