//
//  completeView.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "NSObject+NSString_MD5HexDigest.h"

//定义协议回调方法
@protocol completeViewDelegate <NSObject>

-(void)completeViewFunc:(NSInteger)index showsarray:(NSArray *)array;

@end

@interface completeView : UIView<UITableViewDelegate,UITableViewDataSource>{

    NSString *dataUrl;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *orderArray;    
    NSMutableArray*showArray;
    
    int page;

}


@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)id<completeViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame dataUrl:(NSString *)url;
@property (nonatomic, strong) UIRefreshControl* refreshControl;


@end
