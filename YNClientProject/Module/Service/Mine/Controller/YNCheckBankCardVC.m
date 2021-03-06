//
//  YNCheckBankCardVC.m
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

#import "YNCheckBankCardVC.h"

#import "YNGetMoneyCell.h"
#import "Head.h"
#import "YNMineViewModel.h"
@interface YNCheckBankCardVC ()

@property(nonatomic,strong)YNMineViewModel* viewModel;
@end

@implementation YNCheckBankCardVC
#pragma mark - getter and setter
-(YNMineViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel=[YNMineViewModel new];
    }
    return _viewModel;
}
#pragma mark - event
#pragma mark - method
-(void)initilization
{
    self.isGroup = YES;
    
    
    
    @WeakSelf;
    [self setNavgationTheme:1];
    self.navigationItem.title = @"验证银行卡";
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self setRightBarButtonWithTitle:@"+" titleColor:HEXCOLOR(@"#444444") withBlock:^{
        
    }];
    //    UIButton* MesBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage* btnImage=[UIImage imageNamed:@"mine_setting"];
    //    [MesBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    //    MesBtn.width=btnImage.size.width;
    //    MesBtn.height=btnImage.size.width;
    //    MesBtn.x=SCREEN_WIDTH-MesBtn.width-20;
    //    MesBtn.y=(44-MesBtn.height)/2;
    //    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:MesBtn];;
    
    
    self.baseTable.contentInset = UIEdgeInsetsMake([self topShelterHeight], 0, [self bottomShelterHeight], 0);
    self.view.backgroundColor = Main_Color_BG;
    [self.baseTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.baseTable setSeparatorColor:Main_Color_BG];
    [self.view addSubview:self.baseTable];
    
    [self viewModelBand];
    
    [self reloadData];
    
}
-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"docArr";
    saleOber.observation=self.viewModel;
    saleOber.handler = ^(NSString *keyPath) {
        [selfp.baseTable reloadData];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* identify=@"OnePKPhonecell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell.contentView removeAllSubviews];
    
    UILabel* titleLab=[UILabel new];
    titleLab.x=WFCGFloatX(15);
    titleLab.y=WFCGFloatY(0);
    titleLab.width=WFCGFloatX(50);
    titleLab.height=WFCGFloatY(52);
    titleLab.textColor=HEXCOLOR(@"#171717");
    titleLab.font=SYSTEMFONT(15);
    [cell.contentView addSubview:titleLab];
    titleLab.text=indexPath.row==0?@"持卡人":indexPath.row==1?@"卡号":@"手机号";
    
    
    UITextField* detailTF=[[UITextField alloc] init];
    detailTF.x=WFCGFloatX(93);
    detailTF.y=WFCGFloatY(0);
    detailTF.width=WFCGFloatX(260);
    detailTF.height=WFCGFloatY(52);
    detailTF.font=SYSTEMFONT(15);
    detailTF.textColor=HEXCOLOR(@"#333333");
    detailTF.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:detailTF];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WFCGFloatY(52);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view=[UIView new];
    view.backgroundColor=HEXCOLOR(@"#F1F1F1");
    
    UILabel* titleLab=[UILabel new];
    titleLab.x=WFCGFloatX(15);
    titleLab.y=WFCGFloatY(0);
    titleLab.width=WFCGFloatX(300);
    titleLab.height=WFCGFloatY(42);
    titleLab.textColor=HEXCOLOR(@"#666666");
    titleLab.font=SYSTEMFONT(12);
    titleLab.text=@"* 请绑定持卡人本人银行卡";
    [view addSubview:titleLab];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WFCGFloatY(42);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view=[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    
    
    UILabel* titleLab=[UILabel new];
    titleLab.x=WFCGFloatX(15);
    titleLab.y=WFCGFloatY(10);
    titleLab.width=WFCGFloatX(300);
    titleLab.height=WFCGFloatY(12);
    titleLab.textColor=Main_Font_Color_Gold;
    titleLab.font=SYSTEMFONT(12);
    titleLab.text=@"《用户协议》";
    [view addSubview:titleLab];
    
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.x=WFCGFloatX(34);
    btn.y=WFCGFloatY(70);
    btn.width=WFCGFloatX(307);
    btn.height=WFCGFloatY(41);
    [WFFunctions WFUIaddbordertoView:btn radius:WFCGFloatY(41/2) width:0 color:[UIColor clearColor]];
    [btn setBackgroundColor:Main_Color_Gold forState:UIControlStateNormal];
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateNormal];
    btn.titleLabel.font=SYSTEMFONT(18);
    [view addSubview:btn];
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return WFCGFloatY(154);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
