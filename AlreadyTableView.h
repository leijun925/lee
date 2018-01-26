//
//  AlreadyTableView.h
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
#import "selectuserinfoController.h"


@protocol Alreadorderdelegate <NSObject>

@optional
-(void)alreadorderinfo:(NSArray *)array;
-(void)SELECTUSERINFO:(NSArray *)array;
-(void)RECFORDERFUNC:(NSArray *)array;

@end

typedef NS_ENUM(NSUInteger, UMSAuthViewType)
{
    SERVICE_ONE,
    SERVICE_TOW,
    SERVICE_THREE,
    SERVICE_FOVE
};



@interface AlreadyTableView : UIView<UITableViewDelegate,UITableViewDataSource>{

    NSString *dataUrl;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *orderArray;
    NSMutableArray*showArray;
    
    int page;

}

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)id<Alreadorderdelegate> delegate;

-(id)initWithFrame:(CGRect)frame dataUrl:(NSString *)url;
@property (nonatomic, strong) UIRefreshControl* refreshControl;



@end
