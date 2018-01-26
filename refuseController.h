//
//  refuseController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/28.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"
#import "AFHTTPSessionManager.h"

@interface refuseController : UIViewController<UITextViewDelegate>{


    UITextView *feedTextFile;
    UILabel *palaceLabel;
    AFHTTPSessionManager *manager; //创建请求（iOS 6-7）


}

@property(nonatomic,strong)NSArray *orderArray;
@end
