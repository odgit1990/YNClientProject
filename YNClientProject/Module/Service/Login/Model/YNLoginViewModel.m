//
//  UVLoginViewModel.m
//  UVTao
//
//  Created by mac on 2018/8/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "YNLoginViewModel.h"
#import "Head.h"

@implementation YNLoginInfoModel
+(NSString *)getTableName
{
    return NSStringFromClass(self);
}
@end

@interface YNLoginViewModel ()
{
    //
    NSInteger leftSecond;
    NSTimer *timer;
}
@end
@interface YNLoginViewModel()
@end

@implementation YNLoginViewModel
#pragma mark - getter and setter

#pragma mark - getter and setter
-(BOOL)canSendCode
{
    if ([self.validateCodeStatus isEqualToString:@"重新发送"] || [self.validateCodeStatus isEqualToString:@"获取验证码"]) {
        return YES;
    }else{
        return NO;
    }
}
//-(YNLoginInfoModel *)loginInfoModel
//{
//    NSString *sql = [NSString stringWithFormat:@"select * from YNLoginInfoModel where mobile = %@",self.username];
//    NSLog(@"%@",NSHomeDirectory());
//    NSArray *arr = [YNLoginInfoModel searchWithSQL:sql];
//    YNLoginInfoModel *model;
//    if (arr.count > 0) {
//        model = arr[0];
//    }
//    return model;
//}
-(NSString *)username
{
    if (!_username) {
        _username = [[NSUserDefaults standardUserDefaults]objectForKey:kLoginUsername] ?: @"";
    }
    return _username;
}

