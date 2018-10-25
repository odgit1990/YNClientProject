//
//  YNHealthDocNewCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHealthDocNewCell.h"
#import "Head.h"
@interface YNHealthDocNewCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UILabel* moreLab;
@property(nonatomic,strong)UILabel* autLab;
@property(nonatomic,strong)UILabel* timeLab;
@property(nonatomic,strong)UIImageView* markIV;
@end

@implementation YNHealthDocNewCell
#pragma mark - getter and setter
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(26);
        _titleLab.y=WFCGFloatY(18);
        _titleLab.width=WFCGFloatX(200);
        _titleLab.height=WFCGFloatY(16);
        _titleLab.textColor=YN_Light_Black_Color;
        _titleLab.font=SYSTEMFONT(16);
        _titleLab.numberOfLines=2;
    }
    return _titleLab;
}
-(UILabel *)moreLab
{
    if (!_moreLab) {
        _moreLab=[UILabel new];
        
        _moreLab.y=WFCGFloatY(65);
        _moreLab.width=WFCGFloatX(200);
        _moreLab.textColor=YN_Gray_Color;
        _moreLab.height=WFCGFloatY(16);
        _moreLab.x=WFCGFloatX(26);
        _moreLab.font=SYSTEMFONT(16);
        
    }
    return _moreLab;
}

-(UILabel *)autLab
{
    if (!_autLab) {
        _autLab=[UILabel new];
        _autLab.x=WFCGFloatX(26);
        _autLab.y=WFCGFloatY(105);
        _autLab.width=WFCGFloatX(80);
        _autLab.height=WFCGFloatY(12);
        _autLab.textColor=YN_Light_Gray_Color;
        _autLab.font=SYSTEMFONT(12);
        
    }
    return _autLab;
}
-(UILabel *)timeLab
{
    if (!_timeLab) {
        _timeLab=[UILabel new];
        
        _timeLab.y=WFCGFloatY(106);
        _timeLab.width=WFCGFloatX(130);
        _timeLab.textColor=YN_Light_Gray_Color;
        _timeLab.height=WFCGFloatY(12);
        _timeLab.x=WFCGFloatX(110);
        _timeLab.font=SYSTEMFONT(11);
        
    }
    return _timeLab;
}
-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        _markIV.width=WFCGFloatX(123);
        _markIV.height=WFCGFloatY(100);
        _markIV.x=WFCGFloatX(236);
        _markIV.y=WFCGFloatY(17);
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
        [self.contentView addSubview:self.autLab];
        [self.contentView addSubview:self.timeLab];
        [self.contentView addSubview:self.markIV];
        
    }
    return self;
}
-(void)setModel:(YNHealthNewSModel *)model
{
    _titleLab.text=model.posts_title;
    _moreLab.text=model.posts_desc;
    _autLab.text=[NSString stringWithFormat:@"作者:%@",[WFFunctions WFCheckEmptyBackStr:model.posts_author]];
    _timeLab.text=[WFFunctions WFCheckEmptyBackStr:[WFFunctions WFCheckEmptyBackStr:model.posts_date]];
    [_markIV sd_setImageWithURL:[NSURL URLWithString:[WFFunctions WFCheckEmptyBackStr:model.posts_thumbnail]] placeholderImage:DefaultImage];
    
    
    CGSize temsize=[WFFunctions WFStrGetSize:_titleLab.text width:WFCGFloatX(200) font:SYSTEMFONT(16)];
    _titleLab.height=temsize.height;
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
