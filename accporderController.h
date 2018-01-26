//
//  accporderController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/7/9.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "startServiceController.h"
#import "AFHTTPSessionManager.h"
#import "NSObject+NSString_MD5HexDigest.h"

@interface accporderController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *isorderInfoArray;
    

}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *orderInfoArray;


@end
