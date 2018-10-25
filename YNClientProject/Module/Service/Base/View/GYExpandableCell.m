//
//  GYExpandableCell.m
//  GYDemo
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "GYExpandableCell.h"
#import "Head.h"

@interface GYExpandableCell()

@end

@implementation GYExpandableCell
#pragma mark - getter and setter
-(UILabel *)titleLB
{
    if (!_titleLB) {
        _titleLB = [UILabel new];
        _titleLB.font = SYSTEMFONT(15);
        _titleLB.textColor = Main_Color_Black;
        _titleLB.x = WFCGFloatX(15);
        _titleLB.y = 0;
        _titleLB.width = (WF_SCREEN_WIDTH - WFCGFloatX(26)) / 5 * 2;
        _titleLB.height = self.contentView.height;
        _titleLB.userInteractionEnabled = YES;
    }
    return _titleLB;
}
-(void)setModel:(GCBaseEditCellViewModel *)model
{
    _model = model;
    [self layoutSubviews];
}
#pragma mark - life
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_model.isSpecialView) {
        [self.contentView addSubview:_model.specialView];
    }else{
        self.accessoryType = _model.canEdit ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
        NSString *titles = _model.unit ? [NSString stringWithFormat:@"%@(%@)",_model.title,_model.unit] : _model.title;
        if (_model.necessary) {
            NSString *title = [NSString stringWithFormat:@"* %@",titles];
            NSMutableAttributedString *mastr = [[NSMutableAttributedString alloc]initWithString:title];
            [mastr addAttribute:NSFontAttributeName value:self.titleLB.font range:[title rangeOfString:title]];
            [mastr addAttribute:NSForegroundColorAttributeName value:Main_Color_Red range:[title rangeOfString:@"*"]];
            self.titleLB.attributedText = mastr;
        }else{
            self.titleLB.text = titles;
        }
        self.textView.text = _model.value;
//        self.textView.backgroundColor = Main_Color_Gold;
        self.textView.zw_placeHolderColor = Main_Color_LightGray;
        self.textView.zw_placeHolder = _model.placeholder;
        CGFloat cellheight = [self cellHeight];
        _model.cellheight = cellheight;
        self.textView.editable = _model.canEdit;
        self.textView.userInteractionEnabled = self.textView.editable;
        self.textView.keyboardType = _model.inputType;
        
        if (titles.length > 0) {
            //        _titleLB.width = (ScaleScreenWidth - WFCGFloatX(26)) / 5 * 2;
            self.textView.x = self.titleLB.right;
            self.textView.width = self.titleLB.width / 2 * 3;
            self.textView.textAlignment = NSTextAlignmentRight;
            if (self.accessoryType > 0) {
                self.textView.x = self.textView.x - WFCGFloatX(10);
            }
        }else{
            //        _titleLB.width = 0;
            self.textView.x = self.titleLB.x;
            self.textView.width = self.titleLB.width / 2 * 5;
            self.textView.textAlignment = NSTextAlignmentLeft;
        }
    }
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLB];
        [self.contentView insertSubview:_titleLB belowSubview:self.textView];
        self.textView.font = SYSTEMFONT(14);
        self.textView.textColor = Main_Color_Gray;
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
