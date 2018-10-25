//
//  YNHealthPeoHeaderView.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

#import "YNHealthPeoHeaderView.h"
#import "Head.h"
#import "HealthPeoPleViewModel.h"
@interface YNHealthPeoHeaderView ()
@property(nonatomic,strong)UIImageView* headIV;
@property(nonatomic,strong)UIButton* leftBtn;
@property(nonatomic,strong)UIImageView* leftIV;
@property(nonatomic,strong)UIButton* rightbtn;
@property(nonatomic,strong)UIImageView* rightIV;
@end

@implementation YNHealthPeoHeaderView
#pragma mark - getter and setter
- (UIImageView *)headIV
{
    if (!_headIV) {
        _headIV=[UIImageView new];
        _headIV.x=WFCGFloatX(15);
        _headIV.y=WFCGFloatY(10);
        _headIV.width=WFCGFloatX(345);
        _headIV.height=WFCGFloatY(104);
        _headIV.image=[UIImage imageNamed:@"health_top_bg"];;
        [WFFunctions addCornerToView:_headIV radius:5 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    }
    return _headIV;
}
-(UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.x=WFCGFloatX(17);
        _leftBtn.y=WFCGFloatY(134);
        _leftBtn.width=WFCGFloatX(80);
        _leftBtn.height=WFCGFloatY(15);
        [_leftBtn setTitleColor:HEXCOLOR(@"#333333") forState:UIControlStateNormal];
        _leftBtn.titleLabel.font=SYSTEMFONT(15);
        [_leftBtn setTitle:@"全部药品" forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(gotoSHowMemeu:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn setEnlargeEdge:15];

    }
    return _leftBtn;
}
- (UIImageView *)leftIV
{
    if (!_leftIV) {
        _leftIV=[UIImageView new];
        _leftIV.image=[UIImage imageNamed:@"health_mark_down"];
        _leftIV.x=WFCGFloatX(100);
        _leftIV.y=WFCGFloatY(138);
        _leftIV.width=_leftIV.image.size.width;
        _leftIV.height=_leftIV.image.size.height;
    }
    return _leftIV;
}

-(UIButton *)rightbtn
{
    if (!_rightbtn) {
        _rightbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightbtn.x=WFCGFloatX(305);
        _rightbtn.y=WFCGFloatY(134);
        _rightbtn.width=WFCGFloatX(40);
        _rightbtn.height=WFCGFloatY(15);
        [_rightbtn setTitleColor:HEXCOLOR(@"#333333") forState:UIControlStateNormal];
        _rightbtn.titleLabel.font=SYSTEMFONT(15);
        [_rightbtn setTitle:@"价格" forState:UIControlStateNormal];
        [_rightbtn addTarget:self action:@selector(showpriceMemu:) forControlEvents:UIControlEventTouchUpInside];
        [_rightbtn setEnlargeEdge:15];
    }
    return _rightbtn;
}
- (UIImageView *)rightIV
{
    if (!_rightIV) {
        _rightIV=[UIImageView new];
        _rightIV.image=[UIImage imageNamed:@"health_price_up"];

        _rightIV.width=_rightIV.image.size.width;
        _rightIV.height=_rightIV.image.size.height;
        _rightIV.x=SCREEN_WIDTH-_rightIV.width-WFCGFloatX(18);
        _rightIV.y=WFCGFloatY(136);
    }
    return _rightIV;
}
#pragma mark - event
-(void)showpriceMemu:(UIButton*)sender
{
    @WeakSelf;
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.textColor = Main_Color_Black;
    configuration.tintColor = [UIColor whiteColor];
    configuration.textFont = [UIFont systemFontOfSize:12];
    //    configuration.shadowOpacity = 1; // Default is 0 - choose anything between 0 to 1 to show actual shadow, e.g. 0.2
    //    configuration.shadowRadius = 5; // Default is 5
    configuration.borderColor = HEXCOLOR(@"#CCCCCC");
    configuration.textAlignment=NSTextAlignmentCenter;
    configuration.menuIconMargin=10;
    configuration.menuRowHeight=WFCGFloatY(32);
    configuration.menuWidth=WFCGFloatX(82);
    configuration.selectedTextColor=Main_Font_Color_Gold;
    
    [FTPopOverMenu showForSender:sender withMenuArray:@[@"价格升序",@"价格降序"] imageArray:@[@"health_list_up",@"health_list_down"] doneBlock:^(NSInteger selectedIndex) {
        if (selectedIndex==0)
        {
            selfp.handler(@"-1");
        }else
        {
            selfp.handler(@"-2");
        }
    } dismissBlock:^{
        
    }];
}
-(void)gotoSHowMemeu:(UIButton*)sender
{
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.textColor = Main_Color_Black;
    configuration.tintColor = [UIColor whiteColor];
    configuration.textFont = [UIFont systemFontOfSize:12];
    configuration.selectedTextColor=Main_Font_Color_Gold;
    configuration.borderColor = HEXCOLOR(@"#CCCCCC");
    configuration.textAlignment=NSTextAlignmentCenter;
    configuration.menuRowHeight=WFCGFloatY(32);
    configuration.menuWidth=WFCGFloatX(120);
    NSMutableArray* arr=[NSMutableArray new];
    for (YNDrugModel* model in self.passData)
    {
        [arr addObject:model.cate_name];
    }
    @WeakSelf;
    [FTPopOverMenu showForSender:sender withMenuArray:arr doneBlock:^(NSInteger selectedIndex) {
        
        [selfp.leftBtn setTitle:arr[selectedIndex] forState:UIControlStateNormal];
        YNDrugModel* model = selfp.passData[selectedIndex];
        selfp.handler(model.cate_id);
        
    } dismissBlock:^{
        
    }];

}
#pragma mark - method
#pragma mark - life
-(instancetype)init
{
    if (self = [super init])
    {
        self.height=WFCGFloatY(160);
        self.width=SCREEN_WIDTH;
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.headIV];
        [self addSubview:self.leftBtn];
        [self addSubview:self.leftIV];
        [self addSubview:self.rightIV];
        [self addSubview:self.rightbtn];
        
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
