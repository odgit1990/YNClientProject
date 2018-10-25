//
//  YNHomeSectionView.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHomeSectionView.h"
#import "Head.h"
@interface YNHomeSectionView ()
@property(nonatomic,strong)UIImageView* leftIV;
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UILabel* moreLab;
@property(nonatomic,strong)UIImageView* markIV;
@end

@implementation YNHomeSectionView
#pragma mark - getter and setter
-(UIImageView *)leftIV
{
    if (!_leftIV) {
        _leftIV=[UIImageView new];
        _leftIV.x=WFCGFloatX(14);
        _leftIV.y=WFCGFloatY(10);
        _leftIV.width=WFCGFloatX(3);
        _leftIV.height=WFCGFloatY(20);
        _leftIV.backgroundColor=Main_Color_Gold;
    }
    return _leftIV;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(26);
        _titleLab.y=WFCGFloatY(0);
        _titleLab.width=WFCGFloatX(200);
        _titleLab.height=WFCGFloatY(41);
        _titleLab.textColor=YN_Light_Black_Color;
        _titleLab.font=SYSTEMFONT(18);
        
    }
    return _titleLab;
}
-(UILabel *)moreLab
{
    if (!_moreLab) {
        _moreLab=[UILabel new];
        
        _moreLab.y=WFCGFloatY(0);
        _moreLab.width=WFCGFloatX(100);
        _moreLab.textColor=YN_Light_Black_Color;
        _moreLab.height=WFCGFloatY(41);
        _moreLab.x=self.width-WFCGFloatX(130);
        _moreLab.font=SYSTEMFONT(16);
        _moreLab.text=@"更多";
        _moreLab.textAlignment=NSTextAlignmentRight;
        
    }
    return _moreLab;
}
-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];

        _markIV.image=[UIImage imageNamed:@"home_right_mark"];
        _markIV.width=_markIV.image.size.width;
        _markIV.height=_markIV.image.size.height;
        _markIV.x=SCREEN_WIDTH-_markIV.width-WFCGFloatX(20);
        _markIV.y=(WFCGFloatY(41)-_markIV.height)/2;
    }
    return _markIV;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life-
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString* )title
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.leftIV];
        [self addSubview:self.titleLab];
        [self addSubview:self.markIV];
        [self addSubview:self.moreLab];
        _titleLab.text=title;
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
