//
//  YNPubDrugViewModel.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "GCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface YNPubModel : NSObject
@property(nonatomic,strong)NSString* token;
@property(nonatomic,strong)NSString* cate_id;
@property(nonatomic,strong)NSString* cate_name;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* pic_yaopin;
@property(nonatomic,strong)NSString* pic_bingli;
@property(nonatomic,strong)NSString* pic_code;
@property(nonatomic,strong)NSString* price;
@property(nonatomic,strong)NSString* uname;
@property(nonatomic,strong)NSString* mobile;
@property(nonatomic,strong)NSString* address;
@property(nonatomic,strong)NSString* nums;
@property(nonatomic,strong)NSString* remark;
@property(nonatomic,strong)NSString* lng;
@property(nonatomic,strong)NSString* lat;
@end
@interface YNPubDrugViewModel : GCBaseViewModel
@property(nonatomic,strong)YNPubModel* pubModel;
@end

NS_ASSUME_NONNULL_END
