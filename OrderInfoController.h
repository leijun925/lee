//
//  OrderInfoController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "order_ServicepressonController.h"
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"
#import "NSObject+NSString_MD5HexDigest.h"

@interface OrderInfoController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）

    NSArray *isorderInfoArray;
}


@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *orderInfoArray;

@end
