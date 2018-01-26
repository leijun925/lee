//
//  DataAnalysisController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ServiceConnectionPublic.h"
#import "DataAnalysisinfoController.h"



@interface DataAnalysisController : UIViewController<UITableViewDelegate,UITableViewDataSource>{


    UIImageView *hreadView;

}

@property(nonatomic,strong)UITableView *dataTableView;

@end
