//
//  OrderTableView.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/19.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"

//定义协议
@protocol OrderTableViewDelegate <NSObject>

@optional

-(void)OrderTableViewFunc:(NSInteger)index orderArrray:(NSArray *)array;

@end

@interface OrderTableView : UIView<UITableViewDelegate,UITableViewDataSource>{

    NSString *dataUrl;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *orderArray;
    NSMutableArray*showArray;
    BOOL isloging;
    
    int page;

}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)id<OrderTableViewDelegate> delegate;
@property (nonatomic, strong) UIRefreshControl* refreshControl;

-(id)initWithFrame:(CGRect)frame dataUrl:(NSString *)url;

@end
