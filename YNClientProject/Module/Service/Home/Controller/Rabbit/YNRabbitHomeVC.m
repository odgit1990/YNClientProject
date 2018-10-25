//
//  YNRabbitHomeVC.m
//  YNClientProject
//
//  Created by 雅恩三河科技 on 2018/10/22.
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

#import "YNRabbitHomeVC.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Head.h"
#import "YNRabbitPubView.h"
@interface YNRabbitHomeVC ()<MKMapViewDelegate>
{
    UIView            *   uiView;
    CLLocationManager *   locationManager;
    MKMapView         *   maMapView;
    MKAnnotationView  *   annotationView;
}
@property(nonatomic,strong)UIImageView* btomBtnView;
@property(nonatomic,strong)UIView* titleView;
@property(nonatomic,strong)UIImageView* locIV;
@property(nonatomic,strong)UIImageView* markIV;
@property(nonatomic,strong)UILabel* titLab;
@end

@implementation YNRabbitHomeVC
#pragma mark - getter and setter

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

- (UIImageView *)btomBtnView
{
    @WeakSelf;
    if (!_btomBtnView) {
        _btomBtnView=[UIImageView new];
        _btomBtnView.x=WFCGFloatX(10);
        _btomBtnView.y=SCREEN_HEIGHT-WFCGFloatY(120)-[self topShelterHeight];
        _btomBtnView.image=[UIImage imageNamed:@"home_habit_bg"];
        _btomBtnView.width=_btomBtnView.image.size.width;
        _btomBtnView.height=_btomBtnView.image.size.height;
        
        
        UILabel* timeLab=[UILabel new];
        timeLab.y=WFCGFloatY(0);
        timeLab.width=WFCGFloatX(70);
        timeLab.textColor=HEXCOLOR(@"#171717");
        timeLab.height=_btomBtnView.height;
        timeLab.x=WFCGFloatX(58);
        timeLab.font=SYSTEMFONT(15);
        timeLab.text=@"我要陪诊";
        [_btomBtnView addSubview:timeLab];
        
        
        UIImageView* markIV=[UIImageView new];
        markIV.image=[UIImage imageNamed:@"ha_mark"];
        markIV.width=markIV.image.size.width;
        markIV.height=markIV.image.size.height;
        markIV.x=_btomBtnView.width-markIV.image.size.width-15;
        markIV.y=(_btomBtnView.height-markIV.height)/2;
        [_btomBtnView addSubview:markIV];
        
        [_btomBtnView addTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
            YNRabbitPubView *countv = [YNRabbitPubView new];
            
            TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:countv preferredStyle:TYAlertControllerStyleActionSheet];

            alertController.backgoundTapDismissEnable = YES;
            [selfp presentViewController:alertController animated:YES completion:nil];
        }];
        
    }
    return _btomBtnView;
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
-(void) initMap
{
    maMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-[self bottomShelterHeight]-[self topShelterHeight])];
    [self.view addSubview:maMapView];
    //设置代理
    maMapView.delegate=self;
    //请求定位服务
    locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [locationManager requestWhenInUseAuthorization];
    }
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    maMapView.userTrackingMode = MKUserTrackingModeFollow;
    //设置地图类型
    maMapView.mapType=MKMapTypeStandard;
    //添加大头针
    [self addAnnotation];
    [self.view addSubview:self.btomBtnView];
}

-(void)addAnnotation{
    
//    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(destinationMode.destinationLatitude.floatValue, destinationMode.destinationLongitude.floatValue);
//
//    QYAnnotation *annotation1=[[QYAnnotation alloc]init];
//    annotation1.title= destinationMode.destinationName;
//    annotation1.subtitle= destinationMode.destinationDesc;
//    annotation1.coordinate=location1;
//
//    [maMapView setCenterCoordinate:location1 zoomLevel:10 animated:NO];
//    [maMapView addAnnotation:annotation1];
//    [maMapView selectAnnotation:annotation1 animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    //由于当前位置的标注也是一个大头针，所以此时需要判断，此代理方法返回nil使用默认大头针视图
//    if ([annotation isKindOfClass:[QYAnnotation class]]) {
//        static NSString *key1=@"QYAnnotation";
//        annotationView=[mapView dequeueReusableAnnotationViewWithIdentifier:key1];
//        //如果缓存池中不存在则新建
//        if (!annotationView) {
//            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key1];
//            annotationView.canShowCallout=true;//允许交互点击
//            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
//            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
//            [btn setBackgroundImage:[UIImage imageNamed:@"common_green_line"] forState:UIControlStateNormal];
//            [btn setTitle:@"到这去" forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(turnAction:) forControlEvents:UIControlEventTouchUpInside];
//            annotationView.rightCalloutAccessoryView=btn;//定义详情左侧视图
//            annotationView.selected = YES;
//        }
//        //修改大头针视图
//        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
//        annotationView.annotation=annotation;
//        annotationView.image=[UIImage imageNamed:@"common_map_site"];//设置大头针视图的图片
//
//        return annotationView;
//    }else {
//        return nil;
//    }
//}

-(void)turnAction:(id)sender{
    [self doAppleNavigation];
}

-(void)doAppleNavigation{
//    NSDictionary *options=@{MKLaunchOptionsMapTypeKey:@(MKMapTypeStandard),MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving};
//    CLLocationCoordinate2D fromCoordinate   = maMapView.userLocation.location.coordinate;
//    CLLocationCoordinate2D toCoordinate   = CLLocationCoordinate2DMake(destinationMode.destinationLatitude.floatValue, destinationMode.destinationLongitude.floatValue);
//    MKPlacemark *fromPlacemark = [[MKPlacemark alloc] initWithCoordinate:fromCoordinate
//                                                       addressDictionary:nil];
//
//    MKPlacemark *toPlacemark   = [[MKPlacemark alloc] initWithCoordinate:toCoordinate
//                                                       addressDictionary:nil];
//
//    MKMapItem *fromItem = [[MKMapItem alloc] initWithPlacemark:fromPlacemark];
//    fromItem.name =@"当前位置";
//    MKMapItem *toItem=[[MKMapItem alloc]initWithPlacemark:toPlacemark];
//    toItem.name = destinationMode.destinationName;
//    [MKMapItem openMapsWithItems:@[fromItem,toItem] launchOptions:options];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)initilization
{

    self.title=@"";
    [self initMap];
    [self.navigationController.navigationBar addSubview:self.titleView];
    [self.titleView addSubview:self.locIV];
    [self.titleView addSubview:self.titLab];
    [self.titleView addSubview:self.markIV];
    [self loadTitleView];
}
-(void)viewModelBand
{

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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
