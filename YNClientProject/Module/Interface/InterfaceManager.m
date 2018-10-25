//
//  InterfaceManager.m
//  GYInterfaceManager
//
//  Created by mac on 2018/3/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "InterfaceManager.h"
#import <netdb.h>
#import <AVFoundation/AVFoundation.h>
#import "Category.h"
#import "Macro.h"
#import "Head.h"
@implementation InterfaceModel
@end

@interface InterfaceManager()
//特殊处理
@property (nonatomic,strong) NSMutableArray *exceptions;
@property (nonatomic,strong) NSMutableArray *exceptionHandlers;
@property (nonatomic,assign) NetStatusT netStatus;
@property (nonatomic,strong) NSMutableArray *getApis;
@property (nonatomic,strong) NSMutableArray *postApis;
///断网情况下的接口
@property (nonatomic,strong) NSMutableArray *offlineInterfaces;
@end

@implementation InterfaceManager
#pragma mark - getter and setter
-(NSMutableArray *)specialInterfaces
{
    if (!_specialInterfaces) {
        _specialInterfaces = [NSMutableArray new];
        [_specialInterfaces addObject:@"authCodeGet"];
        [_specialInterfaces addObject:@"userLogin"];
    }
    return _specialInterfaces;
}
-(NSMutableArray *)exceptions
{
    if (!_exceptions) {
        _exceptions = [NSMutableArray new];
    }
    return _exceptions;
}
-(NSMutableArray *)exceptionHandlers
{
    if (!_exceptionHandlers) {
        _exceptionHandlers = [NSMutableArray new];
    }
    return _exceptionHandlers;
}
-(AFHTTPSessionManager *)httpManager
{
    if (!_httpManager) {
        _httpManager = [[AFHTTPSessionManager alloc]init];
        _httpManager.responseSerializer.acceptableContentTypes = [_httpManager.responseSerializer.acceptableContentTypes setByAddingObjectsFromArray:@[@"application/json", @"text/html",@"text/json",@"text/javascript"]];
        _httpManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [_httpManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _httpManager.requestSerializer.timeoutInterval = 15;
        [_httpManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        

        
        //不序列化
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _httpManager;
}
-(NSMutableArray *)getApis
{
    if (!_getApis) {
        _getApis = [NSMutableArray new];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Interface" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSDictionary *gets = dic[@"getInterfaces"];
        [_getApis addObjectsFromArray:gets.allKeys];
    }
    return _getApis;
}
-(NSMutableArray *)postApis
{
    if (!_postApis) {
        _postApis = [NSMutableArray new];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Interface" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        NSDictionary *posts = dic[@"postInterfaces"];
        [_postApis addObjectsFromArray:posts.allKeys];
    }
    return _postApis;
}
-(NSMutableArray *)offlineInterfaces
{
    if (!_offlineInterfaces) {
        _offlineInterfaces = [NSMutableArray new];
    }
    return _offlineInterfaces;
}
-(void)setNetStatus:(NetStatusT)netStatus
{
    _netStatus = netStatus;
    if (NetStatusWWAN == _netStatus || NetStatusWiFi == _netStatus) {
        for (InterfaceModel *model in self.offlineInterfaces) {
            NSString *interface = model.interface;
            NSMutableDictionary *para = model.para;
            InterfaceHandler handler = model.handler;
            [self requetInterface:interface withParameter:para handler:handler];
        }
        //完事清空离线接口
        [self.offlineInterfaces removeAllObjects];
    }
}
#pragma mark - event
#pragma mark - method
+(instancetype)shareInterface
{
    static InterfaceManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[InterfaceManager alloc]init];
            
        }
    });
    return manager;
}
///cookies保持
-(void)dealCookies
{
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray<NSHTTPCookie *> *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:[self requestBase]]];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull cookie, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *properties = [[cookie properties] mutableCopy];
        //将cookie过期时间设置为一年后
        NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*30*12];
        properties[NSHTTPCookieExpires] = expiresDate;
        //下面一行是关键,删除Cookies的discard字段，应用退出，会话结束的时候继续保留Cookies
        [properties removeObjectForKey:NSHTTPCookieDiscard];
        //重新设置改动后的Cookies
        [cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:properties]];
    }];
}
-(NSString *)requestBase
{
    NSString *root;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Interface" ofType:@"plist"];
    if (path) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        if (dic) {
            root = !DEBUG ? dic[@"request_base"] : dic[@"request_base_test"];
        }
    }
    return root;
}
-(NSString *)requestAcitveDataBase
{
    NSString *root = [self requestBase];
    NSString *dataRoot = [NSString stringWithFormat:@"%@%@",root,@"/iOS/data"];
    return dataRoot;
}
-(NSString*)getProcess:(NSString* )interface
{
    NSString *link;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Interface" ofType:@"plist"];
    if (path) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        if (dic) {
            NSDictionary *info;
            if ([self.getApis containsObject:interface]) {
                info = dic[@"getInterfaces"];
            }
            if ([self.postApis containsObject:interface]) {
                info = dic[@"postInterfaces"];
            }
            NSString *api = info[interface];
            link = [NSString stringWithFormat:@"%@",api];
        }
    }
    return link;
}
-(NSString *)interfaceLink:(NSString *)interface
{
    NSString *link;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Interface" ofType:@"plist"];
    if (path) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        if (dic) {
            NSString *root = [self requestBase];
            NSDictionary *info;
            if ([self.getApis containsObject:interface]) {
                info = dic[@"getInterfaces"];
            }
            if ([self.postApis containsObject:interface]) {
                info = dic[@"postInterfaces"];
            }
            NSString *api = info[interface];
            link = [NSString stringWithFormat:@"%@%@",root,api];
        }
    }
    return link;
}
-(void)requetInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler
{
    if (![self connectedToNetwork]) {
        NSString *url = [self interfaceLink:interface];
        NSLog(@"请求网址:%@\n请求参数:%@",url, para);
        [FTIndicator showErrorWithMessage:strNetError];
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
        
        //断网状态接口保存
        InterfaceModel *intefacemodel = [InterfaceModel new];
        intefacemodel.interface = interface;
        intefacemodel.para = para;
        intefacemodel.handler = handler;
        [self.offlineInterfaces addObject:intefacemodel];
    }else {
        if ([self.getApis containsObject:interface]) {
            [self requetGetInterface:interface withParameter:para handler:handler];
        }
        if ([self.postApis containsObject:interface]) {
            [self requetPostInterface:interface withParameter:para handler:handler];
        }
    }
}
-(void)requetGetInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler
{
    NSString *url = [self interfaceLink:interface];
    [self.httpManager GET:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealResponse:task response:responseObject handler:handler interface:interface url:url parameter:para];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求网址:%@\n请求参数:%@",url, para);
        [FTIndicator showErrorWithMessage:strNetError];
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
    }];
}
-(void)requetPostInterface:(NSString *)interface withParameter:(NSMutableDictionary *)para handler:(InterfaceHandler)handler
{
    NSString *url = [self interfaceLink:interface];
    [_httpManager.requestSerializer setValue:[WFFunctions procsssPara:[self getProcess:interface]] forHTTPHeaderField:@"sign"];
    [_httpManager.requestSerializer setValue:@"v1" forHTTPHeaderField:@"version"];
    [_httpManager.requestSerializer setValue:[WFFunctions getStringNow] forHTTPHeaderField:@"timestamp"];

    [self.httpManager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dealResponse:task response:responseObject handler:handler interface:interface url:url parameter:para];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求网址:%@\n请求参数:%@",url, para);
        [FTIndicator showErrorWithMessage:strNetError];
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
    }];
}
-(void)dealResponse:(NSURLSessionDataTask *_Nonnull)task response:(id  _Nullable)responseObject handler:(InterfaceHandler)handler interface:(NSString *)interface url:(NSString *)url parameter:(NSDictionary *)para
{
    NSDictionary *info = responseObject;
    NSData *data = [NSJSONSerialization dataWithJSONObject:info options:kNilOptions error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"请求网址:%@\n请求参数:%@", url, para);
    NSLog(@"返回:%@",jsonString);
    InterfaceStatusModel *infoModel = [InterfaceStatusModel yy_modelWithJSON:info];
    
    if (infoModel.errorCode == InterfaceStatusSuccess.integerValue) {
        handler(info,infoModel);
    }else if ([self.exceptions containsObject:[NSString stringWithFormat:@"%ld",infoModel.errorCode]]) {
        void (^exceptionHandler)(NSDictionary *information) = self.exceptionHandlers[[self.exceptions indexOfObject:[NSString stringWithFormat:@"%ld",infoModel.errorCode]]];
        exceptionHandler(info);
    }else{
        if ([self.specialInterfaces containsObject:interface]) {
            handler(info,infoModel);
        }else{
            if (infoModel.errorCode==110)
            {
                [FTIndicator showErrorWithMessage:[NSString stringWithFormat:@"您输入的内容包含敏感词,请修改后重新提交!"]];
            }else
            {
                [FTIndicator showErrorWithMessage:infoModel.errorMsg];
            }
        }
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
}
-(void)addHandler:(void (^)(NSDictionary *info))handler forException:(NSString *)exceptionid
{
    if (handler && exceptionid) {
        [self.exceptions addObject:exceptionid];
        [self.exceptionHandlers addObject:handler];
    }
}

- (BOOL)connectedToNetwork {
#if (defined(__IPHONE_OS_VERSION_MIN_REQUIRED) && __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000) || (defined(__MAC_OS_X_VERSION_MIN_REQUIRED) && __MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    struct sockaddr_in6 zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin6_len = sizeof(zeroAddress);
    zeroAddress.sin6_family = AF_INET6;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
#else
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
#endif
    
    //    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    //    SCNetworkReachabilityFlags flags;
    //
    //    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    //    CFRelease(defaultRouteReachability);
    //    if (!didRetrieveFlags) {
    //        return NO;
    //    }
    //
    //    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    //    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    //    return (isReachable && !needsConnection) ? YES : NO;
}
#pragma mark - life
-(instancetype)init
{
    if (self = [super init]) {
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NetStatusT netStatus = AFNetworkReachabilityStatusReachableViaWiFi == status ? NetStatusWiFi : (AFNetworkReachabilityStatusReachableViaWWAN == status ? NetStatusWWAN : (AFNetworkReachabilityStatusNotReachable == status ? NetStatusReachable : NetStatusUnknown));
            [self setNetStatus:netStatus];
        }];
        [self.httpManager.reachabilityManager startMonitoring];
    }
    return self;
}
/**mov转mp4格式*/
-(void)convertMovSourceURL:(NSURL *)sourceUrl {
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:sourceUrl options:nil];
    NSArray *compatiblePresets=[AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    //NSLog(@"%@",compatiblePresets);
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        AVAssetExportSession *exportSession=[[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality]; NSDateFormatter *formater=[[NSDateFormatter alloc] init];
        //用时间给文件全名
        [formater setDateFormat:@"yyyyMMddHHmmss"]; NSString *mp4Path=[[NSUserDefaults standardUserDefaults] objectForKey:@"kMP4FilePath"]; NSString *resultPath=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingFormat:@"/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        exportSession.outputURL=[NSURL fileURLWithPath:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
            switch (exportSession.status) {
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"AVAssetExportSessionStatusCancelled");
                    break;
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                    break;
                case AVAssetExportSessionStatusWaiting:
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                    break;
                case AVAssetExportSessionStatusExporting:
                    NSLog(@"AVAssetExportSessionStatusExporting");
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    //NSLog(@"resultPath = %@",resultPath);
                    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"转换完成" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *confirm=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                    [alert addAction:confirm];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                    BOOL success=[[NSFileManager defaultManager]moveItemAtPath:resultPath toPath:[mp4Path stringByAppendingPathComponent:@"1.mp4"] error:nil];
                    if(success)
                    {
                        NSArray *files=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:mp4Path error:nil];
                        NSLog(@"%@",files);
                        NSLog(@"success");
                    }
                    
                    break;
                }
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"AVAssetExportSessionStatusFailed");
                    break;
            }
        }];
    }
}
-(void)requestUploadImageInterface:(NSString *)interface videoUrl:(NSString *)videoUrl withImage:(NSArray *)upImage handler:(InterfaceHandler)handler
{

    NSString *url = @"http://192.168.4.10/image/upload/";
    [self.httpManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        if (videoUrl)
        {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoUrl]];
            AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoUrl] options:nil];
            NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
            //NSLog(@"%@",compatiblePresets);
            if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
                AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                //用时间给文件全名
                [formater setDateFormat:@"yyyyMMddHHmmss"];
                NSString *resultPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingFormat:@"/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
                exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
                exportSession.outputFileType = AVFileTypeMPEG4;
                exportSession.shouldOptimizeForNetworkUse = YES;
                [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
                    switch (exportSession.status) {
                        case AVAssetExportSessionStatusCancelled:
                            NSLog(@"AVAssetExportSessionStatusCancelled");
                            break;
                        case AVAssetExportSessionStatusUnknown:
                            NSLog(@"AVAssetExportSessionStatusUnknown");
                            break;
                        case AVAssetExportSessionStatusWaiting:
                            NSLog(@"AVAssetExportSessionStatusWaiting");
                            break;
                        case AVAssetExportSessionStatusExporting:
                            NSLog(@"AVAssetExportSessionStatusExporting");
                            break;
                        case AVAssetExportSessionStatusCompleted:
                        {
                            NSData *data = [NSData dataWithContentsOfFile:resultPath];
                            [formData appendPartWithFileData:data name:@"video" fileName:@"video.mp4" mimeType:@"video/mp4"];
                            break;
                        }
                        case AVAssetExportSessionStatusFailed:
                            NSLog(@"AVAssetExportSessionStatusFailed");
                            break;
                    }
                }];
            }
        }
        for (int i=0; i<upImage.count; i++)
        {
            NSData *temData = UIImageJPEGRepresentation(upImage[i], 0.8);
            NSString * fileName = [NSString stringWithFormat:@"file_%d.png", i];
            [formData appendPartWithFileData:temData name:fileName fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic_name = responseObject;
        InterfaceStatusModel *infoModel = [InterfaceStatusModel yy_modelWithJSON:dic_name];
        handler(dic_name,infoModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求网址:%@",url);
        [FTIndicator showErrorWithMessage:strNetError];
        handler(nil,nil);
        [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
    }];
}
-(void)requestUploadVideoInterface:(NSString *)interface videoUrl:(NSString*)videoUrl handler:(InterfaceHandler)handler
{
    NSString *url = @"http://192.168.4.10/image/upload/";
    if (videoUrl)
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoUrl]];
        AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:videoUrl] options:nil];
        NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
        //NSLog(@"%@",compatiblePresets);
        if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
            AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            //用时间给文件全名
            [formater setDateFormat:@"yyyyMMddHHmmss"];
            NSString *resultPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingFormat:@"/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
            exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
            exportSession.outputFileType = AVFileTypeMPEG4;
            exportSession.shouldOptimizeForNetworkUse = YES;
            [exportSession exportAsynchronouslyWithCompletionHandler:^(void){
                switch (exportSession.status) {
                    case AVAssetExportSessionStatusCancelled:
                        NSLog(@"AVAssetExportSessionStatusCancelled");
                        break;
                    case AVAssetExportSessionStatusUnknown:
                        NSLog(@"AVAssetExportSessionStatusUnknown");
                        break;
                    case AVAssetExportSessionStatusWaiting:
                        NSLog(@"AVAssetExportSessionStatusWaiting");
                        break;
                    case AVAssetExportSessionStatusExporting:
                        NSLog(@"AVAssetExportSessionStatusExporting");
                        break;
                    case AVAssetExportSessionStatusCompleted:
                    {
                        NSData *data = [NSData dataWithContentsOfFile:resultPath];
                        [self.httpManager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                            [formData appendPartWithFileData:data name:@"video" fileName:@"video.mp4" mimeType:@"video/mp4"];
                        } progress:^(NSProgress * _Nonnull uploadProgress) {
                            
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            NSDictionary *dic_name = responseObject;
                            InterfaceStatusModel *infoModel = [InterfaceStatusModel yy_modelWithJSON:dic_name];
                            handler(dic_name,infoModel);
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            NSLog(@"请求网址:%@",url);
                            [FTIndicator showErrorWithMessage:strNetError];
                            handler(nil,nil);
                            [[NSNotificationCenter defaultCenter]postNotificationName:Noti_UITableView_InterfaceStatus_Change object:nil];
                        }];
                        break;
                    }
                    case AVAssetExportSessionStatusFailed:
                        NSLog(@"AVAssetExportSessionStatusFailed");
                        break;
                }
            }];
        }
    }
}
@end
