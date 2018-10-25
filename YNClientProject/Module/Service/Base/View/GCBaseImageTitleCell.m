//
//  GCBaseImageTitleCell.m
//  UVTao
//
//  Created by mac on 2018/8/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GCBaseImageTitleCell.h"
#import "Head.h"

@interface GCBaseImageTitleCell()
@property (strong, nonatomic) UIImageView *titleImgV;
@property (strong, nonatomic) UILabel *titleLab;
@end
@implementation GCBaseImageTitleCell
#pragma mark - getter and setter
-(UIImageView *)titleImgV
{
    if (!_titleImgV) {
        _titleImgV = [UIImageView new];
        _titleImgV.frame = WFCGRectMake(16, 14.5, 22, 16);
    }
    return _titleImgV;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.frame = WFCGRectMake(49, 0, 200, 45);
        _titleLab.textColor = Main_Color_Black;
        _titleLab.font = SYSTEMFONT(15);
    }
    return _titleLab;
}
-(void)setModel:(GCBaseImageTitleCellModel *)model
{
    _model = model;
    UIImage *img = [UIImage imageNamed:self.model.imageName];
    _titleImgV.image = img;
    _titleImgV.width = WFCGFloatX(img.size.width);
    _titleImgV.height = WFCGFloatY(img.size.height);
    _titleImgV.center = CGPointMake(WFCGFloatX(27), WFCGFloatY(22.5));
    _titleLab.text = self.model.title;
}
#pragma mark - life
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleImgV];
        [self.contentView addSubview:self.titleLab];
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
@end
