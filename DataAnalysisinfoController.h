//
//  DataAnalysisinfoController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/7/13.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "ServiceConnectionPublic.h"

@interface DataAnalysisinfoController : UIViewController<WKUIDelegate,WKNavigationDelegate>{

}

@property (nonatomic,strong)NSString *strTitle;
@property (nonatomic,strong)NSString *pagestatus;
@property (nonatomic,strong)NSString *webUrl;
@property (nonatomic,strong)WKWebView *wkWebView;

@end
