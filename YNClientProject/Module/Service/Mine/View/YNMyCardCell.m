//
//  YNMyCardCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/24.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNMyCardCell.h"

#import "Head.h"
@interface YNMyCardCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UILabel* orderNoLabel;
@property(nonatomic,strong)UILabel* NoLabel;
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UIImageView* backIV;
@end

@implementation YNMyCardCell
#pragma mark - getter and setter
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(65);
        _titleLab.y=WFCGFloatY(25);
        _titleLab.width=WFCGFloatX(150);
        _titleLab.height=WFCGFloatY(16);
        _titleLab.textColor=[UIColor whiteColor];;
        _titleLab.font=SYSTEMFONT(16);
    }
    return _titleLab;
}
-(UILabel *)orderNoLabel
{
    if (!_orderNoLabel) {
        _orderNoLabel=[UILabel new];
        _orderNoLabel.x=WFCGFloatX(65);
        _orderNoLabel.y=WFCGFloatY(46);
        _orderNoLabel.width=WFCGFloatX(200);
        _orderNoLabel.height=WFCGFloatY(13);
        _orderNoLabel.textColor=[UIColor whiteColor];
        _orderNoLabel.font=SYSTEMFONT(13);
    }
    return _orderNoLabel;
}
-(UILabel *)NoLabel
{
    if (!_NoLabel) {
        _NoLabel=[UILabel new];
        _NoLabel.x=WFCGFloatX(65);
        _NoLabel.y=WFCGFloatY(81);
        _NoLabel.width=WFCGFloatX(250);
        _NoLabel.height=WFCGFloatY(17);
        _NoLabel.textColor=[UIColor whiteColor];
        _NoLabel.font=SYSTEMFONT(17);
    }
    return _NoLabel;
}

-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        _markIV.width=WFCGFloatY(38);
        _markIV.height=WFCGFloatY(38);
        _markIV.x=WFCGFloatX(20);
        _markIV.y=WFCGFloatY(24);
    }
    return _markIV;
}
-(UIImageView *)backIV
{
    if (!_backIV) {
        _backIV=[UIImageView new];
        _backIV.width=WFCGFloatY(335);
        _backIV.height=WFCGFloatY(131);
        _backIV.x=WFCGFloatX(20);
        _backIV.y=WFCGFloatY(15);
    }
    return _backIV;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = Main_Color_White;
        [self.contentView addSubview:self.backIV];
        [self.backIV addSubview:self.titleLab];
        [self.backIV addSubview:self.markIV];
        [self.backIV addSubview:self.orderNoLabel];
        [self.backIV addSubview:self.NoLabel];
        
    }
    return self;
}
-(void)settitle:(NSString *)title iamge:(NSString *)image
{
    _markIV.image=[UIImage imageNamed:image];
    
    _titleLab.text=title;
}
@end
