//
//  adminPersonnelViewController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "UserinfoController.h"
#import "registerController.h"
#import "NSObject+NSString_MD5HexDigest.h"

@interface adminPersonnelViewController : UIViewController<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSMutableArray *userArray;
    
    UISearchBar  *searchBar;
    UISearchDisplayController *searchDc;
    NSMutableArray *namearray;
    NSMutableArray *showdata;
    NSMutableArray *showArray;
    
    int page;
    
    //注册页面
    UINavigationController *registerNav;
    registerController *registerCon;

}

@property(nonatomic,strong)UITableView *adminatbleview;
@property(nonatomic,strong)UIImageView *userlogoimage;



@end
