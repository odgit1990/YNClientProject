//
//  GCPresenter.m
//  CBHGroupCar
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCPresenter.h"
#import "AppDelegate.h"
#import "Head.h"
#import "YNLoginVC.h"
@interface GCPresenter()
@property (nonatomic,weak) AppDelegate *appDelegate;
@property (nonatomic,strong) GYLeadVC *leadVC;
@end

@implementation GCPresenter
#pragma mark - getter and setter
-(YNMainTabVC *)mainVC
{
    if (!_mainVC) {
        _mainVC = [[YNMainTabVC alloc]init];
        [self requestLastVersion];
    }
    return _mainVC;
}
-(AppDelegate *)appDelegate
{
    if (!_appDelegate) {
        _appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    }
    return _appDelegate;
}
-(GYLeadVC *)leadVC
{
    if (!_leadVC) {
        _leadVC = [GYLeadVC new];
    }
    return _leadVC;
}
#pragma mark - method
-(void)loadMain
{
    self.appDelegate.window.rootViewController = self.mainVC;
    NSString *hasAppOpened = [[NSUserDefaults standardUserDefaults]objectForKey:kHasAppOpened] ?: @"0";
    if (0 == hasAppOpened.integerValue) {
       // [self loadLead];
    }else{
//        if ([UVLoginViewModel shareInterface].loginInfoModel)
//        {
//            [[InterfaceManager shareInterface].httpManager.requestSerializer setValue:[UVLoginViewModel shareInterface].loginInfoModel.access_token forHTTPHeaderField:@"Authorization"];
//        }
        self.appDelegate.window.rootViewController = self.mainVC;
    }
}
-(void)loadLead
{
    self.appDelegate.window.rootViewController = self.leadVC;
}
-(void)loadLogin
{
    YNLoginVC *login = [YNLoginVC new];
    HMSNavigationController *nav = [[HMSNavigationController alloc]initWithRootViewController:login];
    [self.mainVC presentViewController:nav animated:YES completion:nil];
}

-(void)generalConfig
{
    //设置键盘事件
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    //    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.preventShowingBottomBlankSpace = YES;
    manager.toolbarTintColor = Main_Color;
    manager.toolbarDoneBarButtonItemText = @"完成";
    [[UITextField appearance] setTintColor:Main_Color];
    [[UITextView appearance]setTintColor:Main_Color];
    
    //阿里云文件上
    
    //分享配置
    /**初始化ShareSDK应用
     
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
//    [ShareSDK registerActivePlatforms:@[
//                                        @(SSDKPlatformTypeWechat),
//                                        @(SSDKPlatformTypeQQ)
//                                        ]
//                             onImport:^(SSDKPlatformType platformType)
//     {
//         switch (platformType)
//         {
//             case SSDKPlatformTypeWechat:
//                 [ShareSDKConnector connectWeChat:[WXApi class]];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                 break;
//             default:
//                 break;
//         }
//     }
//                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
//     {
//
//         switch (platformType)
//         {
//             case SSDKPlatformTypeWechat:
//                 [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
//                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
//                 break;
//             case SSDKPlatformTypeQQ:
//                 [appInfo SSDKSetupQQByAppId:@"100371282"
//                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
//                                    authType:SSDKAuthTypeBoth];
//                 break;
//             default:
//                   break;
//         }
//     }];
}
-(void)requestLastVersion
{
    NSMutableDictionary *para = [NSMutableDictionary new];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [para setObject:@"1" forKey:@"type"];
    [para setObject:currentVersion forKey:@"versionnum"];
    NSString *interface = @"getLastVersion";
    [[InterfaceManager shareInterface]requetInterface:interface withParameter:para handler:^(NSDictionary *info, InterfaceStatusModel *infoModel) {
        if (0 == infoModel.errorCode) {
            NSDictionary *data = infoModel.data;
            if (data) {
                NSString *lastVersion = data[@"content"];
                NSString *url = [NSString stringWithFormat:@"%@",data[@"url"]];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发现新版本" message:lastVersion delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                    if (1 == buttonIndex) {
                        NSURL *URL = [NSURL URLWithString:url];
                        [[UIApplication sharedApplication]openURL:URL];
                    }
                }];
            }
        }
    }];
}
-(void)phoneCall:(NSString *)phone
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
-(void)showOriginalImages:(NSArray *)originalImages andImageViews:(NSArray *)sourceImgageViews withIndex:(NSInteger)index
{
    // 1. 创建photoBroseView对象
    PYPhotoBrowseView *photoBroseView = [[PYPhotoBrowseView alloc] init];
    
    // 2.1 设置图片源(UIImageView)数组
    photoBroseView.imagesURL = originalImages;
    if (sourceImgageViews) photoBroseView.sourceImgageViews = sourceImgageViews;
    photoBroseView.currentIndex = index;
    photoBroseView.frameFormWindow = CGRectMake(0, 0, SCREEN_WIDTH, WFCGFloatY(200));
    photoBroseView.frameToWindow = photoBroseView.frameFormWindow;
    // 3.显示(浏览)
    [photoBroseView show];
}
-(void)showOriginalImages:(NSArray *)originalImages andImageViews:(NSArray *)sourceImgageViews
{
    [self showOriginalImages:originalImages andImageViews:sourceImgageViews withIndex:0];
}

///缓存大小
-(float)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size = [fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
-(float)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float folderSize = 0.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        // SDWebImage框架自身计算缓存的实现
        folderSize += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
///清除缓存
-(void)clearCache:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [FTIndicator showSuccessWithMessage:@"已经清除缓存~"];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"cache_clear_noti" object:nil];
    }];
}
#pragma mark - life
+(instancetype)shareInterface
{
    static GCPresenter *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[GCPresenter alloc]init];
        }
    });
    return manager;
}
-(void)dealloc
{
    [[InterfaceManager shareInterface]removeObserver:self forKeyPath:@"netStatus"];
}
-(instancetype)init
{
    if (self = [super init]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        UIWindow *window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        [window makeKeyWindow];
        [window makeKeyAndVisible];
        window.backgroundColor = Main_Color_White;
        self.appDelegate.window = window;
        [self generalConfig];
        if (!_appDelegate.window.rootViewController) {
            GCLaunchVC *vc = [[GCLaunchVC alloc]init];
            _appDelegate.window.rootViewController = vc;
        }
        //
        [[InterfaceManager shareInterface].specialInterfaces addObject:@"getLastVersion"];
        [[InterfaceManager shareInterface]addObserver:self forKeyPath:@"netStatus" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"netStatus"]) {
//        NetStatusT old = [change[@"old"] integerValue];
        NetStatusT new = [change[@"new"] integerValue];
        if (NetStatusWWAN == new) {
            [FTIndicator showToastMessage:@"您现在使用的是手机流量，请注意哦~"];
        }
        if (NetStatusWiFi == new) {
        }
        if (NetStatusReachable == new) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络不可用，请检查一下~" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"检查", nil];
            [alert showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
                if (1 == buttonIndex) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=WIFI"]];
                }
            }];
        }
    }
}
@end
