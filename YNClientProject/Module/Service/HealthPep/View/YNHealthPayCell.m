//
//  YNHealthPayCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHealthPayCell.h"

#import "Head.h"
@interface YNHealthPayCell ()
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UIImageView* chooseBtn;
@end

@implementation YNHealthPayCell
#pragma mark - getter and setter
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(72);
        _titleLab.y=WFCGFloatY(0);
        _titleLab.width=WFCGFloatX(150);
        _titleLab.height=WFCGFloatY(65);
        _titleLab.textColor=HEXCOLOR(@"#171717");
        _titleLab.font=SYSTEMFONT(15);
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
-(UIImageView *)chooseBtn
{
    if (!_chooseBtn) {
        _chooseBtn=[UIImageView new];
        _chooseBtn.x=WFCGFloatX(30);

        _chooseBtn.y=WFCGFloatY(0);
        _chooseBtn.width=WFCGFloatX(150);
        _chooseBtn.height=WFCGFloatY(65);
        
    }
    return _chooseBtn;
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
        [self.contentView addSubview:self.chooseBtn];
        
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
@end
