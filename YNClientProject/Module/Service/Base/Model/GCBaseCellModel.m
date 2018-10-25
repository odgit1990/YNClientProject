//
//  GCBaseCellModel.m
//  UVTao
//
//  Created by mac on 2018/8/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseCellModel.h"
#import "Head.h"
@implementation GCBaseCellModel
-(CGFloat)cellheight
{
    if (_cellheight <= 0) {
        _cellheight = WFCGFloatY(45);
    }
    return _cellheight;
}

@end
