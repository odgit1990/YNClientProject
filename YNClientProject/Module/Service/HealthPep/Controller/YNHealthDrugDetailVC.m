//
//  YNHealthDrugDetailVC.m
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

#import "YNHealthDrugDetailVC.h"
#import "YNhealthDragPayVC.h"
#import "Head.h"

@interface YNHealthDrugDetailVC ()<NJKWebViewProgressDelegate>
@property (nonatomic,strong) UIImageView *navfgiv;
@property (strong, nonatomic) NJKWebViewProgressView *progressView;
@property (strong, nonatomic) NJKWebViewProgress *progressProxy;
@end

@implementation YNHealthDrugDetailVC
@synthesize web,progressView,progressProxy;
#pragma mark - getter and setter
-(UIImageView *)navfgiv
{
    if (!_navfgiv) {
        _navfgiv = [[UIImageView alloc]init];
        _navfgiv.frame = CGRectMake(0, 0, WF_SCREEN_WIDTH, 64);
        UIImage *navfgimg = [UIImage imageNamed:@"navfg"];
        _navfgiv.image = navfgimg;
    }
    return _navfgiv;
}
-(NJKWebViewProgressView *)progressView
{
    if (!progressView) {
        CGFloat progressBarHeight = 2.0f;
        CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
        CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
        progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
        progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        progressView.hidden = YES;
    }
    return progressView;
}
-(UIWebView *)web
{
    if (!web) {
        web = [[UIWebView alloc]init];
        if (_type <= 0) {
            web.frame = CGRectMake(0, 0, WF_SCREEN_WIDTH, WF_UI_VIEW_HEIGHT);
        }else{
            web.frame = CGRectMake(0, 0, WF_SCREEN_WIDTH, WF_UI_VIEW_HEIGHT - WF_TAB_BAR_HEIGHT - WF_TAB_SAFE_OFFSET);
        }
        web.delegate = self;
    }
    return web;
}
-(NJKWebViewProgress *)progressProxy
{
    if (!progressProxy) {
        progressProxy = [[NJKWebViewProgress alloc] init];
        self.web.delegate = progressProxy;
        progressProxy.webViewProxyDelegate = self;
        progressProxy.progressDelegate = self;
    }
    return progressProxy;
}
#pragma mark - event---------------------------
-(void)leftTab:(id)sender
{
    if (web.canGoBack) {
        [web goBack];
    }else{
        [self.navigationController  popViewControllerAnimated:YES];
    }
}
#pragma mark - method---------------------------
#pragma mark - public method
-(void)initilization
{
    
}
#pragma mark - private method
-(void)refresh
{
    NSString *url = [self.information objectForKey:@"url"];
    //    url = [url stringByAppendingString:@"&device_type=2"];
    NSURL *Url = [NSURL URLWithString:url];
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:Url];
    [self.web loadRequest:req];
}
-(BOOL)dealUrl
{
    BOOL res = YES;
    NSURLRequest *request = web.request;
    NSURL *url = request.URL;
    NSString *urlstr = url.absoluteString;
    if (urlstr && urlstr.length > 0) {
        if (![urlstr containsString:@"&device_type=2"]) {
            urlstr = [urlstr stringByAppendingString:@"&device_type=2"];
            NSURL *urlf = [NSURL URLWithString:urlstr];
            NSURLRequest *requestf = [NSURLRequest requestWithURL:urlf];
            [self.web loadRequest:requestf];
        }
    }
    return res;
}

- (void)hidenaction{
    /// 开始加载时隐藏webview 加载完后显示，原因是 因为我们要去掉头标签，，去掉的方法是在网页加载完毕进行的，，添加一个延时现实的方法 可以隐藏掉网页先显示头标签又被移除的过程。使其看起来更自然一些
    self.web.hidden =NO;
}

- (void)backacrion{
    if ([self.web canGoBack]) {
        /// 网页可以返回 就进行网页返回
        [self.web goBack];
    }else{
        [self.view resignFirstResponder];
        /// 网页返回到首页了 返回不了了 这时候我们的控制器返回
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - life---------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIColor *titleColor = HEXCOLOR(@"#FFFFFF");
    NSDictionary *titleDict = @{NSFontAttributeName:[UIFont systemFontOfSize:16 withScale:autoSizeScaleX],
                                NSForegroundColorAttributeName:titleColor};
    self.navigationController.navigationBar.titleTextAttributes = titleDict;//标题字体
    self.navigationController.navigationBar.tintColor = titleColor;//左右按钮颜色
    
    if (1 != _type) {
        /// 隐藏系统返回按钮 进行自定义
        UIImage *backimg = [UIImage imageNamed:@"backicon"];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:backimg style:UIBarButtonItemStylePlain target:self action:@selector(leftTab:)];
    }
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //    self.progressProxy.description;
    NSLog(@"%@",self.progressProxy.description);
    [self.view addSubview:self.web];
    
    [self refresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [progressView removeFromSuperview];
    [self.navfgiv removeFromSuperview];
    [super viewWillDisappear:animated];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - web view delegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //     直接 截取后面的id
    NSString *str = request.URL.resourceSpecifier;
    NSLog(@"request.URL.resourceSpecifier = %@",request.URL.absoluteString);
    NSString *strTwo = [NSString stringWithFormat:@"app://yannihealth.com/drugboxinfo?keyid=%@",_passID];

    if ([strTwo isEqualToString:request.URL.absoluteString]) {
        YNhealthDragPayVC* vc=[[YNhealthDragPayVC alloc] init];
        vc.passID=_passID;
        [self.navigationController pushViewController:vc animated:YES];

        return NO;
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 1.获取页面标题
    //获取当前页面的title 设置导航栏标题
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = title;
    
    // 2.去掉页面标题
    NSMutableString *str = [NSMutableString string];
    // 3.根据标签类型获取指定标签的元素
    [str appendString:@"var header = document.getElementsByTagName(\"header\")[0];"];
    [str appendString:@"header.parentNode.removeChild(header);"];//移除头部的导航栏
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    // 3.去掉底部选项卡
    NSMutableString *str2 = [NSMutableString string];
    // 3.根据标签类型获取指定标签的元素
    [str2 appendString:@"var header = document.getElementsByClassName(\"weui-tabbar\")[0];"];
    [str2 appendString:@"header.parentNode.removeChild(header);"];//移除底部选项卡
    [webView stringByEvaluatingJavaScriptFromString:str2];
}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    progressView.hidden = NO;
    [progressView setProgress:progress animated:YES];
    self.title = [web stringByEvaluatingJavaScriptFromString:@"document.title"];
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
