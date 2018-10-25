//
//  GCBaseEditUpdateModel.m
//  GYDemo
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseEditUpdateModel.h"
#import "Head.h"

@interface GCBaseEditUpdateModel()
{
    NSDictionary *titleInfo;
    NSArray *mustFillKeys;
    NSArray *allKeys;
    ///特殊不固定属性
    NSMutableDictionary *otherInfo;
}
@end

@implementation GCBaseEditUpdateModel
#pragma mark - getter and setter
#pragma mark - method
-(NSArray *)allKeys
{
    NSArray *allpro = self.allProperty;
    return allpro;
}
-(void)setOtherInfo:(NSMutableDictionary *)info
{
    otherInfo = info;
}
-(void)setTitleInfo:(NSDictionary *)info
{
    titleInfo = info;
}
-(void)setMustKeys:(NSArray *)keys
{
    mustFillKeys = keys;
}

-(void)setAllKeys:(NSArray *)keys
{
    allKeys = keys;
}

-(NSMutableDictionary *)exportParameter
{
    NSMutableDictionary *para = [[NSMutableDictionary alloc]initWithDictionary:otherInfo];
    for (NSString *key in [self allKeys]) {
        NSString *value = [self valueForKey:key] ?: @"";
        if ([mustFillKeys containsObject:key]) {
            if (!value || value.length <= 0) {
                NSLog(@"必选项校验");
                NSLog(@"key : %@ value : %@ class: %@",key,value,NSStringFromClass(value.class));
                para = nil;
                NSString *title = titleInfo[key];
                if (title) {
                    NSString *msg = [NSString stringWithFormat:@"请完善 %@ 信息！",title];
                    [FTIndicator showErrorWithMessage:msg];
                }
                break;
            }
        }
        NSString *keyy = key;
        if ([key containsString:@"Field"]) {
            keyy = [key stringByReplacingOccurrencesOfString:@"Field" withString:@""];
        }
        [para setObject:value forKey:keyy];
    }
    
    return para;
}

-(BOOL)isContainKey:(NSString *)key
{
    return [allKeys containsObject:key ?: @""];
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([self isContainKey:key]) {
        [super setValue:value forKey:key];
    }else{
        [otherInfo setValue:value forKey:key];
    }
}
#pragma mark - life
@end
