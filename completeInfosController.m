//
//  completeInfosController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/27.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "completeInfosController.h"

@interface completeInfosController ()

@end

@implementation completeInfosController

- (void)viewDidLoad {
    [super viewDidLoad];


    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.view.backgroundColor  = [UIColor whiteColor];
    
    
    UILabel *alreadyTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    alreadyTitle.textColor = [UIColor blackColor];
    alreadyTitle.font = [UIFont systemFontOfSize:14.0];
    alreadyTitle.text = @"完结订单";
    alreadyTitle.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = alreadyTitle;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
