//
//  Macro.h
//  CBHGroupCar
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

///系统版本
#define OS_VERSION                              [[[UIDevice currentDevice] systemVersion] floatValue]

///自定义log
#define NSLog(FORMAT, ...)                      printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

///系统font
#define SYSTEMFONT(fon)                         [UIFont systemFontOfSize:fon withScale:autoSizeScaleY]
#define SYSTEMBOLDFONT(fon)                     [UIFont boldSystemFontOfSize:fon withScale:autoSizeScaleY]
#define SYSTEMNAMEFONT(name,fon)                [UIFont nameFont:name size:fon withScale:autoSizeScaleY]
///网络返回安全转换dic
#define EncodeFormDic(dic,key)                  [dic[key] isKindOfClass:[NSString class]] ? dic[key] :([dic[key] isKindOfClass:[NSNumber class]] ? [dic[key] stringValue]:@"")
///若引用
#define WeakObj(o)                              autoreleasepool{} __weak __block typeof(o) o##p = o;
#define WeakSelf                                WeakObj(self)
///16进制颜色
#define HEXCOLOR(str)                           [WFFunctions WFColorWithHexString:str alpha:1]
#define HEXCOLORALPHA(str,alp)                  [WFFunctions WFColorWithHexString:str alpha:alp]
#define UIColorFromHEX(rgbValue)                [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
///三基色
#define RGBACOLOR(r,g,b,a)                      [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

///GCD 的宏定义
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock)         static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock)   dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);

///判断模拟器环境
#if TARGET_IPHONE_SIMULATOR
#define SIMULATOR 1
#elif TARGET_OS_IPHONE
#define SIMULATOR 0
#endif
///全屏幕的高度
#define WF_SCREEN_HEIGHT                        [[UIScreen mainScreen]bounds].size.height
///全屏幕的宽度
#define WF_SCREEN_WIDTH                         [[UIScreen mainScreen]bounds].size.width
///是不是iPhone X系列机型
#define isiPhoneX ([[NSString stringWithFormat:@"%.2f",(WF_SCREEN_WIDTH / WF_SCREEN_HEIGHT)] isEqualToString:@"0.46"] ? YES : NO)
///安全区域导航条高度差
#define WF_NAVIGATION_SAFE_OFFSET               (isiPhoneX ? 20 : 0)
///安全区域选项卡高度差
#define WF_TAB_SAFE_OFFSET                      (isiPhoneX ? 34 : 0)
///导航条高度（包含iPhone X）
#define WF_NAVIGATION_BAR_HEIGHT                64
///tabbar高度（包含iPhone X）
#define WF_TAB_BAR_HEIGHT                       49

///带navigationbar View 的高度
#define WF_UI_VIEW_HEIGHT                       (WF_SCREEN_HEIGHT - WF_NAVIGATION_BAR_HEIGHT - WF_NAVIGATION_SAFE_OFFSET)

#pragma mark - 按照iPhone 6的屏幕尺寸，等比缩放的适配方
#define WH_Ration                               (CGFloat)(667.0f / 375.0f)
#define Ration_Height                           (CGFloat)(WF_SCREEN_WIDTH * WH_Ration)
#define autoSizeScaleX                          (CGFloat)WF_SCREEN_WIDTH / 375.0f
#define autoSizeScaleY                          (isiPhoneX ? (CGFloat)Ration_Height : (CGFloat)WF_SCREEN_HEIGHT) / 667.0f

CG_INLINE CGFloat
WFCGFloatX(CGFloat num) {
    CGFloat scalex = autoSizeScaleX;
    CGFloat xnum = num * scalex;
    return xnum;
}

CG_INLINE CGFloat
WFCGFloatBackX(CGFloat num) {
    CGFloat scalex = autoSizeScaleX;
    CGFloat xnum = num / scalex;
    return xnum;
}

CG_INLINE CGFloat
WFCGFloatY(CGFloat num) {
    CGFloat scaley = autoSizeScaleY;
    CGFloat ynum = num * scaley;
    return ynum;
}

CG_INLINE CGFloat
WFCGFloatBackY(CGFloat num) {
    CGFloat scaley = autoSizeScaleY;
    CGFloat ynum = num / scaley;
    return ynum;
}

CG_INLINE CGSize
WFCGSizeMake(CGFloat width, CGFloat height)
{
    CGSize size;
    CGFloat scalex = autoSizeScaleX;
    CGFloat scaley = autoSizeScaleY;
    CGFloat wwidth = width * scalex;
    CGFloat hheight = height * scaley;
    size = CGSizeMake(wwidth, hheight);
    return size;
}

CG_INLINE CGRect
WFCGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    CGFloat scalex = autoSizeScaleX;
    CGFloat scaley = autoSizeScaleY;
    CGFloat xx = x * scalex;
    CGFloat yy = y * scaley;
    CGFloat wwidth = width * scalex;
    CGFloat hheight = height * scaley;
    rect = CGRectMake(xx, yy, wwidth, hheight);
    return rect;
}
CG_INLINE CGPoint
WFCGPointMake(CGFloat x, CGFloat y)
{
    CGPoint point;
    CGFloat scalex = autoSizeScaleX;
    CGFloat scaley = autoSizeScaleY;
    CGFloat xx = x * scalex;
    CGFloat yy = y * scaley;
    point = CGPointMake(xx, yy);
    return point;
}

#endif /* Macro_h */
