//
//  GCBaseObservationModel.h
//  GYDemo
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GCBaseObservationModelHander)(NSString *keyPath);

@interface GCBaseObservationModel : NSObject
@property (nonatomic,strong) NSObject *observation;
@property (nonatomic,strong) NSString *keyPath;
@property (nonatomic,copy) GCBaseObservationModelHander handler;
-(void)removeFrom:(NSObject *)observer;
@end
