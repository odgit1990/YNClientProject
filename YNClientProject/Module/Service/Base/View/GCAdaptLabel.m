//
//  GCAdaptLabel.m
//  GYDemo
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCAdaptLabel.h"
#import "WFFunctions.h"
#import "Library.h"

@interface GCAdaptLabel()
{
    CGFloat _maxWidth;
}
@end

@implementation GCAdaptLabel
#pragma mark - getter and setter
-(void)setText:(NSString *)text
{
    [super setText:text];
    UIFont *font = self.font;
    kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
        CGSize size = [WFFunctions WFStrGetSize:text width:MAXFLOAT font:font];
        CGFloat width = size.width > _maxWidth ? _maxWidth : size.width;
        kDISPATCH_MAIN_THREAD(^{
//            [self performSelectorOnMainThread:@selector(setWidth:) withObject:@(width) waitUntilDone:YES];
//            [self performSelectorOnMainThread:@selector(setHidden:) withObject:@(NO) waitUntilDone:YES];
            self.width = width;
            self.hidden = NO;
            [_delegate callback:self];
        });
    });
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    kDISPATCH_GLOBAL_QUEUE_DEFAULT(^{
        CGSize size = [WFFunctions WFStrGetSize:attributedText width:MAXFLOAT].size;
        CGFloat width = size.width > _maxWidth ? _maxWidth : size.width;
        kDISPATCH_MAIN_THREAD(^{
//            [self performSelectorOnMainThread:@selector(setWidth:) withObject:@(width) waitUntilDone:YES];
//            [self performSelectorOnMainThread:@selector(setHidden:) withObject:@(NO) waitUntilDone:YES];
            self.width = width;
            self.hidden = NO;
            [_delegate callback:self];
        });
    });
}
#pragma mark - method
-(void)setMaxWidth:(CGFloat)maxWidth
{
    _maxWidth = maxWidth;
}
#pragma mark - life
-(instancetype)initWithMaxWidth:(CGFloat)width
{
    if (self = [super init]) {
        _maxWidth = width;
        self.hidden = YES;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
