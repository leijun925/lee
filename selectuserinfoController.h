//
//  selectuserinfoController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/8/21.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "NSObject+NSString_MD5HexDigest.h"

@interface selectuserinfoController : UIViewController<UITableViewDelegate, UITableViewDataSource>{

}

@property (nonatomic,strong)NSArray *userArray;
@property(nonatomic,strong)UITableView *tableView;


@end
