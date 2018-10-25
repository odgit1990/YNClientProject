//
//  TNHomeMainItemView.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "TNHomeMainItemView.h"
#import "Head.h"
@interface TNHomeMainItemView ()
@property(nonatomic,strong)UIImageView* logIV;
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UILabel* detailLab;
@end

@implementation TNHomeMainItemView
#pragma mark - getter and setter
-(UIImageView *)logIV
{
    if (!_logIV) {
        _logIV=[UIImageView new];
        _logIV.x=WFCGFloatX(12);
        _logIV.y=WFCGFloatY(25);
        _logIV.width=WFCGFloatY(40);
        _logIV.height=WFCGFloatY(40);
        [WFFunctions WFUIaddbordertoView:_logIV radius:WFCGFloatY(20) width:0 color:[UIColor clearColor]];
    }
    return _logIV;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(58);
        _titleLab.y=WFCGFloatY(26);
        _titleLab.width=self.width-WFCGFloatX(60);
        _titleLab.height=WFCGFloatY(17);
        _titleLab.textColor=[UIColor whiteColor];
        _titleLab.font=SYSTEMFONT(17);
        
    }
    return _titleLab;
}
-(UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab=[UILabel new];
        _detailLab.x=WFCGFloatX(58);
        _detailLab.y=WFCGFloatY(52);
        _detailLab.width=self.width-WFCGFloatX(78);
        _detailLab.numberOfLines=2;
        _detailLab.textColor=[UIColor whiteColor];
        _detailLab.font=SYSTEMFONT(12);
        
    }
    return _detailLab;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithFrame:(CGRect)frame withPara:(NSMutableDictionary*)para index:(NSInteger)index
{
    if (self = [super initWithFrame:frame])
    {
        self.image=[UIImage imageNamed:[NSString stringWithFormat:@"home_maibg_%ld",index]];
        [self addSubview:self.logIV];
        [self addSubview:self.titleLab];
        [self addSubview:self.detailLab];
        _titleLab.text=[para objectForKey:@"title"];
        _detailLab.text=[para objectForKey:@"description"];
        CGSize tem=[WFFunctions WFStrGetSize:_detailLab.text width:self.width-WFCGFloatX(78) font:SYSTEMFONT(12)];
        _detailLab.height=tem.height;
        [_logIV sd_setImageWithURL:[NSURL URLWithString:[WFFunctions WFCheckEmptyBackStr:[para objectForKey:@"logo"]]] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_mai_%ld",index]]];
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
