//
//  GCBaseImageTitleCellModel.h
//  UVTao
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "GCBaseCellModel.h"
@interface GCBaseImageTitleCellModel : GCBaseCellModel
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) NSString *title;
-(instancetype)initWithImage:(NSString *)image title:(NSString *)title action:(NSString *)action;
@end
