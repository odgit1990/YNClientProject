//
//  YNLoginVC.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/19.
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

#import "YNLoginVC.h"
#import "Head.h"
#import "YNLoginTxView.h"
#import "YNLoginViewModel.h"
@interface YNLoginVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView* logoIV;
@property(nonatomic,strong)UIImageView* btoIV;
@property(nonatomic,strong)YNLoginTxView* phoneView;
@property(nonatomic,strong)YNLoginTxView* pswView;

@property(nonatomic,strong)UIButton* loginBtn;
@property(nonatomic,strong)UIButton* registerBtn;
@property(nonatomic,strong)UIButton* findPswBtn;

@property(nonatomic,strong)UIButton* WXBtn;
@property(nonatomic,strong)UIButton* QQBtn;
@property(nonatomic,strong)YNLoginViewModel* viewModel;
@end

@implementation YNLoginVC
#pragma mark - getter and setter
-(YNLoginViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel=[YNLoginViewModel shareInterface];
    }
    return _viewModel;
}
-(UIImageView *)btoIV
{
    if (!_btoIV) {
        _btoIV=[[UIImageView alloc] init];
        _btoIV.image=[UIImage imageNamed:@"log_b_bg"];
        _btoIV.width=_btoIV.image.size.width;
        _btoIV.height=_btoIV.image.size.height;
        _btoIV.x=(SCREEN_WIDTH-_btoIV.width)/2;
        _btoIV.y=SCREEN_HEIGHT-WFCGFloatY(155);
        
    }
    return _btoIV;
}
-(UIButton *)QQBtn
{
    if (!_QQBtn) {
        _QQBtn = [[UIButton alloc]init];
        UIImage* image=[UIImage imageNamed:@"qq_login"];
        [_QQBtn setBackgroundImage:image forState:UIControlStateNormal];
        _QQBtn.width=image.size.width;
        _QQBtn.height=image.size.height;
        _QQBtn.x=WFCGFloatX(100);
        _QQBtn.y=SCREEN_HEIGHT-WFCGFloatY(80)-_QQBtn.height;
    }
    return _QQBtn;
}
-(UIButton *)WXBtn
{
    if (!_WXBtn) {
        _WXBtn = [[UIButton alloc]init];
        UIImage* image=[UIImage imageNamed:@"wx_login"];
        [_WXBtn setBackgroundImage:image forState:UIControlStateNormal];
        _WXBtn.width=image.size.width;
        _WXBtn.height=image.size.height;
        _WXBtn.x=SCREEN_WIDTH-WFCGFloatX(100)-_WXBtn.width;
        _WXBtn.y=SCREEN_HEIGHT-WFCGFloatY(80)-_WXBtn.height;
    }
    return _WXBtn;
}


-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.frame = WFCGRectMake(36, 371, 303, 41);
       // [_loginBtn addTarget:self action:@selector(loginTap) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateDisabled];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:Main_Color_Gold forState:UIControlStateNormal];
        _loginBtn.enabled=NO;
        [WFFunctions WFUIaddbordertoView:_loginBtn radius:WFCGFloatY(41/2) width:0 color:[UIColor clearColor]];
        _loginBtn.titleLabel.font = SYSTEMFONT(16);
        @WeakSelf;
        [_loginBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            selfp.viewModel.username=selfp.phoneView.phoneTF.text;
            selfp.viewModel.password=selfp.pswView.phoneTF.text;
            [selfp.viewModel requsetLogin];
        }];
    }
    return _loginBtn;
}


-(UIButton *)registerBtn
{
    if (!_registerBtn) {
        @WeakSelf;
        _registerBtn = [[UIButton alloc]init];
        //[_registerBtn addTarget:self action:@selector(changeBtnPress) forControlEvents:UIControlEventTouchUpInside];
        [_registerBtn setTitleColor:Main_Font_Color_Gold forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = SYSTEMFONT(13);
        [_registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        _registerBtn.frame = WFCGRectMake(303, 431, 58, 15);
        [_registerBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            Class class=NSClassFromString(@"YNRegisterVC");
            UIViewController* vc=[[class alloc] init];
            [selfp.navigationController pushViewController:vc animated:YES];
        }];
    }
    return _registerBtn;
}

-(UIButton *)findPswBtn
{
    if (!_findPswBtn) {
        _findPswBtn = [[UIButton alloc]init];
        _findPswBtn.frame = WFCGRectMake(13, 431, 65, 15);
       // [_findPswBtn addTarget:self action:@selector(findPress) forControlEvents:UIControlEventTouchUpInside];
        [_findPswBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_findPswBtn setTitleColor:Main_Font_Color_Gold forState:UIControlStateNormal];
        _findPswBtn.titleLabel.font = SYSTEMFONT(14);
    }
    return _findPswBtn;
}

-(UIImageView *)logoIV
{
    if (!_logoIV) {
        _logoIV=[[UIImageView alloc] init];
        _logoIV.image=[UIImage imageNamed:@"login_logo"];
        _logoIV.width=_logoIV.image.size.width;
        _logoIV.height=_logoIV.image.size.height;
        _logoIV.x=(SCREEN_WIDTH-_logoIV.width)/2;
        _logoIV.y=WFCGFloatY(75);
        
    }
    return _logoIV;
}
-(YNLoginTxView *)phoneView
{
    if (!_phoneView) {
        _phoneView=[[YNLoginTxView alloc] initWithFrame:WFCGRectMake(0, 222, 375, 53) image:@"login_mobile" type:1];
        _phoneView.backgroundColor=[UIColor whiteColor];
        _phoneView.phoneTF.placeholder=@"请输入手机号";
        _phoneView.phoneTF.delegate=self;
    }
    return _phoneView;
}
-(YNLoginTxView *)pswView
{
    if (!_pswView) {
        _pswView=[[YNLoginTxView alloc] initWithFrame:WFCGRectMake(0, 278, 375, 53) image:@"login_psw" type:2];
        _pswView.backgroundColor=[UIColor whiteColor];
        _pswView.phoneTF.placeholder=@"请输入登录密码";
        _pswView.phoneTF.secureTextEntry=YES;
        _pswView.phoneTF.keyboardType=UIKeyboardTypeDefault;
        _pswView.phoneTF.delegate=self;
    }
    return _pswView;
}

#pragma mark - event
-(void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - method
-(void)initilization
{
    @WeakSelf;
    [self setNavgationTheme:2];

    [self setBacKBarButtonWithTitle:@"yellow_back" titleColor:nil withBlock:^{
        [selfp dismissViewControllerAnimated:YES completion:nil];
    }];
    self.view.backgroundColor=[UIColor whiteColor];
    [self viewModelBand];
    [self.view addSubview:self.logoIV];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.pswView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.findPswBtn];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.QQBtn];
    [self.view addSubview:self.WXBtn];
    [self.view addSubview:self.btoIV];
}
-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"loginInfoModel";
    saleOber.observation=[YNLoginViewModel shareInterface];
    saleOber.handler = ^(NSString *keyPath) {
        [selfp dismissViewControllerAnimated:YES completion:nil];
    };
    [self registObservation:saleOber];

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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.phoneView.phoneTF.text.length>0&&self.pswView.phoneTF.text.length>6) {
        self.loginBtn.enabled=YES;
    }else
    {
        self.loginBtn.enabled=NO;
    }
    return YES;
}

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
