//
//  YNMineVC.m
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

#import "YNMineVC.h"
#import "Head.h"
#import "YNMineViewModel.h"
#import "YNMineListCell.h"
#import "YNmineTopCell.h"
@interface YNMineVC ()
@property(nonatomic,strong)YNMineViewModel* viewModel;
@end

@implementation YNMineVC
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
    self.navigationItem.title = @"";
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setNavgationTheme:2];
    UIButton* MesBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* btnImage=[UIImage imageNamed:@"mine_setting"];
    [MesBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    MesBtn.width=btnImage.size.width;
    MesBtn.height=btnImage.size.width;
    MesBtn.x=SCREEN_WIDTH-MesBtn.width-20;
    MesBtn.y=(44-MesBtn.height)/2;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:MesBtn];;
    
    self.baseTable.contentInset = UIEdgeInsetsMake(0, 0, [self bottomShelterHeight], 0);
    self.view.backgroundColor = Main_Color_BG;
    [self.baseTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.baseTable setSeparatorColor:Main_Color_BG];
    [self.view addSubview:self.baseTable];
    
    [self viewModelBand];
    
    self.baseTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if ([YNLoginViewModel shareInterface].isLogin) {
            [[YNMineViewModel shareInterface] requestData];
        }
    }];
}
-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"infoModel";
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if ([YNLoginViewModel shareInterface].isLogin) {
        [[YNMineViewModel shareInterface] requestData];
    }
}

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
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1) {
        return 6;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakSelf;
    if (indexPath.section==1)
    {
        static NSString* identify=@"ppPPhonecell";
        YNMineListCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[YNMineListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray* tileArr=@[@"我的共享医械",@"我的兔子陪诊",@"我的健康上门",@"我的医生锦囊",@"我的健康游民",@"我的银行卡"];
        [cell settitle:tileArr[indexPath.row] iamge:[NSString stringWithFormat:@"mine_one_%ld",indexPath.row]];
        
        return cell;
    }
    if (indexPath.section==2)
    {
        static NSString* identify=@"pp222Phonecell";
        YNMineListCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[YNMineListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray* tileArr=@[@"我的反馈",@"雅恩客服热线"];
        [cell settitle:tileArr[indexPath.row] iamge:[NSString stringWithFormat:@"mine_two_%ld",indexPath.row]];
        
        return cell;
    }
    if (indexPath.row==0)
    {
        static NSString* identify=@"KOhj";
        YNmineTopCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[YNmineTopCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        
        [cell setModel:[YNMineViewModel shareInterface].infoModel];
        
        return cell;
    }
    static NSString* identify=@"ppPKPhonecell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell.contentView removeAllSubviews];
    NSArray* titleArr=@[@"余额(元)",@"押金(元)"];
    for (int i=0; i<2; i++)
    {
        UILabel* titleLab=[UILabel new];
        titleLab.x=SCREEN_WIDTH/2*i;
        titleLab.y=WFCGFloatY(0);
        titleLab.width=SCREEN_WIDTH/2;
        titleLab.height=WFCGFloatY(60);
        titleLab.textColor=HEXCOLOR(@"#444444");
        titleLab.font=SYSTEMFONT(16);
        [cell.contentView addSubview:titleLab];
        titleLab.textAlignment=NSTextAlignmentCenter;
        titleLab.numberOfLines=2;
        titleLab.text=[NSString stringWithFormat:@"588\n%@",titleArr[i]];
        titleLab.tag=700+i;
        [titleLab addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
            if (tag==700)
            {
                Class class=NSClassFromString(@"YNMineBalanceVC");
                if (class) {
                    UIViewController* vc=[[class alloc] init];
                    [selfp.navigationController pushViewController:vc animated:YES];
                }
            }

        }];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return WFCGFloatY(194);
        }
        return WFCGFloatY(60);
    }
    return WFCGFloatY(51);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view=[UIView new];
    view.backgroundColor=HEXCOLOR(@"#F1F1F1");
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WFCGFloatY(15);
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
