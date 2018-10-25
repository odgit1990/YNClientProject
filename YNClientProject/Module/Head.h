//
//  Head.h
//  GYDemo
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#ifndef GCHead_h
#define GCHead_h

//库
#import "Library.h"
//业务
#import "Service.h"
//接口
#import "InterfaceManager.h"

#pragma mark - theme
//#define Main_Color_Red                   HEXCOLOR(@"#CD0000")
#define Main_Color_Green                 HEXCOLOR(@"#00cccc")
#define Main_Color_Blue                  HEXCOLOR(@"#1d96d5")
#define Main_Color_DeepBlue              HEXCOLOR(@"#0e7ae6")
//#define Main_Color_Gray                  HEXCOLOR(@"#666666")
//#define Main_Color_LightGray             HEXCOLOR(@"#999999")
//#define Main_Color_Black                 HEXCOLOR(@"#333333")
#define Main_Color_White                 HEXCOLOR(@"#FFFFFF")
#define Main_Color_Orange                HEXCOLOR(@"#EC8D24")
#define Main_Color_Gold                  HEXCOLOR(@"#ffdb06")
#define Main_Font_Color_Gold                  HEXCOLOR(@"#e9c257")

#define Main_Color_Red                   RGBACOLOR(184,26,8,1)
#define Main_Color_LightRed              RGBACOLOR(184,26,8,0.5)

#define Main_Color_Black                 RGBACOLOR(51,51,51,1)
#define Main_Color_LightBlack            RGBACOLOR(74,74,74,1)
#define Main_Color_Gray                  RGBACOLOR(102,102,102,1)
#define Main_Color_LightGray             RGBACOLOR(153,153,153,1)
#define Main_Color_BGLightGray           RGBACOLOR(247,247,247,1)
#define Main_Color_Yellow                RGBACOLOR(245,166,35,1)

#define Main_Color                       Main_Color_Blue

#define Main_Color_BG                    HEXCOLOR(@"#f4f4f4")



#define YN_Main_Color_Nav_BG                    HEXCOLOR(@"#f9f9f9")

#define YN_Main_Color_BG                        HEXCOLOR(@"#f1f1f1")
#define YN_Main_Line_BG                         HEXCOLOR(@"#cccccc")

#define YN_Black_Color                          HEXCOLOR(@"#171717")
#define YN_Light_Black_Color                    HEXCOLOR(@"#333333")
#define YN_Gray_Color                           HEXCOLOR(@"#666666")
#define YN_Light_Gray_Color                     HEXCOLOR(@"#999999")
#define YN_Light_L_Color                        HEXCOLOR(@"#cccccc")

#define YN_Light_Red_Color                       HEXCOLOR(@"#ff7890")

#pragma mark - 关键字
/** 获取APP名称 */
#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

/** 程序版本号 */
#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/** 获取APP build版本 */
#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

/** User-Agent */
#define APP_USER_AGENT [NSString stringWithFormat:@"石虎/%@ (%@;U;%@ %@;%@/%@)", \
APP_VERSION, DeviceModel, DeviceSystemName, DeviceVersion, DeviceLocal, DeviceLang]


#define kLoginUsername                   @"username"
#define kLoginPsw                        @"psw"
///首次打开app标识
#define kHasAppOpened                    @"hasAppOpened"

#define CC_MD5_key @"SeOD44Gm"
//首页banner图片的后缀
#define kBannerImgSuffix                          @"@!banner"
//营业执照
#define kBusinesslicenseImgSuffix                 @"@!s2"
//身份证
#define kIdCardImgSuffix                          @"@!sfz"
//商品缩略图
#define kProductImgThumbnailSuffix                @"@!s1"
//商品原图
#define kProductImgOriginSuffix                   @"@!yt"

//阿里云bucketname测试环境
#define kBucketNameTest                           @"geyou-test"
//阿里云bucketname正式环境
#define kBucketName                               @"geyou"
//阿里云测试地址
#define kAliUrlTest                               @"res2.geyoumall.com"
//阿里云正式地址
#define kAliUrl                                   @"res1.geyoumall.com"
//阿里云图片目录--执照
#define kIdCard                                   @"idcard"
//阿里云图片目录--产品
#define kProduct                                  @"product"

//部分web url
#define GYWebUrl                                  @"http://www.geyoumall.com/news/mobile/"
#define GYTestWebUrl                               @"http://192.168.4.113:3000/news/mobile/"

//默认图

#define DefaultImage                              [UIImage imageNamed:@"default_goods"]
#define DefaultAvatarFImage                        [UIImage imageNamed:@"mine_deault_av_w"]
#define DefaultAvatarMImage                        [UIImage imageNamed:@"mine_deault_av_m"]
#endif /* GCHead_h */
