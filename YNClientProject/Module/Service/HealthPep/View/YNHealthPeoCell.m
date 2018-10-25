//
//  YNHealthPeoCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHealthPeoCell.h"
#import "Head.h"
@interface YNHealthPeoCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UILabel* moreLab;
@property(nonatomic,strong)UILabel* priceLab;
@property(nonatomic,strong)UILabel* countLab;
@property(nonatomic,strong)UILabel* distanceLab;
@property(nonatomic,strong)UIImageView* markIV;
@end

@implementation YNHealthPeoCell
#pragma mark - getter and setter
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(147);
        _titleLab.y=WFCGFloatY(18);
        _titleLab.width=WFCGFloatX(210);
        _titleLab.height=WFCGFloatY(16);
        _titleLab.textColor=YN_Light_Black_Color;
        _titleLab.font=SYSTEMFONT(14);
        _titleLab.numberOfLines=2;
    }
    return _titleLab;
}
-(UILabel *)moreLab
{
    if (!_moreLab) {
        _moreLab=[UILabel new];
        
        _moreLab.y=WFCGFloatY(38);
        _moreLab.width=WFCGFloatX(186);
        _moreLab.textColor=HEXCOLOR(@"#999999");
        _moreLab.height=WFCGFloatY(26);
        _moreLab.x=WFCGFloatX(147);
        _moreLab.font=SYSTEMFONT(11);
        
    }
    return _moreLab;
}

-(UILabel *)priceLab
{
    if (!_priceLab) {
        _priceLab=[UILabel new];
        _priceLab.x=WFCGFloatX(147);
        _priceLab.y=WFCGFloatY(92);
        _priceLab.width=WFCGFloatX(60);
        _priceLab.height=WFCGFloatY(14);
        _priceLab.textColor=HEXCOLOR(@"#171717");
        _priceLab.font=SYSTEMFONT(18);
        
    }
    return _priceLab;
}
-(UILabel *)countLab
{
    if (!_countLab) {
        _countLab=[UILabel new];
        
        _countLab.y=WFCGFloatY(95);
        _countLab.width=WFCGFloatX(130);
        _countLab.textColor=HEXCOLOR(@"#999999");
        _countLab.height=WFCGFloatY(12);
        _countLab.x=WFCGFloatX(200);
        _countLab.font=SYSTEMFONT(10);
        
    }
    return _countLab;
}
-(UILabel *)distanceLab
{
    if (!_distanceLab) {
        _distanceLab=[UILabel new];
        
        _distanceLab.y=WFCGFloatY(97);
        _distanceLab.width=WFCGFloatX(50);
        _distanceLab.textColor=HEXCOLOR(@"#999999");
        _distanceLab.height=WFCGFloatY(12);
        _distanceLab.x=WFCGFloatX(305);
        _distanceLab.font=SYSTEMFONT(10);
        _distanceLab.textAlignment=NSTextAlignmentRight;
        
    }
    return _distanceLab;
}
-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        _markIV.x=WFCGFloatX(15);
        _markIV.y=WFCGFloatY(15);
        _markIV.width=WFCGFloatX(121);
        _markIV.height=WFCGFloatY(93);
        [WFFunctions WFUIaddbordertoView:_markIV radius:8 width:0 color:[UIColor clearColor]];
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
        [self.contentView addSubview:self.moreLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.countLab];
        [self.contentView addSubview:self.markIV];
        [self.contentView addSubview:self.distanceLab];
        
    }
    return self;
}
-(void)setModel:(YNDrugListModel *)model
{
    [_markIV sd_setImageWithURL:[NSURL URLWithString:model.pic_yaopin] placeholderImage:DefaultImage];
    _titleLab.text=model.title;
    _moreLab.text=model.remark;
    _priceLab.text=[NSString stringWithFormat:@"¥%@",model.price];
    _countLab.text=[NSString stringWithFormat:@"数量:%@",model.nums];
    CGSize priceSiez=[WFFunctions WFStrGetSize:_priceLab.text width:200 font:SYSTEMFONT(18)];
    _priceLab.width=priceSiez.width;
    _countLab.x=_priceLab.x+priceSiez.width+5;
   
    if ([model.distance integerValue]<500)
    {
         _distanceLab.text=@"<500m";
    }else if([model.distance integerValue]>100000)
    {
        _distanceLab.text=@">100km";
    }else
    {
        _distanceLab.text=[NSString stringWithFormat:@"%.2fkm",[model.distance floatValue]/1000];
    }
    
    
//    @property (nonatomic, strong) NSString * distance;
//    @property (nonatomic, strong) NSString * id;
//    @property (nonatomic, strong) NSString * nums;
//    @property (nonatomic, strong) NSString * pic_yaopin;
//    @property (nonatomic, strong) NSString * price;
//    @property (nonatomic, strong) NSString * remark;
//    @property (nonatomic, strong) NSString * title;
}
@end
