//
//  PersonalCenterController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "userLoginController.h"
#import "modifyPswdController.h"
#import "modifyTelController.h"

//定义协议
@protocol PersonalCenterDelegate <NSObject>

@optional
//协议方法
-(void)PersonalCenterViewFunc;

@end

@interface PersonalCenterController : UIViewController<UITableViewDelegate,UITableViewDataSource>{

    

}

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)id<PersonalCenterDelegate> delegate;

@end
