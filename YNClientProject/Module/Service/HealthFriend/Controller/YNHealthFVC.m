//
//  YNHealthFVC.m
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

#import "YNHealthFVC.h"
#import "Head.h"
#import "YNHealthFriendViewModel.h"
#import "YNHealthDocNewCell.h"
#import "YNHealthHeCell.h"
@interface YNHealthFVC ()
{
    NSInteger leftPage;
    NSInteger rigthPage;
}
@property(nonatomic,strong)YNHealthFriendViewModel* viewModel;
@property(nonatomic,strong)UIScrollView* mainScroll;
@property(nonatomic,strong)GCBaseTableView* righTtable;
@property(nonatomic,strong)UIView* topView;
@end

@implementation YNHealthFVC
#pragma mark - getter and setter
-(UIView *)topView
{
    @WeakSelf;
    if (!_topView) {
        _topView=[UIView new];
        _topView.x=0;
        _topView.y=[self topShelterHeight];
        _topView.width=SCREEN_WIDTH;
        _topView.height=WFCGFloatY(40);
        _topView.backgroundColor=[UIColor whiteColor];
        NSArray* arr=@[@"医咨询",@"健康论坛"];
        for (int i=0; i<2; i++)
        {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.x=SCREEN_WIDTH/2*i;
            btn.y=0;
            btn.width=SCREEN_WIDTH/2;
            btn.height=WFCGFloatY(40);
            [_topView addSubview:btn];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:Main_Color_Gold forState:UIControlStateSelected];
            [btn setTitleColor:HEXCOLOR(@"#171717") forState:UIControlStateNormal];
            if (i==0) {
                btn.selected=YES;
            }
            btn.tag=800+i;
            [btn addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
                [selfp setscrollIndex:tag-800];

            }];
        }
        
        UIImageView* lineIV=[UIImageView new];
        lineIV.x=(SCREEN_WIDTH/2-WFCGFloatX(70))/2;
        lineIV.y=WFCGFloatY(39);
        lineIV.width=WFCGFloatX(70);
        lineIV.height=WFCGFloatY(1);
        lineIV.tag=900;
        lineIV.backgroundColor=Main_Color_Gold;
        [_topView addSubview:lineIV];
        
    }
    return _topView;
}
-(GCBaseTableView *)righTtable
{
    @WeakSelf;
    if (!_righTtable) {
        _righTtable=[[GCBaseTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, _mainScroll.height) style:UITableViewStyleGrouped];
        _righTtable.delegate=self;
        _righTtable.dataSource=self;
        [_righTtable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        [_righTtable setSeparatorColor:Main_Color_BG];
        _righTtable.backgroundColor=[UIColor whiteColor];
        
        _righTtable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            rigthPage=1;
            [selfp reloadRightData];
        }];
        
        _righTtable.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
            if (selfp.viewModel.rightAdd)
            {
                rigthPage+=1;
                [selfp reloadRightData];
            }else
            {
                [selfp.righTtable.mj_footer endRefreshingWithNoMoreData];
            }
        }];
    }
    return _righTtable;
}
-(YNHealthFriendViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel=[YNHealthFriendViewModel new];
    }
    return _viewModel;
}
-(UIScrollView *)mainScroll
{
    if (!_mainScroll) {
        _mainScroll=[[UIScrollView alloc] init];
        _mainScroll.x=0;
        _mainScroll.y=WFCGFloatY(40)+[self topShelterHeight];;
        _mainScroll.width=SCREEN_WIDTH;
        _mainScroll.height=SCREEN_HEIGHT-[self topShelterHeight]-[self bottomShelterHeight]-WFCGFloatY(40);
        _mainScroll.contentSize=CGSizeMake(SCREEN_WIDTH*2, _mainScroll.height);
        _mainScroll.pagingEnabled=YES;
        _mainScroll.showsVerticalScrollIndicator=NO;
        _mainScroll.showsHorizontalScrollIndicator=NO;
        _mainScroll.delegate=self;
        
    }
    return _mainScroll;
}
#pragma mark - event
-(void)setscrollIndex:(NSInteger)index
{
    [self.mainScroll scrollRectToVisible:CGRectMake(SCREEN_WIDTH*index, 0, SCREEN_WIDTH, _mainScroll.height) animated:YES];
    UIButton* btn=(UIButton*)[self.topView viewWithTag:800];
    UIButton* btn1=(UIButton*)[self.topView viewWithTag:801];
    if (index==0)
    {
        btn.selected=YES;
        btn1.selected=NO;
    }else
    {
        btn.selected=NO;
        btn1.selected=YES;
    }
}
#pragma mark - method
-(void)initilization
{
    leftPage=1;
    rigthPage=1;
    
    [self.view addSubview:self.mainScroll];
    [self.mainScroll addSubview:self.baseTable];
    [self.mainScroll addSubview:self.righTtable];
    [self.view addSubview:self.topView];
    self.isGroup = YES;
    @WeakSelf;
    self.navigationItem.title = @"健康之友";
    self.extendedLayoutIncludesOpaqueBars = YES;

    
    
//    self.baseTable.contentInset = UIEdgeInsetsMake(0, 0, [self bottomShelterHeight], 0);
    self.view.backgroundColor = Main_Color_BG;
    self.baseTable.height=self.mainScroll.height;
    [self.baseTable setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.baseTable setSeparatorColor:Main_Color_BG];
    
    [self viewModelBand];
    
    [self reloadData];
    
    
    self.baseTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        leftPage=1;
        [selfp reloadLeftData];
    }];
    
    self.baseTable.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        if (selfp.viewModel.leftAdd)
        {
            leftPage+=1;
            [selfp reloadLeftData];
        }else
        {
            [selfp.baseTable.mj_footer endRefreshingWithNoMoreData];
        }
    }];
    

    
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
    
    GCBaseObservationModel* rightAaleOber=[GCBaseObservationModel new];
    rightAaleOber.keyPath=@"healthArr";
    rightAaleOber.observation=self.viewModel;
    rightAaleOber.handler = ^(NSString *keyPath) {
        [selfp.righTtable reloadData];
    };
    [self registObservation:rightAaleOber];
    

}
-(void)reloadLeftData
{
    NSMutableDictionary* para=[NSMutableDictionary new];
    [para setObject:@"1" forKey:@"cate"];
    [para setObject:[NSNumber numberWithInteger:leftPage] forKey:@"page"];
    [self.viewModel requestLeftData:para];

}
-(void)reloadRightData
{
    NSMutableDictionary* para=[NSMutableDictionary new];
    [para setObject:@"2" forKey:@"cate"];
    [para setObject:[NSNumber numberWithInteger:rigthPage] forKey:@"page"];
    [self.viewModel requestRightData:para];
    
}
-(void)reloadData
{
    [self reloadLeftData];
    [self reloadRightData];
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
    if (tableView==self.righTtable) {
        return self.viewModel.healthArr.count;
    }
    
    return self.viewModel.docArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakSelf;
    if (tableView==self.righTtable)
    {
        static NSString* identify=@"pp11Phonecell";
        YNHealthHeCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[YNHealthHeCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }

        [cell setModel:self.viewModel.healthArr[indexPath.row]];
        
        return cell;
    }
    static NSString* identify=@"ppPhonecell";
    YNHealthDocNewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[YNHealthDocNewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }
    [cell setModel:self.viewModel.docArr[indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.righTtable) {
        return WFCGFloatY(101);
    }
    return WFCGFloatY(133);
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

    YNHealthNewSModel* model=tableView==self.righTtable?[self.viewModel.healthArr objectAtIndex:indexPath.row]:[self.viewModel.docArr objectAtIndex:indexPath.row];
    GCBaseWebVC* vc=[[GCBaseWebVC alloc] init];
    vc.information=@{@"url":model.posts_url};
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.mainScroll) {
        UIImageView* line=(UIImageView*)[self.topView viewWithTag:900];
        CGFloat width = (SCREEN_WIDTH/2-WFCGFloatX(70))/2;;
        line.left = (SCREEN_WIDTH/2)*(scrollView.contentOffset.x/SCREEN_WIDTH)+width;
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_mainScroll)
    {
        [self setscrollIndex:scrollView.contentOffset.x/self.view.width];
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
