//
//  NSObject+Extension.m
//  BocoVideoPlatform
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 BOCO. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)
-(NSArray *)allProperty
{
    NSMutableArray *props = [NSMutableArray new];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithFormat:@"%s",property_getName(property)];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}
@end
