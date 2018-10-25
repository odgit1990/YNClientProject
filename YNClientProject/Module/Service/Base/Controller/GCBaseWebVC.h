//
//  GCBaseWebVC.h
//  CBHGroupCar
//
//  Created by mac on 2018/1/30.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseVC.h"

@interface GCBaseWebVC : GCBaseVC<UIWebViewDelegate>
@property (nonatomic,strong) NSDictionary *information;
///0 default 1 tab
@property (nonatomic,assign) NSInteger type;

@property (nonatomic,strong) UIWebView *web;

-(void)refresh;
@end
