//
//  GCAdaptLabel.h
//  GYDemo
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GCAdaptLabelDelegate
-(void)callback:(id)sender;
@end

typedef void(^GCAdaptLabelHandler)(NSDictionary *info);

@interface GCAdaptLabel : UILabel
@property (nonatomic,weak) id<GCAdaptLabelDelegate> delegate;
///设置极限宽度
-(instancetype)initWithMaxWidth:(CGFloat)width;
@end
