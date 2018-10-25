//
//  GCBaseCellModel.h
//  UVTao
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface GCBaseCellModel : NSObject
@property (nonatomic,strong) NSString *cellClass;
@property (nonatomic,strong) NSString *cellModelClass;
@property (nonatomic,strong) NSString *action;
@property (nonatomic,assign) CGFloat cellheight;
@property (nonatomic,assign) NSInteger cellAccessoryType;
@end
