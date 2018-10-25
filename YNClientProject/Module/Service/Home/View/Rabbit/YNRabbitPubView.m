//
//  YNRabbitPubView.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNRabbitPubView.h"
#import "Head.h"
#import "AttributeView.h"
#import "YNTimeItemView.h"
@interface YNRabbitPubView ()<AttributeViewDelegate>
@property(nonatomic,strong)UIView* topView;
@property(nonatomic,strong)UIView* btomView;
@property(nonatomic,strong)UIButton* pubBtn;
@property(nonatomic,strong)UIButton* closeBtn;
@property(nonatomic,strong)YNTimeItemView* timeView;
@end

@implementation YNRabbitPubView
#pragma mark - getter and setter
-(UIButton *)closeBtn
{
    if (!_closeBtn)
    {
        _closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* imageNO=[UIImage imageNamed:@"timeView_close"];
        [_closeBtn setBackgroundImage:imageNO forState:UIControlStateNormal];
        _closeBtn.x=WFCGFloatX(14);
        _closeBtn.width=imageNO.size.width;
        _closeBtn.height=imageNO.size.height;
        _closeBtn.y=-(_closeBtn.height/2);
        [_closeBtn setEnlargeEdge:15];
        [_closeBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{

        }];
    }
    return _closeBtn;
}
-(YNTimeItemView *)timeView
{
    if (!_timeView) {
        _timeView=[[YNTimeItemView alloc] init];
        _timeView.x=WFCGFloatX(102);
        _timeView.y=WFCGFloatY(226);
        
    }
    return _timeView;
}
-(UIButton *)pubBtn
{
    if (!_pubBtn) {
        _pubBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
        _pubBtn.x=WFCGFloatX(60);
        _pubBtn.y=WFCGFloatY(466);
        _pubBtn.width=SCREEN_WIDTH-WFCGFloatX(120);
        _pubBtn.height=WFCGFloatY(40);
        [_pubBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        [_pubBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _pubBtn.titleLabel.font=SYSTEMFONT(18);
        _pubBtn.backgroundColor=[WFFunctions GradualChangeColor:@[HEXCOLOR(@"#FF8EC2"),HEXCOLOR(@"#FF7891")] ViewSize:CGSizeMake(_topView.width, WFCGFloatY(40)) gradientType:GradientTypeTopToBottom];
        [WFFunctions WFUIaddbordertoView:_pubBtn radius:WFCGFloatY(20) width:0 color:[UIColor clearColor]];
    }
    return _pubBtn;
}
-(UIView *)topView
{
    if (!_topView) {
        _topView=[UIView new];
        _topView.x=WFCGFloatX(10);
        _topView.y=0;
        _topView.width=SCREEN_WIDTH-WFCGFloatX(20);
        _topView.height=WFCGFloatY(133);
        _topView.backgroundColor=[UIColor whiteColor];
        [WFFunctions WFUIaddbordertoView:_topView radius:3 width:0 color:[UIColor clearColor]];
        
        UILabel* titlelab=[UILabel new];
        titlelab.x=0;
        titlelab.y=WFCGFloatY(16);
        titlelab.width=_topView.width;
        titlelab.height=WFCGFloatY(18);
        titlelab.textAlignment=NSTextAlignmentCenter;
        titlelab.text=@"医院位置";
        titlelab.font=SYSTEMFONT(18);
        titlelab.textColor=HEXCOLOR(@"#111111");
        [_topView addSubview:titlelab];
        
        
        UIButton* titmBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
        titmBtn.x=0;
        titmBtn.y=WFCGFloatY(49);
        titmBtn.width=_topView.width;
        titmBtn.height=WFCGFloatY(15);
        [titmBtn setTitle:@"预约时间>" forState:UIControlStateNormal];
        [titmBtn setTitleColor:HEXCOLOR(@"#333333") forState:UIControlStateNormal];
        titmBtn.titleLabel.font=SYSTEMFONT(13);
        [_topView addSubview:titmBtn];
        
        [titmBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [BRDatePickerView showDatePickerWithTitle:@"选择时间" dateType:UIDatePickerModeDateAndTime defaultSelValue:nil resultBlock:^(NSString *selectValue) {
                
            }];
            

        }];
        
        
        UIImageView* dointIV=[UIImageView new];
        dointIV.x=WFCGFloatX(15);
        dointIV.y=WFCGFloatY(82);
        dointIV.width=WFCGFloatY(6);
        dointIV.height=dointIV.width;
        dointIV.backgroundColor=HEXCOLOR(@"#FF7890");
        [WFFunctions WFUIaddbordertoView:dointIV radius:WFCGFloatY(3) width:0 color:[UIColor clearColor]];
        [_topView addSubview:dointIV];
        
        
        UILabel* locaLab=[UILabel new];
        locaLab.x=WFCGFloatX(33);
        locaLab.y=WFCGFloatY(77);
        locaLab.width=_topView.width-WFCGFloatX(36);
        locaLab.height=WFCGFloatY(18);
        locaLab.text=@"请选择医院位置";
        locaLab.font=SYSTEMFONT(16);
        locaLab.textColor=HEXCOLOR(@"#333333");
        [_topView addSubview:locaLab];
        
        
        UIImageView* lineIV=[UIImageView new];
        lineIV.x=WFCGFloatX(33);
        lineIV.y=WFCGFloatY(108);
        lineIV.width=_topView.width-WFCGFloatX(33);
        lineIV.height=0.5;
        lineIV.backgroundColor=HEXCOLOR(@"#EEEEEE");
        [_topView addSubview:lineIV];
        
    }
    return _topView;
}
-(UIView *)btomView
{
    @WeakSelf;
    if (!_btomView) {
        _btomView=[UIView new];
        _btomView.x=WFCGFloatX(10);
        _btomView.y=WFCGFloatY(142);
        _btomView.width=SCREEN_WIDTH-WFCGFloatX(20);
        _btomView.height=WFCGFloatY(300);
        _btomView.backgroundColor=[UIColor whiteColor];
        [WFFunctions WFUIaddbordertoView:_btomView radius:3 width:0 color:[UIColor clearColor]];
        
        
        
        UILabel* titlelab=[UILabel new];
        titlelab.x=0;
        titlelab.y=WFCGFloatY(16);
        titlelab.width=_topView.width;
        titlelab.height=WFCGFloatY(18);
        titlelab.textAlignment=NSTextAlignmentCenter;
        titlelab.text=@"服务内容";
        titlelab.font=SYSTEMFONT(18);
        titlelab.textColor=HEXCOLOR(@"#111111");
        [_btomView addSubview:titlelab];
        
        
        AttributeView* cellAttributeViewDS=[AttributeView attributeViewWithTitle:@"选择陪诊服务" titleFont:SYSTEMFONT(16) attributeTexts:nil viewWidth:_btomView.width];
        cellAttributeViewDS.backgroundColor=[UIColor whiteColor];
        cellAttributeViewDS.Attribute_delegate=self;
        cellAttributeViewDS.y=WFCGFloatY(60);
        cellAttributeViewDS.defaultSel=NO;
        cellAttributeViewDS.isCanPress=YES;
        cellAttributeViewDS.x=WFCGFloatX(15);
        [cellAttributeViewDS setDatas:[NSMutableArray arrayWithArray:@[@"挂号",@"看病指引",@"取药",@"跑腿",@"取报告",@"抬物"]]];
        [_btomView addSubview:cellAttributeViewDS];
        
        
        UILabel* titlelab1=[UILabel new];
        titlelab1.x=WFCGFloatX(15);
        titlelab1.y=WFCGFloatY(190);
        titlelab1.width=150;
        titlelab1.height=WFCGFloatY(16);
        titlelab1.text=@"选择陪护服务";
        titlelab1.font=SYSTEMFONT(16);
        titlelab1.textColor=HEXCOLOR(@"#333333");
        [_btomView addSubview:titlelab1];
        
        NSArray* titleArr=@[@"男陪护",@"女陪护"];
        
        for ( int i=0; i<2; i++)
        {
            UIButton* titmBtn=[UIButton  buttonWithType:UIButtonTypeCustom];
            titmBtn.x=WFCGFloatX(16);
            titmBtn.y=WFCGFloatY(226)+WFCGFloatY(35)*i;
            titmBtn.width=WFCGFloatY(70);
            titmBtn.height=WFCGFloatY(26);
            [titmBtn setTitle:titleArr[i] forState:UIControlStateNormal];
            [_btomView addSubview:titmBtn];

            [titmBtn setTitleColor:HEXCOLOR(@"#CCCCCC") forState:UIControlStateNormal];
            titmBtn.titleLabel.font=SYSTEMFONT(15);
            [WFFunctions WFUIaddbordertoView:titmBtn radius:WFCGFloatY(13) width:0.5 color:HEXCOLOR(@"#CCCCCC")];
            titmBtn.backgroundColor=[UIColor whiteColor];

            titmBtn.tag=900+i;
            [titmBtn addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
                UIButton* btn=(UIButton*)[selfp.btomView viewWithTag:900];
                UIButton* btn1=(UIButton*)[selfp.btomView viewWithTag:901];
                selfp.timeView.hidden=NO;
                if (tag==900) {
                    
                    [btn setTitleColor:HEXCOLOR(@"#FFFFFF") forState:UIControlStateNormal];
                    btn.titleLabel.font=SYSTEMFONT(15);
                    [WFFunctions WFUIaddbordertoView:btn radius:WFCGFloatY(13) width:0 color:[UIColor clearColor]];
                    btn.backgroundColor=HEXCOLOR(@"#FF7890");
                    
                    
                    [btn1 setTitleColor:HEXCOLOR(@"#CCCCCC") forState:UIControlStateNormal];
                    btn1.titleLabel.font=SYSTEMFONT(15);
                    [WFFunctions WFUIaddbordertoView:btn1 radius:WFCGFloatY(13) width:0.5 color:HEXCOLOR(@"#CCCCCC")];
                    btn1.backgroundColor=[UIColor whiteColor];
                    selfp.timeView.y=WFCGFloatY(226);
                }else
                {
                    [btn1 setTitleColor:HEXCOLOR(@"#FFFFFF") forState:UIControlStateNormal];
                    btn1.titleLabel.font=SYSTEMFONT(15);
                    [WFFunctions WFUIaddbordertoView:btn1 radius:WFCGFloatY(13) width:0 color:[UIColor clearColor]];
                    btn1.backgroundColor=HEXCOLOR(@"#FF7890");
                    
                    
                    [btn setTitleColor:HEXCOLOR(@"#CCCCCC") forState:UIControlStateNormal];
                    btn.titleLabel.font=SYSTEMFONT(15);
                    [WFFunctions WFUIaddbordertoView:btn radius:WFCGFloatY(13) width:0.5 color:HEXCOLOR(@"#CCCCCC")];
                    btn.backgroundColor=[UIColor whiteColor];
                    selfp.timeView.y=WFCGFloatY(226+35);
                }
            }];
        }

        
        

        
    }
    return _btomView;
}
#pragma mark - event
#pragma mark - method
#pragma mark - life
-(instancetype)init
{
    if (self = [super init]) {
        self.width=SCREEN_WIDTH;
        self.height=WFCGFloatY(520);
        [self addSubview:self.topView];
        [self addSubview:self.btomView];
        [self addSubview:self.pubBtn];
        [self.btomView addSubview:self.timeView];
        [self addSubview:self.closeBtn];
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
