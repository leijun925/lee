//
//  ServiceCompleteTableView.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/22.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"
#import "MJRefresh.h"
#import "NSObject+NSString_MD5HexDigest.h"

@protocol ServiceCompleteDelegate <NSObject>

@optional

-(void)ServiceCompleteFunc:(NSInteger)index;
//服务结束
-(void)ViewrecordFunc:(NSArray *)array;
//开始服务
-(void)startServiceController:(NSArray *)orderArray;
//服务中
-(void)inserviceButfunc:(NSArray *)orderArray;
//退单协议
-(void)noserviceorderfunc:(NSArray *)orderArray;

@end


@interface ServiceCompleteTableView : UIView<UITableViewDelegate,UITableViewDataSource>{

    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *orderArray;
    int page;
    NSMutableArray*showArray;
}

@property(nonatomic,strong)id<ServiceCompleteDelegate> delegate;
@property(nonatomic,strong)UITableView *ServiceCompletetableView;
-(id)initWithFrame:(CGRect)frame dataUrl:(NSString *)url;

@end
