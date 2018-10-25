//
//  YNMainTabVC.m
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

#import "YNMainTabVC.h"

@interface YNMainTabVC ()
@property (nonatomic,strong) YNHomeVC *homeVC;
@property (nonatomic,strong) YNHealthFVC *healthFriendVC;
@property (nonatomic,strong) YNDoctorHelpVC *DoctorHelpVC;
@property (nonatomic,strong) HealthPeoPleVC *healthPeopleVC;
@property (nonatomic,strong) YNMineVC *mineVC;
@end

@implementation YNMainTabVC
#pragma mark - getter and setter
-(YNHomeVC *)homeVC
{
    if (!_homeVC) {
        _homeVC = [[YNHomeVC alloc] init];
        _homeVC.title = @"首页";
        _homeVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[[UIImage imageNamed:@"home_no_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"home_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
    }
    return _homeVC;
}
-(YNHealthFVC *)healthFriendVC
{
    if (!_healthFriendVC) {
        _healthFriendVC = [[YNHealthFVC alloc] init];
        _healthFriendVC.title = @"健康之友";
        _healthFriendVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"健康之友" image:[[UIImage imageNamed:@"hf_no_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"hf_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _healthFriendVC;
}
-(YNDoctorHelpVC *)DoctorHelpVC
{
    if (!_DoctorHelpVC) {
        _DoctorHelpVC = [[YNDoctorHelpVC  alloc] init];
        _DoctorHelpVC.title = @"医生锦囊";
        _DoctorHelpVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"医生锦囊" image:[[UIImage imageNamed:@"df_no_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"df_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _DoctorHelpVC;
}
-(HealthPeoPleVC *)healthPeopleVC
{
    if (!_healthPeopleVC) {
        _healthPeopleVC = [[HealthPeoPleVC  alloc] init];
        _healthPeopleVC.title = @"健康游民";
        _healthPeopleVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"健康游民" image:[[UIImage imageNamed:@"fp_no_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"hp_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _healthPeopleVC;
}
-(YNMineVC *)mineVC
{
    if (!_mineVC) {
        _mineVC = [[YNMineVC  alloc] init];
        _mineVC.title = @"我的";
        _mineVC.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我的" image:[[UIImage imageNamed:@"mine_no_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"mine_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    return _mineVC;
}
#pragma mark - event
#pragma mark - method
-(void)initilization
{
    self.tabBar.tintColor = Main_Font_Color_Gold;
    //[self.tabBar setBackgroundColor:HEXCOLOR(@"#232321")];
    self.tabBar.translucent = NO;
    //self.tabBar.barTintColor = HEXCOLOR(@"#232321");
    
    HMSNavigationController *nav1 = [[HMSNavigationController alloc]initWithRootViewController:self.homeVC];
    HMSNavigationController *nav2 = [[HMSNavigationController alloc]initWithRootViewController:self.healthFriendVC];
    HMSNavigationController *nav3 = [[HMSNavigationController alloc]initWithRootViewController:self.DoctorHelpVC];
    HMSNavigationController *nav5 = [[HMSNavigationController alloc]initWithRootViewController:self.healthPeopleVC];
    HMSNavigationController *nav4 = [[HMSNavigationController alloc]initWithRootViewController:self.mineVC];
    NSArray *views = @[nav1,nav2,nav3,nav5,nav4];
    
    self.viewControllers = views;
}
///设置小红点消息
-(void)setMessage:(NSString *)msg atIndex:(NSInteger)index
{
    if (index < self.viewControllers.count) {
        UITabBarItem *item = [self.viewControllers[index] tabBarItem];
        [item setCustomBadgeValue:msg.integerValue > 0 ? msg : nil withFont:[UIFont systemFontOfSize:13] andFontColor:Main_Color_White andBackgroundColor:Main_Color_Red];
    }
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
