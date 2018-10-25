//
//  YNHomeVC.m
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

#import "YNHomeVC.h"
#import "Head.h"
#import "YNHomeViewModel.h"
#import "TNHomeMainItemView.h"
#import "YNHomeSectionView.h"
#import "YNHomeDocCell.h"
#import "YNHomeBlogCell.h"
#import "YNHomeCollectView.h"
#import "GCBaseWebVC.h"
@interface YNHomeVC ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)YNHomeViewModel* viewModel;
@property(nonatomic,strong)YNHomeCollectView* homeCollectView;
@property(nonatomic,strong)UILabel *cityLab;
@property(nonatomic,strong)UIImageView *searchv;
@property(nonatomic,strong)UIButton* MesBtn;
@property(nonatomic,strong)UIImageView *lcIV;
@end

@implementation YNHomeVC
#pragma mark - getter and setter
-(UIButton *)MesBtn
{
    @WeakSelf;
    if (!_MesBtn)
    {
         _MesBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* btnImage=[UIImage imageNamed:@"home_mes_white"];
        [_MesBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _MesBtn.width=btnImage.size.width;
        _MesBtn.height=btnImage.size.width;
        _MesBtn.x=SCREEN_WIDTH-_MesBtn.width-20;
        _MesBtn.y=(44-_MesBtn.height)/2;
        [_MesBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [[GCPresenter shareInterface] loadLogin];;
        }];
    }
    return _MesBtn;
}
-(UIImageView *)searchv
{
    if (!_searchv)
    {
        @WeakSelf;
        _searchv= [[UIImageView alloc]init];
        [_searchv setFrame:CGRectMake(84, 5, WF_SCREEN_WIDTH - 60-84, 30)];
        _searchv.backgroundColor = [UIColor whiteColor];
        [WFFunctions WFUIaddbordertoView:_searchv radius:15 width:0 color:[UIColor clearColor]];
        [_searchv addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
            
        }];
        
        UIImageView *locationIV=[[UIImageView alloc] init];
        locationIV.image = [UIImage imageNamed:@"search_icon"];
        locationIV.x = 17;
        locationIV.y = 7;
        locationIV.width = 17;
        locationIV.height = 17;
        [_searchv addSubview:locationIV];
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.x = 43;
        titleLab.y = 0;
        titleLab.width = 200;
        titleLab.height = 30;
        titleLab.font = [UIFont systemFontOfSize:12];
        titleLab.textColor = HEXCOLOR(@"#999999");
        titleLab.text = @"探索";
        [_searchv addSubview:titleLab];
    }
    return _searchv;
}
-(UILabel *)cityLab
{
    if (!_cityLab) {
        _cityLab = [[UILabel alloc] init];
        _cityLab.x =36;
        _cityLab.y = 0;
        _cityLab.width = 50;
        _cityLab.height = 44;
        _cityLab.font = [UIFont systemFontOfSize:16];
        _cityLab.textColor = [UIColor whiteColor];
        _cityLab.text = @"济南";
    }
    return _cityLab;
}
-(UIImageView *)lcIV
{
    if (!_lcIV)
    {
        _lcIV=[[UIImageView alloc] init];
        _lcIV.image = [UIImage imageNamed:@"home_loc_white"];
        _lcIV.width = _lcIV.image.size.width;
        _lcIV.height = _lcIV.image.size.height;
        _lcIV.x = 17;
        _lcIV.y = (44-_lcIV.height)/2;
    }
    return _lcIV;
}
-(YNHomeCollectView *)homeCollectView
{
    if (!_homeCollectView) {
        @WeakSelf;
        _homeCollectView=[[YNHomeCollectView alloc] initWithFrame:WFCGRectMake(0, 0, 375, 500)];
        _homeCollectView.backgroundColor=[UIColor grayColor];
        _homeCollectView.handler = ^(NSInteger index) {
            for (NSDictionary* dic in selfp.viewModel.itemArr)
            {
                if ([[dic objectForKey:@"floorType"] isEqualToString:@"luntan"])
                {
                    NSArray* arr=[dic objectForKey:@"contentList"];
                    GCBaseWebVC* vc=[[GCBaseWebVC alloc] init];
                    vc.information=@{@"url":[WFFunctions WFCheckEmptyBackStr:[[arr objectAtIndex:index] objectForKey:@"linkTo"]]};
                    [selfp.navigationController pushViewController:vc animated:YES];
                }
            }
        };
        
    }
    return _homeCollectView;
}
-(YNHomeViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel=[YNHomeViewModel new];
    }
    return _viewModel;
}
#pragma mark - event
-(void)loadTitleV
{
    UIView *titleV = [[UIView alloc]init];
    [titleV setFrame:CGRectMake(0, 0, WF_SCREEN_WIDTH, 44)];
    [titleV setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar addSubview:titleV];
    [titleV addSubview:self.searchv];
    [titleV addSubview:self.lcIV];
    [titleV addSubview:self.cityLab];
    [titleV addSubview:self.MesBtn];
    

}
#pragma mark - method
-(void)initilization
{
    self.isGroup=YES;
    self.navigationItem.title = @"";
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self loadTitleV];
    

    self.baseTable.contentInset = UIEdgeInsetsMake(0, 0, [self bottomShelterHeight], 0);
    self.view.backgroundColor = Main_Color_BG;
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.isGroup = YES;
    [self.view addSubview:self.baseTable];
    [self.baseTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.baseTable setSeparatorColor:Main_Color_BG];
    
    [self viewModelBand];
    
    [self reloadData];
    
    @WeakSelf;
    self.baseTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [selfp reloadData];
        [selfp.baseTable.mj_header endRefreshing];
    }];
}
-(void)viewModelBand
{
    @WeakSelf;
    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
    saleOber.keyPath=@"datas";
    saleOber.observation=self.viewModel;
    saleOber.handler = ^(NSString *keyPath) {
        for (NSDictionary* dic in selfp.viewModel.itemArr)
        {
            if ([[dic objectForKey:@"floorType"] isEqualToString:@"luntan"])
            {
               NSArray* arr=[dic objectForKey:@"contentList"];
                [selfp.homeCollectView setDataSource:[NSMutableArray arrayWithArray:arr]];
            }
        }
       
        [selfp.baseTable reloadData];
    };
    [self registObservation:saleOber];
}
-(void)reloadData
{
    NSMutableDictionary* para=[NSMutableDictionary new];
    [para setObject:@"济南" forKey:@"city"];
    [para setObject:@"0" forKey:@"lng"];
    [para setObject:@"0" forKey:@"lat"];
    [self.viewModel requestData:para];
}
-(void)reloadView
{
    
}
#pragma mark - life
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar lt_reset];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    float floatY=self.baseTable.contentOffset.y;
    float myAlpha= floatY/[self topShelterHeight];
    if (myAlpha>=1)
    {
        myAlpha=0.8;
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    }else
    {
        [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    }
    [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:myAlpha]];
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
    
    return 2+self.viewModel.itemArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1)
    {
        return 1;
    }

    NSDictionary* dic=[self.viewModel.itemArr objectAtIndex:section-2];
    if ([[dic objectForKey:@"floorType"] isEqualToString:@"luntan"])
    {
        return 1;
    }
    NSArray* arr=[dic objectForKey:@"contentList"];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakSelf;
    if (indexPath.section==0)
    {
        static NSString *CellID = @"CellID";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=HEXCOLOR(@"#F7F7F7");
        }
        
        [cell.contentView removeAllSubviews];
        
        SDCycleScrollView* bannerScroll=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WFCGFloatX(375), WFCGFloatY(208)) delegate:self placeholderImage:DefaultImage];
        bannerScroll.backgroundColor=Main_Color_BGLightGray;
        bannerScroll.currentPageDotColor=Main_Color_Gold;
        bannerScroll.pageDotColor=[UIColor whiteColor];
        bannerScroll.pageControlBottomOffset=5;
        [cell.contentView addSubview:bannerScroll];
        NSMutableArray* imageArr=[[NSMutableArray alloc] init];
        NSArray* arr=[[self.viewModel.datas objectForKey:@"banner"] objectForKey:@"contentList"];
        for (NSDictionary* dic in arr) {
            [imageArr addObject:[dic objectForKey:@"image"]];
        }
        bannerScroll.imageURLStringsGroup=imageArr;
        
        return cell;
        
    }
    
    if (indexPath.section==1)
    {
        static NSString* identify=@"ppPhonecell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell.contentView removeAllSubviews];
        
        NSArray* arr=[[self.viewModel.datas objectForKey:@"main_business"] objectForKey:@"contentList"];
        
        for (int i=0; i<arr.count; i++)
        {
            TNHomeMainItemView* view=[[TNHomeMainItemView alloc] initWithFrame:CGRectMake(WFCGFloatX(18)+WFCGFloatX(180)*(i%2), WFCGFloatY(10)+WFCGFloatY(105)*(i/2), WFCGFloatX(160), WFCGFloatY(90)) withPara:arr[i] index:i];
            [WFFunctions WFUIaddbordertoView:view radius:5 width:0 color:[UIColor clearColor]];
            [cell.contentView addSubview:view];
            [view addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
                Class class = NSClassFromString(@"YNRabbitHomeVC");
                if (class) {
                    UIViewController *vc = [[class alloc]init];
                    [selfp.navigationController pushViewController:vc animated:YES];
                }
            }];
        }
        return cell;
    }
    
    NSDictionary* dic=[self.viewModel.itemArr objectAtIndex:indexPath.section-2];
    NSArray* arr=[dic objectForKey:@"contentList"];
    if ([[dic objectForKey:@"floorType"] isEqualToString:@"luntan"])
    {
        static NSString* identify=@"PPthreePhonecePPll";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell.contentView addSubview:self.homeCollectView];
        
        return cell;
    }

    static NSString* identify=@"PPthreePhonecell";
    YNHomeDocCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[YNHomeDocCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }

    [cell setSourceDic:arr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return WFCGFloatY(208);
    }
    if (indexPath.section==1) {
        return WFCGFloatY(214);
    }
    
    if (self.viewModel.itemArr.count!=0)
    {
        NSDictionary* dic=[self.viewModel.itemArr objectAtIndex:indexPath.section-2];
        if ([[dic objectForKey:@"floorType"] isEqualToString:@"luntan"])
        {
            return WFCGFloatY(500);
        }
         return WFCGFloatY(134);
    }

    return WFCGFloatY(234);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view=[[UIView alloc] init];
    view.backgroundColor=[UIColor whiteColor];
    
    if (section!=0&&section!=1)
    {
        NSDictionary* dic=[self.viewModel.itemArr objectAtIndex:section-2];
        
        YNHomeSectionView* Secview=[[YNHomeSectionView alloc] initWithFrame:WFCGRectMake(0, 0, 375, 41) withTitle:[dic objectForKey:@"floorTitle"]];
        Secview.backgroundColor=[UIColor whiteColor];
        [view addSubview:Secview];
        
    }
    
    
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section==1){
        return .0001f;
    }
    return WFCGFloatY(41);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* view=[UIView new];
    view.backgroundColor=Main_Color_BGLightGray;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WFCGFloatY(10);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewModel.itemArr.count!=0)
    {
        NSDictionary* dic=[self.viewModel.itemArr objectAtIndex:indexPath.section-2];
        NSArray* arr=[dic objectForKey:@"contentList"];
        GCBaseWebVC* vc=[[GCBaseWebVC alloc] init];
        vc.information=@{@"url":[WFFunctions WFCheckEmptyBackStr:[[arr objectAtIndex:indexPath.row] objectForKey:@"linkTo"]]};
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    
    float floatY=scrollView.contentOffset.y;
    float myAlpha= floatY/[self topShelterHeight];
    if (scrollView==self.baseTable)
    {
        if (myAlpha>=1) {
            myAlpha=0.8;
        }
        [self.navigationController.navigationBar lt_setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:myAlpha]];
        if (myAlpha>=0.8)
        {
            [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
            [self.MesBtn setBackgroundImage:[UIImage imageNamed:@"home_mes_gray"] forState:UIControlStateNormal];
            self.lcIV.image=[UIImage imageNamed:@"home_loc_gray"];
            self.cityLab.textColor=YN_Light_Black_Color;
            [WFFunctions WFUIaddbordertoView:self.searchv radius:15 width:0.5 color:HEXCOLOR(@"#CCCCCC")];
        }else
        {
            [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
            [self.MesBtn setBackgroundImage:[UIImage imageNamed:@"home_mes_white"] forState:UIControlStateNormal];
            self.lcIV.image=[UIImage imageNamed:@"home_loc_white"];
            self.cityLab.textColor=[UIColor whiteColor];
            [WFFunctions WFUIaddbordertoView:self.searchv radius:15 width:0 color:HEXCOLOR(@"#CCCCCC")];
        }
    }
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
