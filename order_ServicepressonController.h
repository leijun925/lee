//
//  order_ServicepressonController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/27.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "NSObject+NSString_MD5HexDigest.h"


@interface order_ServicepressonController : UIViewController<UISearchResultsUpdating,UISearchControllerDelegate,UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *butArray;
    NSMutableArray *userDataArray;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSMutableArray *userArray;
    
    UISearchBar  *searchBar;
    UISearchController *searchController;
    NSMutableArray *showdata;

    int page;
    
    NSMutableArray*showArray;

}

@property (nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIImageView *userlogoimage;
@property(nonatomic,strong)NSArray *orderArray;

@end
