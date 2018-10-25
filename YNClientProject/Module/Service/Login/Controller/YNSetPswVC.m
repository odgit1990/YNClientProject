//
//  YNSetPswVC.m
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

#import "YNSetPswVC.h"

#import "Head.h"
#import "YNPswVIew.h"
#import "YNLoginViewModel.h"
@interface YNSetPswVC ()<UITextFieldDelegate>

@property(nonatomic,strong)YNPswVIew* phoneView;
@property(nonatomic,strong)YNPswVIew* pswView;
@property(nonatomic,strong)UIButton* loginBtn;
@property(nonatomic,strong)UILabel* topLab;
@property(nonatomic,strong)UILabel* btomLab;
@property(nonatomic,strong)UILabel* titleLab;
@property(nonatomic,strong)YNLoginViewModel* viewModel;
@end

@implementation YNSetPswVC
#pragma mark - getter and setter
-(UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab=[UILabel new];
        _titleLab.y=WFCGFloatY(98);
        _titleLab.width=SCREEN_WIDTH;
        _titleLab.textColor=HEXCOLOR(@"#333333");
        _titleLab.height=WFCGFloatY(17);
        _titleLab.x=WFCGFloatX(0);
        _titleLab.font=SYSTEMFONT(17);
        _titleLab.textAlignment=NSTextAlignmentCenter;
        _titleLab.text=@"设置密码";
    }
    return _titleLab;
}
-(UILabel *)btomLab
{
    if (!_btomLab) {
        _btomLab=[UILabel new];
        _btomLab.y=WFCGFloatY(363);
        _btomLab.width=SCREEN_WIDTH;
        _btomLab.textColor=Main_Font_Color_Gold;
        _btomLab.height=WFCGFloatY(12);
        _btomLab.x=WFCGFloatX(0);
        _btomLab.font=SYSTEMFONT(11);
        _btomLab.textAlignment=NSTextAlignmentCenter;
        _btomLab.text=@"开启智健康即表示您同意《智健康服务条款及协议》";
    }
    return _btomLab;
}

-(UILabel *)topLab
{
    if (!_topLab) {
        _topLab=[UILabel new];
        _topLab.y=WFCGFloatY(257);
        _topLab.width=SCREEN_WIDTH;
        _topLab.textColor=HEXCOLOR(@"#FA1313");
        _topLab.height=WFCGFloatY(12);
        _topLab.x=WFCGFloatX(0);
        _topLab.font=SYSTEMFONT(10);
        _topLab.textAlignment=NSTextAlignmentCenter;
       // _topLab.text=[YNLoginViewModel shareInterface].registeTitle;
    }
    return _topLab;
}
-(YNLoginViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel=[YNLoginViewModel shareInterface];
    }
    return _viewModel;
}

-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.frame = WFCGRectMake(36, 304, 303, 40);
        [_loginBtn setTitle:@"开启智健康" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateDisabled];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:Main_Color_Gold forState:UIControlStateNormal];
        [WFFunctions WFUIaddbordertoView:_loginBtn radius:WFCGFloatY(40/2) width:0 color:[UIColor clearColor]];
        _loginBtn.titleLabel.font = SYSTEMFONT(16);
        [_loginBtn addTarget:self action:@selector(gotoRegister) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
-(YNPswVIew *)phoneView
{
    if (!_phoneView) {
        _phoneView=[[YNPswVIew alloc] initWithFrame:WFCGRectMake(0, 140, 375, 40)];
        _phoneView.backgroundColor=[UIColor whiteColor];
        _phoneView.inptTF.placeholder=@"输入8-16位包含数字、字母的密码";
        _phoneView.inptTF.delegate=self;
    }
    return _phoneView;
}
-(YNPswVIew *)pswView
{
    if (!_pswView) {
        _pswView=[[YNPswVIew alloc] initWithFrame:WFCGRectMake(0, 190, 375, 40)];
        _pswView.backgroundColor=[UIColor whiteColor];
        _pswView.inptTF.placeholder=@"输入8-16位包含数字、字母的密码";
        _pswView.inptTF.delegate=self;
    }
    return _pswView;
}

#pragma mark - event
-(void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)gotoRegister
{
    if ([WFFunctions WFStrCheckEmpty:self.phoneView.inptTF.text]||[WFFunctions WFStrCheckEmpty:self.pswView.inptTF.text])
    {
        [FTIndicator showErrorWithMessage:@"请输入完整密码"];
        return;
    }
    if ([WFFunctions deptNumInputShouldNumber:self.phoneView.inptTF.text]||[WFFunctions deptNumInputShouldNumber:self.pswView.inptTF.text]) {
        [FTIndicator showErrorWithMessage:@"密码不能全部为数字"];
        return;
    }
    if (![self.phoneView.inptTF.text isEqualToString:self.pswView.inptTF.text])
    {
        [FTIndicator showErrorWithMessage:@"两次输入密码不一致!"];
        return;
    }
    if (self.phoneView.inptTF.text.length>16||self.phoneView.inptTF.text.length<8)
    {
        [FTIndicator showErrorWithMessage:@"请输入8-16位包含数字、字母的密码"];
        return;
    }
    
    NSMutableDictionary* para=[NSMutableDictionary new];
    [para setObject:[YNLoginViewModel shareInterface].registerPhone forKey:@"username"];
    [para setObject:self.phoneView.inptTF.text forKey:@"password"];
    [para setObject:[YNLoginViewModel shareInterface].validateCode forKey:@"yzm"];

    [[YNLoginViewModel shareInterface] requestRegiter:para];
}
#pragma mark - method
-(void)initilization
{
    @WeakSelf;
    [self setNavgationTheme:2];
    [self viewModelBand];
    [self setBacKBarButtonWithTitle:@"yellow_back" titleColor:nil withBlock:^{
        [selfp dismissViewControllerAnimated:YES completion:nil];
    }];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.pswView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.btomLab];
    [self.view addSubview:self.topLab];
    [self.view addSubview:self.titleLab];
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
