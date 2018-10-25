//
//  HealthPeoPleVC.m
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

#import "HealthPeoPleVC.h"
#import "Head.h"
#import "HealthPeoPleViewModel.h"
#import "YNHealthPeoCell.h"
#import "YNHealthPeoHeaderView.h"
#import "YNHealthPubDrugVC.h"
#import "YNHealthDrugDetailVC.h"
@interface HealthPeoPleVC ()
@property(nonatomic,strong)UIView* titleView;
@property(nonatomic,strong)HealthPeoPleViewModel* viewModel;
@property(nonatomic,strong)UIImageView* locIV;
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UILabel* titLab;
@property(nonatomic,strong)YNHealthPeoHeaderView* headerView;
@end

@implementation HealthPeoPleVC
#pragma mark - getter and setter
-(YNHealthPeoHeaderView *)headerView
{
    @WeakSelf;
    if (!_headerView) {
        _headerView=[[YNHealthPeoHeaderView alloc] init];
        _headerView.y=[self topShelterHeight];
        _headerView.handler = ^(NSString * _Nonnull passID) {
            if ([passID isEqualToString:@"-1"])
            {
                selfp.viewModel.orderBy=@"1";
            }else if ([passID isEqualToString:@"-2"])
            {
                selfp.viewModel.orderBy=@"2";
            }else
            {
                selfp.viewModel.typeID=passID;
                [selfp reloadListData];
            }
            
        };
    }
    return _headerView;
}



-(HealthPeoPleViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel=[HealthPeoPleViewModel new];
    }
    return _viewModel;
}
-(UILabel *)titLab
{
    if (!_titLab) {
        _titLab = [[UILabel alloc] init];
        _titLab.font = [UIFont systemFontOfSize:16];
        _titLab.textColor = HEXCOLOR(@"#999999");
        _titLab.text = @"济南";
        _titLab.textAlignment=NSTextAlignmentCenter;
        _titLab.height=44;
        _titLab.y=0;
    }
    return _titLab;
}
-(UIImageView *)locIV
{
    if (!_locIV)
    {
        _locIV=[[UIImageView alloc] init];
        _locIV.image = [UIImage imageNamed:@"title_loc"];
        _locIV.width = _locIV.image.size.width;
        _locIV.height = _locIV.image.size.height;
        _locIV.x=0;
        _locIV.y=(44-_locIV.height)/2;
        
    }
    return _locIV;
}
-(UIImageView *)markIV
{
    if (!_markIV)
    {
        _markIV=[[UIImageView alloc] init];
        _markIV.image = [UIImage imageNamed:@"ha_down_mark"];
        _markIV.width = _markIV.image.size.width;
        _markIV.height = _markIV.image.size.height;
        _markIV.y=(44-_markIV.height)/2;
    }
    return _markIV;
}

-(UIView *)titleView
{
    if (!_titleView) {
        _titleView=[UIView new];
        _titleView.height=44;
        _titleView.y=0;
    }
    return _titleView;
}
#pragma mark - event
#pragma mark - method
-(void)loadTitleView
{
    _titLab.text=@"澳门特别行政区";
    CGSize temSize=[WFFunctions WFStrGetSize:_titLab.text width:WFCGFloatX(150) font:SYSTEMFONT(16)];
    _titLab.x=_locIV.width+10;
    _titLab.width=temSize.width;
    _markIV.x=_titLab.x+_titLab.width+10;
    _titleView.width=_markIV.x+_markIV.width;
    _titleView.x=(SCREEN_WIDTH-_titleView.width)/2;
}
#pragma mark - method
-(void)initilization
{

    
    self.isGroup = YES;
    @WeakSelf;
    self.navigationItem.title = @"";
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self.navigationController.navigationBar addSubview:self.titleView];
    [self.titleView addSubview:self.locIV];
    [self.titleView addSubview:self.titLab];
    [self.titleView addSubview:self.markIV];
    [self loadTitleView];
    
    [self setRightBarButtonWithTitle:@"发布" titleColor:HEXCOLOR(@"#333333") withBlock:^{

        YNHealthPubDrugVC *vc = [[YNHealthPubDrugVC alloc]init];
        vc.passTypeArr=selfp.viewModel.typeData;
        [selfp.navigationController pushViewController:vc animated:YES];
    }];
    
    
    self.baseTable.contentInset = UIEdgeInsetsMake([self topShelterHeight]+WFCGFloatY(160), 0, [self bottomShelterHeight], 0);
    self.view.backgroundColor = Main_Color_BG;
    
    [self.view addSubview:self.baseTable];
    [self.baseTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.baseTable setSeparatorColor:Main_Color_BG];
    
    [self viewModelBand];
    
    [self reloadData];
    
    
    self.baseTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfp reloadData];
        [selfp.baseTable.mj_header endRefreshing];
    }];
    [self.view addSubview:self.headerView];

}
-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"typeData";
    saleOber.observation=self.viewModel;
    saleOber.handler = ^(NSString *keyPath) {
        if (selfp.viewModel.typeData.count!=0)
        {
            [selfp.headerView setPassData:selfp.viewModel.typeData];
            
        }
    };
    [self registObservation:saleOber];
    
    GCBaseObservationModel* saleOber1=[GCBaseObservationModel new];
    saleOber1.keyPath=@"datas";
    saleOber1.observation=self.viewModel;
    saleOber1.handler = ^(NSString *keyPath) {
        [selfp.baseTable reloadData];
    };
    [self registObservation:saleOber1];
}
-(void)reloadListData
{
    NSMutableDictionary* para=[NSMutableDictionary new];
    [para setObject:@"117.119999" forKey:@"lng"];
    [para setObject:@"36.651216" forKey:@"lat"];
    [para setObject:@"1" forKey:@"orderby"];
    [para setObject:@"1" forKey:@"page"];
    [para setObject:[WFFunctions WFCheckEmptyBackStr:self.viewModel.typeID] forKey:@"cate_id"];
    [self.viewModel requestData:para];
}
-(void)reloadData
{
    [self.viewModel requestType];
    [self reloadListData];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.viewModel.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakSelf;
    static NSString* identify=@"ppPhonecell";
    YNHealthPeoCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[YNHealthPeoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell setModel:self.viewModel.datas[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WFCGFloatY(128);
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
    view.backgroundColor=[UIColor whiteColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YNDrugListModel*model= self.viewModel.datas[indexPath.row];
    YNHealthDrugDetailVC* vc=[[YNHealthDrugDetailVC alloc] init];
    vc.passID=model.id;
    vc.information=@{@"url":[NSString stringWithFormat:@"https://api.yannihealth.com/h5/drugboxinfo?keyid=%@",model.id]};
    [self.navigationController pushViewController:vc animated:YES];
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
