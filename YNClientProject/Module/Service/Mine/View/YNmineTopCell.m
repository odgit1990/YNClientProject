//
//  YNmineTopCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNmineTopCell.h"

#import "Head.h"
@interface YNmineTopCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UIImageView* autLab;

@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UIImageView* backIV;
@end

@implementation YNmineTopCell
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(92);
        _titleLab.y=WFCGFloatY(47);
        _titleLab.width=WFCGFloatX(240);
        _titleLab.height=WFCGFloatY(52);
        _titleLab.textColor=YN_Light_Black_Color;
        _titleLab.font=SYSTEMFONT(18);
        _titleLab.text=@"登录/注册";
    }
    return _titleLab;
}

-(UIImageView *)autLab
{
    if (!_autLab) {
        _autLab=[UIImageView new];
        _autLab.image=[UIImage imageNamed:@"mine_no_auth"];
        _autLab.width=_autLab.image.size.width;
        _autLab.height=_autLab.image.size.height;
        _autLab.x=SCREEN_WIDTH-_autLab.width;
        _autLab.y=WFCGFloatY(73);
    }
    return _autLab;
}

-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        _markIV.width=WFCGFloatY(52);
        _markIV.height=WFCGFloatY(52);
        _markIV.x=WFCGFloatX(26);
        _markIV.y=WFCGFloatY(47);
        _markIV.image=DefaultAvatarFImage;
        [WFFunctions WFUIaddbordertoView:_markIV radius:WFCGFloatY(26) width:0 color:[UIColor clearColor]];
    }
    return _markIV;
}
-(UIImageView *)backIV
{
    if (!_backIV) {
        _backIV=[UIImageView new];
        _backIV.width=SCREEN_WIDTH;
        _backIV.height=WFCGFloatY(194);
        _backIV.x=WFCGFloatX(0);
        _backIV.y=WFCGFloatY(0);
        _backIV.image=[UIImage imageNamed:@"mine_bg"];
    }
    return _backIV;
}
#pragma mark - event
#pragma mark - method
-(void)setModel:(YNMineInfoModel *)model
{
    
}
#pragma mark - life
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = Main_Color_White;
        [self.contentView addSubview:self.backIV];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.autLab];
        [self.contentView addSubview:self.markIV];
        
    }
    return self;
}


@end
