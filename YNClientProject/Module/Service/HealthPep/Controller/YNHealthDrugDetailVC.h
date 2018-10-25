//
//  YNHealthDrugDetailVC.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "GCBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface YNHealthDrugDetailVC : GCBaseVC<UIWebViewDelegate>
@property (nonatomic,strong) NSDictionary *information;
@property (nonatomic,strong) NSString *passID;
///0 default 1 tab
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) UIWebView *web;

-(void)refresh;

@end

NS_ASSUME_NONNULL_END
