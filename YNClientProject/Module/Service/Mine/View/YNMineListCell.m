//
//  YNMineListCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNMineListCell.h"

#import "Head.h"
@interface YNMineListCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UIImageView* markIV;
@end

@implementation YNMineListCell
#pragma mark - getter and setter
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(42);
        _titleLab.y=WFCGFloatY(0);
        _titleLab.width=WFCGFloatX(240);
        _titleLab.height=WFCGFloatY(51);
        _titleLab.textColor=HEXCOLOR(@"#444444");
        _titleLab.font=SYSTEMFONT(16);
    }
    return _titleLab;
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
