//
//  HealthPeoPleViewModel.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "GCBaseViewModel.h"
#import "Head.h"
NS_ASSUME_NONNULL_BEGIN

@interface YNDrugModel: NSObject
@property (nonatomic, strong) NSString * cate_id;
@property (nonatomic, strong) NSString * cate_name;
@property (nonatomic, strong) NSString * px;
@end
@interface YNDrugListModel: NSObject
@property (nonatomic, strong) NSString * distance;
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * nums;
@property (nonatomic, strong) NSString * pic_yaopin;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, strong) NSString * title;
@end

@interface HealthPeoPleViewModel : GCBaseViewModel
@property(nonatomic,strong)NSMutableArray* typeData;
@property(nonatomic,strong)NSMutableArray* datas;
@property(nonatomic,strong)NSString* typeID;
@property(nonatomic,strong)NSString* orderBy;
-(void)requestType;
-(void)requestData:(NSMutableDictionary*)para;
@end

NS_ASSUME_NONNULL_END
