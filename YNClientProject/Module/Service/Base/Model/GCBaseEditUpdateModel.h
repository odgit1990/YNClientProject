//
//  GCBaseEditUpdateModel.h
//  GYDemo
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCBaseEditUpdateModel : NSObject
-(void)setOtherInfo:(NSMutableDictionary *)info;
-(void)setTitleInfo:(NSDictionary *)info;
-(void)setMustKeys:(NSArray *)keys;
-(void)setAllKeys:(NSArray *)keys;
-(NSMutableDictionary *)exportParameter;
@end
