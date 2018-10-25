//
//  YNGetMoneyCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/24.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNGetMoneyCell.h"
#import "Head.h"
@interface YNGetMoneyCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UILabel* orderNoLabel;
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UIImageView* chooseIV;
@end

@implementation YNGetMoneyCell
#pragma mark - getter and setter
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(65);
        _titleLab.y=WFCGFloatY(10);
        _titleLab.width=WFCGFloatX(150);
        _titleLab.height=WFCGFloatY(15);
        _titleLab.textColor=HEXCOLOR(@"#333333");
        _titleLab.font=SYSTEMFONT(15);
    }
    return _titleLab;
}
-(UILabel *)orderNoLabel
{
    if (!_orderNoLabel) {
        _orderNoLabel=[UILabel new];
        _orderNoLabel.x=WFCGFloatX(65);
        _orderNoLabel.y=WFCGFloatY(31);
        _orderNoLabel.width=WFCGFloatX(200);
        _orderNoLabel.height=WFCGFloatY(15);
        _orderNoLabel.textColor=HEXCOLOR(@"#666666");
        _orderNoLabel.font=SYSTEMFONT(15);
    }
    return _orderNoLabel;
}

-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        _markIV.width=WFCGFloatY(38);
        _markIV.height=WFCGFloatY(38);
        _markIV.x=WFCGFloatX(15);
        _markIV.y=WFCGFloatY(8);
    }
    return _markIV;
}
-(UIImageView *)chooseIV
{
    if (!_chooseIV) {
        _chooseIV=[UIImageView new];
        _chooseIV.width=WFCGFloatY(14);
        _chooseIV.height=WFCGFloatY(10);
        _chooseIV.x=WFCGFloatX(15);
        _chooseIV.y=WFCGFloatY(350);
    }
    return _chooseIV;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = Main_Color_White;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.markIV];
        [self.contentView addSubview:self.orderNoLabel];
        
    }
    return self;
}
-(void)settitle:(NSString *)title iamge:(NSString *)image
{
    _markIV.image=[UIImage imageNamed:image];

    _titleLab.text=title;
}

@end
