//
//  YNTimeItemView.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNTimeItemView.h"
#import "Head.h"
@interface YNTimeItemView ()
@property(nonatomic,strong)UIButton* leftBtn;
@property(nonatomic,strong)UILabel* leftLab;
@property(nonatomic,strong)UIButton* rightBtn;
@property(nonatomic,strong)UILabel* rightLab;
@end

@implementation YNTimeItemView
#pragma mark - getter and setter
-(UIButton *)leftBtn
{
    @WeakSelf;
    if (!_leftBtn)
    {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image=[UIImage imageNamed:@"time_choose"];
        UIImage* imageNO=[UIImage imageNamed:@"time_choose_no"];
        [_leftBtn setBackgroundImage:imageNO forState:UIControlStateNormal];
        [_leftBtn setBackgroundImage:image forState:UIControlStateSelected];
        _leftBtn.x=WFCGFloatX(0);
        _leftBtn.width=image.size.width;
        _leftBtn.height=image.size.height;
        _leftBtn.y=(self.height-_leftBtn.height)/2;
        _leftBtn.selected=YES;
        [_leftBtn setEnlargeEdge:15];
        [_leftBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            selfp.leftBtn.selected=YES;
            selfp.leftLab.textColor=HEXCOLOR(@"#171717");
            selfp.rightBtn.selected=NO;
            selfp.rightLab.textColor=HEXCOLOR(@"#999999");
        }];
    }
    return _leftBtn;
    
}
-(UILabel *)leftLab
{
    if (!_leftLab) {
        
        _leftLab=[UILabel new];
        _leftLab.x=WFCGFloatX(20);
        _leftLab.y=0;
        _leftLab.width=60;
        _leftLab.height=self.height;
        _leftLab.text=@"12小时";
        _leftLab.font=SYSTEMFONT(16);
        _leftLab.textColor=HEXCOLOR(@"#171717");
    }
    return _leftLab;
}
-(UIButton *)rightBtn
{
    if (!_rightBtn) {
        @WeakSelf;
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image=[UIImage imageNamed:@"time_choose"];
        UIImage* imageNO=[UIImage imageNamed:@"time_choose_no"];
        [_rightBtn setBackgroundImage:imageNO forState:UIControlStateNormal];
        [_rightBtn setBackgroundImage:image forState:UIControlStateSelected];
        _rightBtn.x=WFCGFloatX(90);
        _rightBtn.width=image.size.width;
        _rightBtn.height=image.size.height;
        _rightBtn.y=(self.height-_rightBtn.height)/2;
        [_rightBtn setEnlargeEdge:15];
        [_rightBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            selfp.rightBtn.selected=YES;
            selfp.rightLab.textColor=HEXCOLOR(@"#171717");
            selfp.leftBtn.selected=NO;
            selfp.leftLab.textColor=HEXCOLOR(@"#999999");
        }];
    }
    return _rightBtn;
    
}
-(UILabel *)rightLab
{
    if (!_rightLab) {
        
        _rightLab=[UILabel new];
        _rightLab.x=WFCGFloatX(110);
        _rightLab.y=0;
        _rightLab.width=60;
        _rightLab.height=self.height;
        _rightLab.text=@"24小时";
        _rightLab.font=SYSTEMFONT(16);
        _rightLab.textColor=HEXCOLOR(@"#999999");
    }
    return _rightLab;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)init
{
    if (self = [super init]) {
        self.backgroundColor=[UIColor whiteColor];
        self.width=WFCGFloatX(180);
        self.height=WFCGFloatY(26);
        [self addSubview:self.leftBtn];
        [self addSubview:self.leftLab];
        [self addSubview:self.rightBtn];
        [self addSubview:self.rightLab];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - delegate
@end
