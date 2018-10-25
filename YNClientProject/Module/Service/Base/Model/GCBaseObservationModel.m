//
//  GCBaseObservationModel.m
//  GYDemo
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseObservationModel.h"

@implementation GCBaseObservationModel
#pragma mark - getter and setter
-(void)removeFrom:(NSObject *)observer
{
    [_observation removeObserver:observer forKeyPath:_keyPath];
}
@end
