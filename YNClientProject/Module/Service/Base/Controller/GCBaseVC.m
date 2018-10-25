//
//  GCBaseVC.m
//  CBHGroupCar
//
//  Created by mac on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
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

#import "GCBaseVC.h"
#import "Head.h"

@interface GCBaseVC ()

@property (nonatomic,assign) NSInteger navigationTheme;
@end

@implementation GCBaseVC
#pragma mark - getter and setter
-(GCBaseTableView *)baseTable
{
    if (!_baseTable) {
        
        _baseTable = [[GCBaseTableView alloc]initWithFrame:self.view.bounds style:_isGroup?UITableViewStyleGrouped:UITableViewStylePlain];
        _baseTable.delegate = self;
        _baseTable.dataSource = self;
        _baseTable.emptyDataSetDelegate = self;
        _baseTable.emptyDataSetSource = self;
        _baseTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _baseTable.showsVerticalScrollIndicator=NO;
        _baseTable.showsHorizontalScrollIndicator=NO;
        if (@available(iOS 11.0, *)) {
            _baseTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
//        UIViewController *parent = self.parentViewController.parentViewController.parentViewController;
//        UIViewController *pparent = self.parentViewController.parentViewController.parentViewController.parentViewController;
//        if ([pparent isKindOfClass:[UITabBarController class]] && parent.childViewControllers.count == 1) {
//            _baseTable.height = _baseTable.height - 49 - GY_Nav_height;
//        }
    }
    return _baseTable;
}
-(NSMutableDictionary *)observationSource
{
    if (!_observationSource) {
        _observationSource = [NSMutableDictionary new];
    }
    return _observationSource;
}

#pragma mark - event
-(void)leftBarButtonItemTap:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setBacKBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(void (^)(void))block
{
    
    
    UIImage* ppp=[UIImage imageNamed:title];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, ppp.size.width, ppp.size.height);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarButton setBackgroundImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    
    [rightBarButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        block();
    }];

    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -(10);
    self.navigationItem.leftBarButtonItem = rItem;
    
}

#pragma mark - method
-(void)initilization
{
    //
}
-(void)viewModelBand
{
    
}
-(void)reloadData
{
    
}
-(void)dissmissFTIndicatorProgress
{
    [FTIndicator dismissProgress];
}
- (void)setRightBarButtonWithTitle:(NSString *)title titleColor:(UIColor *)color withBlock:(void (^)(void))block {
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, 44 + 20, 44);
    rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBarButton setTitle:title forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = SYSTEMFONT(14);
    [rightBarButton setTitleColor:color forState:UIControlStateNormal];
    
    [rightBarButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        block();
    }];
    
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -(10);
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rItem, space, nil];
}
///
-(void)registObservation:(GCBaseObservationModel *)observation
{
    if (observation) {
        [observation.observation addObserver:self forKeyPath:observation.keyPath options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
        [self.observationSource setObject:observation forKey:observation.keyPath];
    }
}
-(void)setNavgationTheme:(NSInteger)theme
{
    _navigationTheme = theme;
}
-(void)displayNavigation
{
    [UIApplication sharedApplication].statusBarStyle = 0 == _navigationTheme ? UIStatusBarStyleDefault : UIStatusBarStyleDefault;
    
    UIImage *img = [UIImage imageNamed: 0 == _navigationTheme ? @"navbgtint" : 2==_navigationTheme?@"navbg":@"navbgtint"];
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
  //  [self.navigationController.navigationBar setBackgroundImage:_navigationTheme==0?[WFFunctions WFUICreateImageWithColor:[UIColor whiteColor]]:[WFFunctions WFUICreateImageWithColor:Main_Color_Gold] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setBackgroundColor:Main_Color_Red];
    
    UIColor *titleColor = 0 == _navigationTheme ? Main_Color_Black : _navigationTheme==2?Main_Color_Black:Main_Color_Black;
    NSDictionary *titleDict = @{NSFontAttributeName:SYSTEMFONT(18),NSForegroundColorAttributeName:titleColor};
    self.navigationController.navigationBar.titleTextAttributes = titleDict;//标题字体
    self.navigationController.navigationBar.tintColor = titleColor;//左右按钮颜色
}
-(CGFloat)topShelterHeight
{
    CGFloat safeNavHeight = WF_NAVIGATION_BAR_HEIGHT + WF_NAVIGATION_SAFE_OFFSET;
    return safeNavHeight;
}
-(CGFloat)bottomShelterHeight
{
    HMSNavigationController *nav = [HMSNavigationController hms_getNavigationController:self];
    CGFloat safeBottomOffset = WF_TAB_SAFE_OFFSET + (nav.childViewControllers.count > 1 ? 0 : WF_TAB_BAR_HEIGHT);
    return safeBottomOffset;
}

-(void)gotoMenMu
{
    FTPopOverMenuConfiguration *configuration = [FTPopOverMenuConfiguration defaultConfiguration];
    configuration.textColor = Main_Color_Black;
    configuration.tintColor = [UIColor whiteColor];
    configuration.textFont = [UIFont systemFontOfSize:15];
    configuration.shadowOpacity = 1; // Default is 0 - choose anything between 0 to 1 to show actual shadow, e.g. 0.2
    configuration.shadowRadius = 5; // Default is 5
    configuration.borderColor = HEXCOLOR(@"#D5D5D5");
    
    [FTPopOverMenu showFromSenderFrame:CGRectMake(SCREEN_WIDTH - 45, [self topShelterHeight] - 44, 30, 40) withMenuArray:@[@"首页",@"求购信息",@"我的"] imageArray:@[@"memu_home",@"memu_buy",@"memu_mine"] doneBlock:^(NSInteger selectedIndex) {
        
    } dismissBlock:^{
        
    }];
}
#pragma mark - life
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    for (GCBaseObservationModel *observation in [_observationSource allValues]) {
        [observation removeFrom:self];
    }
    [_observationSource removeAllObjects];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = Main_Color_BG;
    self.view.frame = [[UIScreen mainScreen]bounds];
    
    if (self.navigationController.navigationController.childViewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backicon"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemTap:)];
    }
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
//    self.view.height=SCREEN_HEIGHT;
    //self.view.frame=CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT);
    if (OS_VERSION < 11.0) {
//        self.view.height = self.view.height + 49;
        HMSNavigationController *nav = [HMSNavigationController hms_getNavigationController:self];
        self.view.height = self.view.height + (nav.childViewControllers.count > 1 ? 49 : 0);
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self displayNavigation];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    GCBaseObservationModel *observation = _observationSource[keyPath];
    if (observation) {
        observation.handler(keyPath);
    }
}
#pragma mark - delegate
#pragma mark - table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UITableViewCell new];
}
-(void)tableView:(UITableView* )tableView willDisplayCell:(UITableViewCell* )cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}
#pragma mark - empty delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:SYSTEMFONT(20),
                                 NSForegroundColorAttributeName:Main_Color_Gray
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *buttonTitle = @"点击刷新";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:SYSTEMFONT(14),
                                 NSForegroundColorAttributeName:Main_Color_LightGray
                                 };
    return [[NSAttributedString alloc] initWithString:buttonTitle attributes:attributes];
}

-(void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    [self.baseTable.mj_header beginRefreshing];
}
-(void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self.baseTable.mj_header beginRefreshing];
}
#pragma mark - responder
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
