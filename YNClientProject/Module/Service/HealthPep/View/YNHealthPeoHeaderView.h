//
//  YNHealthPeoHeaderView.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^drugTypeHandler)(NSString* passID);
@interface YNHealthPeoHeaderView : UIView
@property(nonatomic,strong)NSMutableArray* passData;
@property(nonatomic,copy)drugTypeHandler handler;
@end

NS_ASSUME_NONNULL_END