#pragma mark - method
+(instancetype)shareInterface
{
    static YNLoginViewModel* model;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!model) {
            model=[YNLoginViewModel new];
        }
    });
    
    return model;
}
-(instancetype)init
{
    if (self = [super init]) {
        [[InterfaceManager shareInterface].specialInterfaces addObject:@"user_login"];
        [[InterfaceManager shareInterface].specialInterfaces addObject:@"user_auth_code"];
        [[InterfaceManager shareInterface].specialInterfaces addObject:@"code"];
        [[InterfaceManager shareInterface].specialInterfaces addObject:@"register"];
        leftSecond=60;
    }
    return self;
}
-(void)requsetLogin
{
    [FTIndicator showProgressWithMessage:@"正在登陆"];
    NSMutableDictionary* para = [[NSMutableDictionary alloc] init];
    [para setObject:self.username ?: @"" forKey:@"username"];
    [para setObject:self.password ?: @"" forKey:@"password"];
    [para setObject:@"1" forKey:@"keytype"];
    @WeakSelf;
    [[InterfaceManager shareInterface] requetInterface:@"user_login" withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        
        if (0 == infoModel.errorCode)
        {
            [FTIndicator showSuccessWithMessage:@"登录成功"];
            NSDictionary *data = info[@"data"];
            YNLoginInfoModel* model = [YNLoginInfoModel yy_modelWithJSON:data];
            
            [[NSUserDefaults standardUserDefaults]setObject:model.username ?: @"" forKey:kLoginUsername];
            [[NSUserDefaults standardUserDefaults]setObject:selfp.password ?: @"" forKey:kLoginPsw];
            
            [[InterfaceManager shareInterface].httpManager.requestSerializer setValue:model.token forHTTPHeaderField:@"token"];
            [selfp setToken:model.token];
            [selfp setIsLogin:YES];
            [selfp setLoginInfoModel:model];
        }
        else
        {
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}

-(void)requsetSMSLogin
{
    NSMutableDictionary* para = [[NSMutableDictionary alloc] init];
    [para setObject:self.username ?: @"" forKey:@"mobile"];
    [para setObject:self.smscode ?: @"123456" forKey:@"smscode"];
    @WeakSelf;
    [[InterfaceManager shareInterface] requetInterface:@"user_sms_login" withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode)
        {
            NSDictionary *data = info[@"data"];
            YNLoginInfoModel* model = [YNLoginInfoModel yy_modelWithJSON:data];
            [model saveToDB];
            
            [selfp invalidateTimer];
            [[NSUserDefaults standardUserDefaults]setObject:model.username ?: @"" forKey:kLoginUsername];
            selfp.isLogin=YES;
            [selfp setToken:model.token];
            [selfp setLoginInfoModel:model];
           
        }else
        {
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}

-(void)requestChangePassword:(NSMutableDictionary *)para
{
    [FTIndicator showProgressWithMessage:@"正在修改密码"];
    @WeakSelf;
    [[InterfaceManager shareInterface] requetInterface:@"user_password_edit" withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode)
        {
            [selfp setChangePsw:YES];
            [FTIndicator showSuccessWithMessage:@"修改成功"];
        }else
        {
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}

//-(void)requestgetCode
//{
//    @WeakSelf;
//    NSMutableDictionary *para = [[NSMutableDictionary alloc]init];
//    [para setObject:self.username forKey:@"username"];
//    [para setObject:@"" forKey:@""];
//    NSString *inter = @"code";
//    [self timerBegin];
//    [[InterfaceManager shareInterface]requetInterface:inter withParameter:para handler:^(NSDictionary *info,InterfaceStatusModel *infoModel) {
//        [selfp timerBegin];
//    }];
//}
-(void)requestBindMobile:(NSMutableDictionary *)para
{
    @WeakSelf;
    NSString *inter = @"user_modify_mobile";
    [[InterfaceManager shareInterface]requetInterface:inter withParameter:para handler:^(NSDictionary *info,InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode)
        {
            [FTIndicator showSuccessWithMessage:@"修改成功"];
            [selfp setAuthsuccess:YES];
        }else
        {
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}
-(void)requestGetCode:(NSMutableDictionary *)para
{
    @WeakSelf;
    NSString *inter = @"code";
    [para setObject:@"111111" forKey:@"nonce"];
    [para setObject:[WFFunctions md5:[NSString stringWithFormat:@"%@111111%@",CC_MD5_key,[WFFunctions getStringNow]]] forKey:@"noncehash"];
    [FTIndicator showProgressWithMessage:@"正在获取验证码"];
    [[InterfaceManager shareInterface]requetInterface:inter withParameter:para handler:^(NSDictionary *info,InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode)
        {
            [self timerBegin];
            [selfp setSuccess:YES];
            [selfp setRegisteTitle:[info[@"data"] objectForKey:@"title"]];
            [FTIndicator showSuccessWithMessage:@"验证码已发送到您的手机请注意查收"];
        }else
        {
            [selfp setSuccess:NO];
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}
-(void)requestAuthCode:(NSMutableDictionary *)para
{
    @WeakSelf;
    NSString *inter = @"user_auth_code";
    [[InterfaceManager shareInterface]requetInterface:inter withParameter:para handler:^(NSDictionary *info,InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode)
        {
            [selfp setAuthsuccess:YES];
        }else
        {
            [selfp setAuthsuccess:NO];
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}
-(void)requestRegiter:(NSMutableDictionary *)para
{
    @WeakSelf;
    NSString *inter = @"register";
    [FTIndicator showProgressWithMessage:@"正在注册"];
    [[InterfaceManager shareInterface]requetInterface:inter withParameter:para handler:^(NSDictionary *info,InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode)
        {
            [FTIndicator showSuccessWithMessage:@"注册成功"];
            selfp.username=para[@"username"];
            selfp.password=para[@"password"];
            [self requsetLogin];
        }else
        {
            [FTIndicator showErrorWithMessage:info[@"errorMsg"]];
        }
    }];
}
-(void) requsetLogout
{
    [self.loginInfoModel deleteToDB];
    [self setLoginInfoModel:nil];
    [[InterfaceManager shareInterface].httpManager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:kLoginUsername];

    [[GCPresenter shareInterface]loadLogin];
}

#pragma mark - method
-(void)sendCode
{
    if ([WFFunctions WFStrIsMobileNumber:self.username])
    {
        //[self requestgetCode];
    }else{
        [FTIndicator showErrorWithMessage:@"手机号格式错误"];
    }
}
-(void)timerBegin
{
    timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSet:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
-(void)timerSet:(NSTimer*)sender//定时器
{
    if(1 == leftSecond)
    {
        [sender invalidate];
        self.validateCodeStatus = @"重新发送";
        leftSecond = 60;
        [sender invalidate];
        sender = nil;
    }
    else
    {
        leftSecond--;
        self.validateCodeStatus = [NSString stringWithFormat:@"%ld秒",leftSecond];
    }
}
-(void)invalidateTimer
{
    [timer invalidate];
    timer = nil;
    leftSecond = 60;
    self.validateCodeStatus = @"获取验证码";
}

@end
