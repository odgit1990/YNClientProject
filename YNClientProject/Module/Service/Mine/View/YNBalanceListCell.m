//
//  YNBalanceListCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/24.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNBalanceListCell.h"

#import "Head.h"
@interface YNBalanceListCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UILabel* orderNoLabel;
@property(nonatomic,strong)UILabel* timeLab;
@property(nonatomic,strong)UILabel* moneyLab;
@property(nonatomic,strong)UIImageView* markIV;
@end

@implementation YNBalanceListCell
#pragma mark - getter and setter
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(46);
        _titleLab.y=WFCGFloatY(17);
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
        _orderNoLabel.x=WFCGFloatX(46);
        _orderNoLabel.y=WFCGFloatY(39);
        _orderNoLabel.width=WFCGFloatX(200);
        _orderNoLabel.height=WFCGFloatY(11);
        _orderNoLabel.textColor=HEXCOLOR(@"#333333");
        _orderNoLabel.font=SYSTEMFONT(10);
    }
    return _orderNoLabel;
}
-(UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        _timeLab.x=SCREEN_WIDTH-WFCGFloatX(90);
        _timeLab.y=WFCGFloatY(20);
        _timeLab.width=WFCGFloatX(80);
        _timeLab.height=WFCGFloatY(10);
        _timeLab.textColor=HEXCOLOR(@"#666666");
        _timeLab.font=SYSTEMFONT(10);
        _timeLab.textAlignment=NSTextAlignmentRight;
    }
    return _timeLab;
}
-(UILabel *)moneyLab
{
    if (!_moneyLab) {
        _moneyLab=[UILabel new];
        _moneyLab.x=SCREEN_WIDTH-WFCGFloatX(150);
        _moneyLab.y=WFCGFloatY(36);
        _moneyLab.width=WFCGFloatX(140);
        _moneyLab.height=WFCGFloatY(15);
        _moneyLab.textColor=HEXCOLOR(@"#333333");
        _moneyLab.font=SYSTEMFONT(15);
        _moneyLab.textAlignment=NSTextAlignmentRight;
    }
    return _moneyLab;
}

-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        
        
    }
    return _markIV;
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
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.moneyLab];
        
    }
    return self;
}
-(void)settitle:(NSString *)title iamge:(NSString *)image
{
    _markIV.image=[UIImage imageNamed:image];
    _markIV.width=_markIV.image.size.width;
    _markIV.height=_markIV.image.size.height;
    _markIV.x=WFCGFloatX(14);
    _markIV.y=(WFCGFloatY(51)-_markIV.height)/2;
    _titleLab.text=title;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
