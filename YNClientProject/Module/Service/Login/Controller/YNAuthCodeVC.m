//
//  YNAuthCodeVC.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/24.
//  Copyright © 2018年 雅恩三河科技. All rights reserved.
//

//
//                .-~~~~~~~~~-._       _.-~~~~~~~~~-.
//            __.'              ~.   .~              `.__
//          .'//                  \./                  \\`.
//        .'//                     |                     \\`.
//      .'// .-~"""""""~~~~-._     |     _,-~~~~"""""""~-. \\`.
//    .'//.-"                 `-.  |  .-'                 "-.\\`.
//  .'//______.============-..   \ | /   ..-============.______\\`.
//.'______________________________\|/______________________________`.
//
//

#import "YNAuthCodeVC.h"
#import "Head.h"
#import "MQVerCodeInputView.h"
@interface YNAuthCodeVC ()
@property(nonatomic,strong)UILabel* topLab;
@property(nonatomic,strong)UILabel* btomLab;
@property(nonatomic,strong)UIButton* loginBtn;
@property(nonatomic,strong)MQVerCodeInputView *verView;

@property(nonatomic,strong)UILabel* timeOutLab;
@property(nonatomic,strong)NSString* codeStr;
@end

@implementation YNAuthCodeVC
#pragma mark - getter and setter
-(UILabel *)timeOutLab
{
    if (!_timeOutLab) {
        _timeOutLab=[UILabel new];
        _timeOutLab.y=WFCGFloatY(204);
        _timeOutLab.width=SCREEN_WIDTH;
        _timeOutLab.textColor=HEXCOLOR(@"#FA1313");
        _timeOutLab.height=WFCGFloatY(12);
        _timeOutLab.x=WFCGFloatX(0);
        _timeOutLab.font=SYSTEMFONT(12);
        _timeOutLab.textAlignment=NSTextAlignmentCenter;
        _timeOutLab.text=@"验证码超时";
        _timeOutLab.hidden=YES;
    }
    return _timeOutLab;
}
-(UILabel *)btomLab
{
    if (!_btomLab) {
        _btomLab=[UILabel new];
        _btomLab.y=WFCGFloatY(300);
        _btomLab.width=SCREEN_WIDTH;
        _btomLab.textColor=HEXCOLOR(@"#999999");
        _btomLab.height=WFCGFloatY(12);
        _btomLab.x=WFCGFloatX(0);
        _btomLab.font=SYSTEMFONT(12);
        _btomLab.textAlignment=NSTextAlignmentCenter;
    }
    return _btomLab;
}

-(UILabel *)topLab
{
    if (!_topLab) {
        _topLab=[UILabel new];
        _topLab.y=WFCGFloatY(99);
        _topLab.width=SCREEN_WIDTH;
        _topLab.textColor=HEXCOLOR(@"#999999");
        _topLab.height=WFCGFloatY(12);
        _topLab.x=WFCGFloatX(0);
        _topLab.font=SYSTEMFONT(12);
        _topLab.textAlignment=NSTextAlignmentCenter;
        _topLab.text=[YNLoginViewModel shareInterface].registeTitle;
    }
    return _topLab;
}
-(MQVerCodeInputView *)verView
{
    if (!_verView)
    {
        @WeakSelf;
        _verView = [[MQVerCodeInputView alloc]initWithFrame:CGRectMake(WFCGFloatX(60), WFCGFloatY(130), SCREEN_WIDTH-WFCGFloatX(120), 50)];
        _verView.maxLenght = 4;//最大长度
        _verView.keyBoardType = UIKeyboardTypeNumberPad;
        [_verView mq_verCodeViewWithMaxLenght];
        _verView.backgroundColor=[UIColor whiteColor];
        _verView.block = ^(NSString *text){
            NSLog(@"text = %@",text);
            [YNLoginViewModel shareInterface].validateCode=text;
            if (text.length!=4) {
                selfp.timeOutLab.hidden=YES;
            }
        };
    }
    return _verView;
}
-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.frame = WFCGRectMake(36, 237, 303, 41);
        // [_loginBtn addTarget:self action:@selector(loginTap) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateDisabled];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:Main_Color_Gold forState:UIControlStateNormal];
        [WFFunctions WFUIaddbordertoView:_loginBtn radius:WFCGFloatY(41/2) width:0 color:[UIColor clearColor]];
        _loginBtn.titleLabel.font = SYSTEMFONT(16);
        @WeakSelf;
        [_loginBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            
            if ([WFFunctions WFStrCheckEmpty:[YNLoginViewModel shareInterface].validateCode])
            {
                [FTIndicator showErrorWithMessage:@"请输入验证码"];
            }else if([YNLoginViewModel shareInterface].validateCode.length!=4)
            {
                [FTIndicator showErrorWithMessage:@"请输入4位验证码"];
            }else
            {
                NSMutableDictionary* para=[NSMutableDictionary new];
                [para setObject:[YNLoginViewModel shareInterface].registerPhone forKey:@"mobile"];
                [para setObject:[YNLoginViewModel shareInterface].validateCode forKey:@"yzm"];
                [[YNLoginViewModel shareInterface] requestAuthCode:para];
            }
        }];
    }
    return _loginBtn;
}
#pragma mark - event
#pragma mark - method
-(void)initilization
{
    @WeakSelf;
    [self setNavgationTheme:2];
    
    [self setBacKBarButtonWithTitle:@"yellow_back" titleColor:nil withBlock:^{
       [selfp.navigationController popViewControllerAnimated:YES];;
    }];
    [self viewModelBand];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.topLab];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.btomLab];
    [self.view addSubview:self.verView];
    [self.view addSubview:self.timeOutLab];
}
-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"validateCodeStatus";
    saleOber.observation=[YNLoginViewModel shareInterface];
    saleOber.handler = ^(NSString *keyPath) {
        if ([[YNLoginViewModel shareInterface].validateCodeStatus isEqualToString:@"重新发送"])
        {
            selfp.btomLab.textColor=Main_Font_Color_Gold;
            selfp.btomLab.text=@"重新发送";
            selfp.timeOutLab.hidden=NO;
            [selfp.btomLab addTapGestureRecognizerWithDelegate:selfp Block:^(NSInteger tag) {
                selfp.timeOutLab.hidden=YES;
                NSMutableDictionary* para=[NSMutableDictionary new];
                [para setObject:[YNLoginViewModel shareInterface].registerPhone forKey:@"username"];
                [[YNLoginViewModel shareInterface] requestGetCode:para];
            }];
        }else
        {
            selfp.btomLab.textColor=HEXCOLOR(@"#999999");
            selfp.btomLab.text=[NSString stringWithFormat:@"%@后可重新发送验证码",[YNLoginViewModel shareInterface].validateCodeStatus];
        }
    };
    [self registObservation:saleOber];
    
    
    GCBaseObservationModel* saleOber1=[GCBaseObservationModel new];
    saleOber1.keyPath=@"authsuccess";
    saleOber1.observation=[YNLoginViewModel shareInterface];
    saleOber1.handler = ^(NSString *keyPath) {
        if ([YNLoginViewModel shareInterface].authsuccess)
        {
            selfp.timeOutLab.hidden=YES;
            Class class=NSClassFromString(@"YNSetPswVC");
            if (class) {
                UIViewController* vc=[[class alloc] init];
                [selfp.navigationController pushViewController:vc animated:YES];
            }
        }else
        {
            selfp.timeOutLab.hidden=NO;
            selfp.timeOutLab.text=@"验证码输入错误，请核对";
        }
    };
    [self registObservation:saleOber1];
}
-(void)reloadData
{

}
-(void)reloadView
{
    
}
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initilization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - delegate
@end


