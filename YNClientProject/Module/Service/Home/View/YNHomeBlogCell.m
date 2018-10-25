//
//  YNHomeBlogCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHomeBlogCell.h"
#import "Head.h"
@interface YNHomeBlogCell ()
@property(nonatomic,strong)UIView* backView;
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UILabel* titleLab;
@end

@implementation YNHomeBlogCell
#pragma mark - getter and setter
-(UIView *)backView
{
    if (!_backView) {
        _backView=[UIView new];
        _backView.x=0;
        _backView.y=0;
        _backView.width=0;
        _backView.height=0;
        
    }
    return _backView;
}
-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        _markIV.x=WFCGFloatX(6);
        _markIV.y=WFCGFloatY(7);
        _markIV.width=_backView.width-WFCGFloatX(12);
        _markIV.height=_markIV.width;
    }
    return _markIV;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=0;
        _titleLab.y=0;
        _titleLab.width=0;
        _titleLab.height=0;
        _titleLab.font=SYSTEMFONT(16);
        _titleLab.textColor=YN_Light_Black_Color;
    }
    return _titleLab;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = Main_Color_White;
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.markIV];
        [self.backView addSubview:self.titleLab];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - delegate
@end
