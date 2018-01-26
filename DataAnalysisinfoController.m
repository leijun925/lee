//
//  DataAnalysisinfoController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/7/13.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "DataAnalysisinfoController.h"

@interface DataAnalysisinfoController ()

@end

@implementation DataAnalysisinfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor whiteColor];
    ConTitleView.text = self.strTitle;
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(backFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;

    //定位控件的时候可以忽略导航栏 状态栏高度
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    NSArray *pageUrl = @[@"indexdata_one.do",@"indexdata_tow.do",@"indexdata_three.do",@"indexdata_fove.do"];

    NSLog(@"_pagestatus---%@",_pagestatus);

    if ([_pagestatus isEqualToString:@"DATA_ONE"]) {
        
        _webUrl = pageUrl[0];
        
    }

    else if ([_pagestatus isEqualToString:@"DATA_TOW"]) {
        
        _webUrl = pageUrl[1];
        
    }

    else if ([_pagestatus isEqualToString:@"DATA_THREE"]) {
        
        _webUrl = pageUrl[2];
    }

    else if ([_pagestatus isEqualToString:@"DATA_FOVE"]) {
        
        _webUrl = pageUrl[3];
        
    }
    
    NSString *SERVICEID = [NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"SERVICEID"]];
    NSString *pageurls = [NSString stringWithFormat:@"%@%@?serviceID=%@",service,_webUrl,SERVICEID];
    
    NSLog(@"pageurls-----%@",pageurls);
    
    [self.view addSubview:self.wkWebView];
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:pageurls]]];

}

-(WKWebView *)wkWebView{

    if (!_wkWebView) {
        
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT-70)];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;

    }
    
    return _wkWebView;
}


// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

-(void)backFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}



@end
