//
//  YNHealthPubCell.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHealthPubCell.h"
#import "Head.h"
@interface YNHealthPubCell ()
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UILabel* titleLab;

@property(nonatomic,strong)UIImageView* lineIV;
@property(nonatomic,strong)NSDictionary* placeDic;
@property(nonatomic,strong)UILabel* detailLab;
@property(nonatomic,strong)UITextView* remarkTextView;
@end

@implementation YNHealthPubCell
#pragma mark - getter and setter
-(NSDictionary *)placeDic
{
    if (!_placeDic) {
                _placeDic=@{@"药品名称":@"请输入药品名称",
                            @"药品价格":@"请输入药品价格",
                            @"药品分类":@"请选择药品分类",
                            @"发布人姓名":@"请输入您的姓名",
                            @"交易地址":@"请选择交易地址",
                            @"联系电话":@"请输入联系电话",
                            @"留言":@"请输入您的留言"
                            };
    }
    return _placeDic;
}
-(UIButton *)minbtn
{
    if (!_minbtn) {
        @WeakSelf;
        _minbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image=[UIImage imageNamed:@"pub_count_m"];
        [_minbtn setBackgroundImage:image forState:UIControlStateNormal];
        _minbtn.x=WFCGFloatX(141);
        _minbtn.width=image.size.width;
        _minbtn.height=image.size.height;
        _minbtn.y=(WFCGFloatY(47)-_minbtn.height)/2;
        [_minbtn setEnlargeEdge:15];

    }
    return _minbtn;
}
-(UIButton *)addBtn
{
    if (!_addBtn) {
        @WeakSelf;
        _addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image=[UIImage imageNamed:@"pub_count_a"];
        [_addBtn setBackgroundImage:image forState:UIControlStateNormal];
        _addBtn.x=WFCGFloatX(210);
        _addBtn.width=image.size.width;
        _addBtn.height=image.size.height;
        _addBtn.y=(WFCGFloatY(47)-_addBtn.height)/2;
        [_addBtn setEnlargeEdge:15];

    }
    return _addBtn;
}
-(UIImageView *)lineIV
{
    if (!_lineIV) {
        _lineIV=[UIImageView new];
        _lineIV.x=WFCGFloatX(15);
        _lineIV.y=WFCGFloatY(46);
        _lineIV.width=WFCGFloatX(345);
        _lineIV.height=WFCGFloatY(0.5);
        _lineIV.backgroundColor=HEXCOLOR(@"#CCCCCC");
        
    }
    return _lineIV;
}
-(UIImageView *)markIV
{
    if (!_markIV) {
        _markIV=[UIImageView new];
        _markIV.x=WFCGFloatX(15);
        _markIV.y=WFCGFloatY(15);

    }
    return _markIV;
}
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.x=WFCGFloatX(38);
        _titleLab.y=WFCGFloatY(15);
        _titleLab.width=WFCGFloatX(80);
        _titleLab.height=WFCGFloatY(15);
        _titleLab.font=SYSTEMFONT(15);
        _titleLab.backgroundColor=[UIColor whiteColor];
        _titleLab.textColor=HEXCOLOR(@"#333333");
    }
    return _titleLab;
}
-(UILabel *)detailLab
{
    if (!_detailLab) {
        _detailLab=[UILabel new];
        _detailLab.x=WFCGFloatX(141);
        _detailLab.y=WFCGFloatY(0);
        _detailLab.width=WFCGFloatX(220);
        _detailLab.height=WFCGFloatY(47);
        _detailLab.font=SYSTEMFONT(15);
        _detailLab.backgroundColor=[UIColor whiteColor];
        _detailLab.textColor=HEXCOLOR(@"#333333");
        
    }
    return _detailLab;
}
-(UITextField *)detailTF
{
    if (!_detailTF) {
        _detailTF=[[UITextField alloc] init];
        _detailTF.x=WFCGFloatX(141);
        _detailTF.y=0;
        _detailTF.width=WFCGFloatX(220);
        _detailTF.height=WFCGFloatY(47);
        _detailTF.font=SYSTEMFONT(15);
        _detailTF.textColor=HEXCOLOR(@"#333333");
        _detailTF.backgroundColor=[UIColor whiteColor];
    }
    return _detailTF;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = Main_Color_White;
        [self.contentView addSubview:self.markIV];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.detailTF];
        [self.contentView addSubview:self.lineIV];
        [self.contentView addSubview:self.minbtn];
        [self.contentView addSubview:self.addBtn];
        
    }
    return self;
}
-(void)setMarkTitle:(NSString*)title image:(NSString*)imageStr detail:(NSString*)detail cellType:(NSInteger)type
{
    _markIV.image=[UIImage imageNamed:imageStr];
    _markIV.width=_markIV.image.size.width;
    _markIV.height=_markIV.image.size.height;
    _titleLab.text=title;
    if ([WFFunctions WFStrCheckEmpty:detail]) {
        _detailTF.placeholder=[self.placeDic objectForKey:title];
    }else
    {
        _detailTF.text=detail;
    }

    _detailTF.hidden=NO;
    
    if (type==1)
    {
        _detailTF.x=WFCGFloatX(141);
        _detailTF.width=WFCGFloatX(220);
        self.minbtn.hidden=YES;
        self.addBtn.hidden=YES;
        _detailTF.textAlignment=NSTextAlignmentLeft;
        
        if ([title isEqualToString:@"联系电话"]) {
            _detailTF.keyboardType=UIKeyboardTypeNumberPad;
        }else
        {
            _detailTF.keyboardType=UIKeyboardTypeDefault;
        }
    }else if (type==2)
    {
        self.minbtn.hidden=NO;
        self.addBtn.hidden=NO;
        _detailTF.x=WFCGFloatX(162);
        _detailTF.width=WFCGFloatX(48);
        _detailTF.textAlignment=NSTextAlignmentCenter;
        _detailTF.keyboardType=UIKeyboardTypeNumberPad;
    }else
    {
        self.minbtn.hidden=YES;
        self.addBtn.hidden=YES;
        _detailTF.x=WFCGFloatX(141);
        _detailTF.width=WFCGFloatX(220);
        _detailTF.textAlignment=NSTextAlignmentLeft;
        _detailTF.keyboardType=UIKeyboardTypeDefault;
        _detailTF.hidden=YES;
    }

//    if ([title isEqualToString:@"药品分类"]||[title isEqualToString:@"交易地址"])
//    {
//        _detailTF.hidden=YES;
//    }
    _detailTF.enabled=NO;
    _detailTF.userInteractionEnabled=YES;
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
