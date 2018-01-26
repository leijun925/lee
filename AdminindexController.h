//
//  AdminindexController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "TopScrollerView.h"
#import "OrderTableView.h"
#import "AlreadyTableView.h"
#import "completeView.h"
#import "OrderInfoController.h"
#import "completeController.h"
#import "ServiceController.h"
#import "usrCompleteController.h"



@interface AdminindexController : UIViewController<TopScrollerViewDelegate,UIScrollViewDelegate,OrderTableViewDelegate,completeViewDelegate,Alreadorderdelegate>{
    
  //  UIButton *but;
    NSMutableArray *arrabut;
    NSInteger statubut ;
    OrderTableView *ordertable;
    AlreadyTableView *alreadytable;
    completeView *complete;
    
    
    UINavigationController *selectuserinfoNav;
    selectuserinfoController *selectuserinfo;
    
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    
    NSArray *orderArray;

    
}

@property(nonatomic,strong)UIButton *AdminBut;
@property(nonatomic,strong)UIScrollView *scrollView;


@end