/*
 11111111111111111111111111111111111111001111111111111111111111111
 11111111111111111111111111111111111100011111111111111111111111111
 11111111111111111111111111111111100001111111111111111111111111111
 11111111111111111111111111111110000111111111111111111111111111111
 11111111111111111111111111111000000111111111111111111111111111111
 11111111111111111111111111100000011110001100000000000000011111111
 11111111111111111100000000000000000000000000000000011111111111111
 11111111111111110111000000000000000000000000000011111111111111111
 11111111111111111111111000000000000000000000000000000000111111111
 11111111111111111110000000000000000000000000000000111111111111111
 11111111111111111100011100000000000000000000000000000111111111111
 11111111111111100000110000000000011000000000000000000011111111111
 11111111111111000000000000000100111100000000000001100000111111111
 11111111110000000000000000001110111110000000000000111000011111111
 11111111000000000000000000011111111100000000000000011110001111111
 11111110000000011111111111111111111100000000000000001111100111111
 11111111000001111111111111111111110000000000000000001111111111111
 11111111110111111111111111111100000000000000000000000111111111111
 11111111111111110000000000000000000000000000000000000111111111111
 11111111111111111100000000000000000000000000001100000111111111111
 11111111111111000000000000000000000000000000111100000111111111111
 11111111111000000000000000000000000000000001111110000111111111111
 11111111100000000000000000000000000000001111111110000111111111111
 11111110000000000000000000000000000000111111111110000111111111111
 11111100000000000000000001110000001111111111111110001111111111111
 11111000000000000000011111111111111111111111111110011111111111111
 11110000000000000001111111111111111100111111111111111111111111111
 11100000000000000011111111111111111111100001111111111111111111111
 11100000000001000111111111111111111111111000001111111111111111111
 11000000000001100111111111111111111111111110000000111111111111111
 11000000000000111011111111111100011111000011100000001111111111111
 11000000000000011111111111111111000111110000000000000011111111111
 11000000000000000011111111111111000000000000000000000000111111111
 11001000000000000000001111111110000000000000000000000000001111111
 11100110000000000001111111110000000000000000111000000000000111111
 11110110000000000000000000000000000000000111111111110000000011111
 11111110000000000000000000000000000000001111111111111100000001111
 11111110000010000000000000000001100000000111011111111110000001111
 11111111000111110000000000000111110000000000111111111110110000111
 11111110001111111100010000000001111100000111111111111111110000111
 11111110001111111111111110000000111111100000000111111111111000111
 11111111001111111111111111111000000111111111111111111111111100011
 11111111101111111111111111111110000111111111111111111111111001111
 11111111111111111111111111111110001111111111111111111111100111111
 11111111111111111111111111111111001111111111111111111111001111111
 11111111111111111111111111111111100111111111111111111111111111111
 11111111111111111111111111111111110111111111111111111111111111111
 
 
 */
