//
//  YNPswVIew.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/24.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNPswVIew.h"
#import "Head.h"
@interface YNPswVIew ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView* lineIV;
@property(nonatomic,strong)UIButton* showBtn;
@end

@implementation YNPswVIew
-(UIButton *)showBtn
{
    @WeakSelf;
    if (!_showBtn) {
        _showBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image=[UIImage imageNamed:@"psw_show"];
        UIImage* image1=[UIImage imageNamed:@"psw_no_show"];
        [_showBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_showBtn setBackgroundImage:image1 forState:UIControlStateSelected];
        _showBtn.width=image.size.width;
        _showBtn.height=image.size.height;
        _showBtn.x=WFCGFloatX(280+40);
        _showBtn.y=(WFCGFloatY(40)-_showBtn.height)/2;
        [_showBtn setEnlargeEdge:15];
        [_showBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            selfp.showBtn.selected=!selfp.showBtn.selected;
            selfp.inptTF.secureTextEntry=!selfp.showBtn.selected;
        }];
        
    }
    return _showBtn;
}
-(UIImageView *)lineIV
{
    if (!_lineIV) {
        _lineIV=[[UIImageView alloc] init];
        _lineIV.width=WFCGFloatX(303);
        _lineIV.height=1;
        _lineIV.x=WFCGFloatX(36);
        _lineIV.y=WFCGFloatY(39);
        _lineIV.backgroundColor=HEXCOLOR(@"#EDEDED");
        
    }
    return _lineIV;
}

-(UITextField *)inptTF
{
    if (!_inptTF)
    {
        _inptTF = [[UITextField alloc]init];
        _inptTF.frame = WFCGRectMake(36, 0, 303-30, 40);
        _inptTF.font = SYSTEMFONT(12);
        _inptTF.textColor = Main_Color_Black;
        _inptTF.clearButtonMode=UITextFieldViewModeWhileEditing;
        _inptTF.delegate = self;
        _inptTF.secureTextEntry=YES;
    }
    return _inptTF;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        
        [self addSubview:self.inptTF];
        [self addSubview:self.lineIV];
        [self addSubview:self.showBtn];

    }
    return self;
}

@end
