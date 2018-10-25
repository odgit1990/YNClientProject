//
//  YNHomeViewModel.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "GCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YNHomeViewModel : GCBaseViewModel
@property(nonatomic,strong)NSMutableDictionary* datas;
@property(nonatomic,strong)NSMutableArray* itemArr;
-(void)requestData:(NSMutableDictionary*)para;
@end

NS_ASSUME_NONNULL_END
