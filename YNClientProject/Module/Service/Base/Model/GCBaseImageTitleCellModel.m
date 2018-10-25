//
//  GCBaseImageTitleCellModel.m
//  UVTao
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseImageTitleCellModel.h"
#import "Head.h"

@implementation GCBaseImageTitleCellModel
-(instancetype)initWithImage:(NSString *)image title:(NSString *)title action:(NSString *)action
{
    if (self = [super init]) {
        _height = WFCGFloatY(45);
        _imageName = image;
        _title = title;
        self.action = action;
    }
    return self;
}
@end
