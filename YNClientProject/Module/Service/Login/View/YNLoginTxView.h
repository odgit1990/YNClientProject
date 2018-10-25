//
//  YNLoginTxView.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/24.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Head.h"
NS_ASSUME_NONNULL_BEGIN

@interface YNLoginTxView : UIView
@property(nonatomic,strong)UIImageView* lineIV;
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UITextField* phoneTF;
-(instancetype)initWithFrame:(CGRect)frame image:(NSString*)image type:(NSInteger)type;
@end

NS_ASSUME_NONNULL_END
