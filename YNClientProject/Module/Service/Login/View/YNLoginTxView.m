//
//  YNLoginTxView.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/24.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNLoginTxView.h"

@interface YNLoginTxView ()<UITextFieldDelegate>

@end

@implementation YNLoginTxView
#pragma mark - getter and setter
-(UIImageView *)lineIV
{
    if (!_lineIV) {
        _lineIV=[[UIImageView alloc] init];
        _lineIV.width=WFCGFloatX(375-16);
        _lineIV.height=1;
        _lineIV.x=WFCGFloatX(8);
        _lineIV.y=WFCGFloatY(52);
        _lineIV.backgroundColor=HEXCOLOR(@"#EDEDED");
        
    }
    return _lineIV;
}
-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[[UIImageView alloc] init];
        _markIV.x=WFCGFloatX(38);
        
    }
    return _markIV;
}
-(UITextField *)phoneTF
{
    if (!_phoneTF)
    {
        _phoneTF = [[UITextField alloc]init];
        _phoneTF.frame = WFCGRectMake(76, 0, 280, 53);
        _phoneTF.font = SYSTEMFONT(15);
        _phoneTF.textColor = Main_Color_Black;
        _phoneTF.keyboardType=UIKeyboardTypePhonePad;
        _phoneTF.clearButtonMode=UITextFieldViewModeWhileEditing;
        _phoneTF.delegate = self;
    }
    return _phoneTF;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithFrame:(CGRect)frame image:(NSString*)image type:(NSInteger)type
{
    if (self=[super initWithFrame:frame])
    {
        
        [self addSubview:self.phoneTF];
        [self addSubview:self.markIV];
        [self addSubview:self.lineIV];
        _markIV.image=[UIImage imageNamed:image];
        _markIV.width=_markIV.image.size.width;
        _markIV.height=_markIV.image.size.height;
        _markIV.y=(WFCGFloatY(53)-_markIV.height)/2;
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
#pragma mark - delegate
@end
