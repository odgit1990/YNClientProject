//
//  GCBaseEditCellViewModel.m
//  GYDemo
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseEditCellViewModel.h"
#import "Head.h"

@implementation GCBaseEditCellViewModel
#pragma mark - getter and setter
-(BOOL)canEdit
{
    
    if (_isSpecialView) {
        _canEdit = NO;
    }else{
        if (_tapAction.length > 0) {
            _canEdit = NO;
        }else{
            _canEdit = YES;
        }
    }
    return _canEdit;
}
-(NSString *)placeholder
{
    if (_isSpecialView) {
        
    }else{
        if (self.canEdit) {
            if (!_placeholder) {
                _placeholder = [NSString stringWithFormat:@"请输入%@",_title];
            }
        }
    }
    return _placeholder;
}
-(CGFloat)cellheight
{
    if (_cellheight <= 0) {
        _cellheight = WFCGFloatY(45);
    }
    if (self.isSpecialView) {
        _cellheight = self.specialView.height;
    }
    return _cellheight;
}
#pragma mark - life
-(instancetype)init
{
    if (self = [super init]) {
        _necessary = YES;
        _inputType = UIKeyboardTypeDefault;
        _canExpandable = NO;
    }
    return self;
}
@end
