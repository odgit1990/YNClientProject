//
//  YNhealthDragPayVC.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/23.
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

#import "YNhealthDragPayVC.h"
#import "Head.h"
@interface YNhealthDragPayVC ()

@end

@implementation YNhealthDragPayVC
#pragma mark - getter and setter
#pragma mark - event
#pragma mark - method
-(void)initilization
{
    
    
    self.isGroup = YES;
    @WeakSelf;
    self.navigationItem.title = @"订单支付";
    self.extendedLayoutIncludesOpaqueBars = YES;

    
    
    
    self.baseTable.contentInset = UIEdgeInsetsMake([self topShelterHeight], 0, [self bottomShelterHeight]+WFCGFloatY(74), 0);
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
    
}
-(void)viewModelBand
{
//    @WeakSelf;
//    GCBaseObservationModel* saleOber=[GCBaseObservationModel new];
//    saleOber.keyPath=@"typeData";
//    saleOber.observation=self.viewModel;
//    saleOber.handler = ^(NSString *keyPath) {
//
//    };
//    [self registObservation:saleOber];
    
}
-(void)reloadListData
{
    NSMutableDictionary* para=[NSMutableDictionary new];
    [para setObject:@"117.119999" forKey:@"lng"];
    [para setObject:@"36.651216" forKey:@"lat"];
    [para setObject:@"1" forKey:@"orderby"];
    [para setObject:@"1" forKey:@"page"];

}
-(void)reloadData
{
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
    
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }

    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @WeakSelf;
    if (indexPath.section==0)
    {
        static NSString* identify=@"ppOnePhonecell";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.backgroundColor=[UIColor whiteColor];
        }
        [cell.contentView removeAllSubviews];
        
        UILabel* orderLab=[UILabel new];
        orderLab.x=WFCGFloatX(16);
        orderLab.y=WFCGFloatY(15);
        orderLab.width=WFCGFloatX(340);
        orderLab.height=WFCGFloatY(14);
        orderLab.textColor=HEXCOLOR(@"#999999");
        orderLab.font=SYSTEMFONT(12);
        [cell.contentView addSubview:orderLab];
        orderLab.text=@"订单编号:YX2018081700001";
        
        
        UILabel* PriceLab=[UILabel new];
        PriceLab.x=WFCGFloatX(0);
        PriceLab.y=WFCGFloatY(54);
        PriceLab.width=WFCGFloatX(375);
        PriceLab.height=WFCGFloatY(38);
        PriceLab.textColor=HEXCOLOR(@"#171717");
        PriceLab.font=SYSTEMFONT(36);
        [cell.contentView addSubview:PriceLab];
        PriceLab.textAlignment=NSTextAlignmentCenter;
        PriceLab.text=@"¥ 8.80";
        
        return cell;
    }
    static NSString* identify=@"ppPhonecell";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
    }

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return WFCGFloatY(115);
    }
    return WFCGFloatY(65);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view=[UIView new];
    view.backgroundColor=[UIColor whiteColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return WFCGFloatY(10);
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
