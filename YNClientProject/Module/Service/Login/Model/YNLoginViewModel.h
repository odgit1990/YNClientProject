//
//  YNLoginViewModel.h
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "GCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YNLoginInfoModel : NSObject
@property (nonatomic, strong) NSString * id;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, strong) NSString * username;
@end

@interface YNLoginViewModel : GCBaseViewModel
@property (nonatomic,strong) YNLoginInfoModel *loginInfoModel;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString* password;
@property (nonatomic,strong) NSString* smscode;
@property (nonatomic, strong) NSString * token;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL isLoged;


@property (nonatomic,strong) NSString *validateCode;
@property (nonatomic,strong) NSString *validateCodeStatus;
@property (nonatomic,strong) NSString *backCode;
@property (nonatomic,assign) BOOL canSendCode;
@property (nonatomic,assign) BOOL success;
@property (nonatomic,assign) BOOL loginSuccess;
@property (nonatomic,strong) NSString *registerPhone;

@property (nonatomic,strong) NSString *registeTitle;
@property (nonatomic,assign) BOOL changePsw;
@property (nonatomic,assign) BOOL showAlert;

@property (nonatomic,assign) BOOL authsuccess;
@property (nonatomic,assign) BOOL registerSuccess;

+(instancetype)shareInterface;

-(void)sendCode;
-(void)invalidateTimer;
///常规登录
-(void)requsetLogin;
///短信登录
-(void)requsetSMSLogin;
///退出登录
-(void)requsetLogout;
///修改密码
-(void)requestChangePassword:(NSMutableDictionary *)para;

//绑定手机号
-(void)requestBindMobile:(NSMutableDictionary*)para;

-(void)requestGetCode:(NSMutableDictionary*)para;
-(void)requestAuthCode:(NSMutableDictionary*)para;

-(void)requestRegiter:(NSMutableDictionary*)para;
@end


NS_ASSUME_NONNULL_END
