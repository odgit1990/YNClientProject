//
//  YNRegisterVC.m
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

#import "YNRegisterVC.h"

#import "Head.h"
#import "YNLoginTxView.h"
#import "YNLoginViewModel.h"
@interface YNRegisterVC ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView* logoIV;
@property(nonatomic,strong)YNLoginTxView* phoneView;

@property(nonatomic,strong)UIButton* loginBtn;

@end

@implementation YNRegisterVC
#pragma mark - getter and setter

-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.frame = WFCGRectMake(36, 371, 303, 41);
        // [_loginBtn addTarget:self action:@selector(loginTap) forControlEvents:UIControlEventTouchUpInside];
        [_loginBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateDisabled];
        [_loginBtn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:Main_Color_Gold forState:UIControlStateNormal];
        [WFFunctions WFUIaddbordertoView:_loginBtn radius:WFCGFloatY(41/2) width:0 color:[UIColor clearColor]];
        _loginBtn.titleLabel.font = SYSTEMFONT(16);
        @WeakSelf;
        [_loginBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            if ([WFFunctions WFStrCheckEmpty:selfp.phoneView.phoneTF.text]) {
                [FTIndicator showErrorWithMessage:@"请输入手机号"];
            }else
            {
                [YNLoginViewModel shareInterface].registerPhone=selfp.phoneView.phoneTF.text;
                NSMutableDictionary* para=[NSMutableDictionary new];
                [para setObject:selfp.phoneView.phoneTF.text forKey:@"username"];
                [[YNLoginViewModel shareInterface] requestGetCode:para];
            }
        }];
    }
    return _loginBtn;
}



-(UIImageView *)logoIV
{
    if (!_logoIV) {
        _logoIV=[[UIImageView alloc] init];
        _logoIV.image=[UIImage imageNamed:@"login_logo"];
        _logoIV.width=_logoIV.image.size.width;
        _logoIV.height=_logoIV.image.size.height;
        _logoIV.x=(SCREEN_WIDTH-_logoIV.width)/2;
        _logoIV.y=WFCGFloatY(98);
    }
    return _logoIV;
}
-(YNLoginTxView *)phoneView
{
    if (!_phoneView) {
        _phoneView=[[YNLoginTxView alloc] initWithFrame:WFCGRectMake(0, 255, 375, 53) image:@"login_mobile" type:1];
        _phoneView.backgroundColor=[UIColor whiteColor];
        _phoneView.phoneTF.placeholder=@"请输入手机号";
        _phoneView.phoneTF.delegate=self;
    }
    return _phoneView;
}
#pragma mark - event
-(void)dismissVC
{
    
}
#pragma mark - method
-(void)initilization
{
    @WeakSelf;
    [self setNavgationTheme:2];
    [self setBacKBarButtonWithTitle:@"yellow_back" titleColor:nil withBlock:^{
       [selfp.navigationController popViewControllerAnimated:YES];;
    }];
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.logoIV];
    [self.view addSubview:self.phoneView];
    [self.view addSubview:self.loginBtn];
    [self viewModelBand];
}

-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"success";
    saleOber.observation=[YNLoginViewModel shareInterface];
    saleOber.handler = ^(NSString *keyPath) {
        if ([YNLoginViewModel shareInterface].success)
        {
            [[NSNotificationCenter defaultCenter]removeObserver:selfp];
            for (GCBaseObservationModel *observation in [selfp.observationSource allValues]) {
                [observation removeFrom:selfp];
            }
            [selfp.observationSource removeAllObjects];
            
            Class class=NSClassFromString(@"YNAuthCodeVC");
            if (class) {
                UIViewController* vc=[[class alloc] init];
                [selfp.navigationController pushViewController:vc animated:YES];
            }
            [[NSNotificationCenter defaultCenter]removeObserver:self];
        }
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
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (self.phoneView.phoneTF.text.length>0&&self.pswView.phoneTF.text.length>6) {
//        self.loginBtn.enabled=YES;
//    }else
//    {
//        self.loginBtn.enabled=NO;
//    }
//    return YES;
//}

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
