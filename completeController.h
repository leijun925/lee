//
//  completeController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"
#import "AsynImageView.h"
#import "scrollerPhotoController.h"
#import "userSmsendController.h"
#import "NSObject+NSString_MD5HexDigest.h"
#import "complete_scroller.h"

@interface completeController : UIViewController<UITableViewDelegate,UITableViewDataSource>{


    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）
    NSArray *completeorderarray;
    NSMutableArray *imagearray;
    UIImageView *wordimage;
    NSString *imagepath;
    NSMutableArray *imageSaveArray;
    NSMutableArray *loadimageArray;
    

}


@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *orderInfoArray;
@property (nonatomic,strong)NSString *status;

@end
