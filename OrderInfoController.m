//
//  OrderInfoController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "OrderInfoController.h"

@interface OrderInfoController ()

@end

@implementation OrderInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor  = [UIColor whiteColor];
  
    UILabel *orderTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    orderTitle.textColor = [UIColor whiteColor];
    [orderTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]];
    orderTitle.text = @"订单详情";
    orderTitle.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = orderTitle;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(orderBlackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;

    
    [self.view addSubview:self.tableview];
    
    [self orderinfofunc];

}

-(void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:NO animated:NO];

}

//懒加载
-(UITableView *)tableview{

    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SIZE_WIDTH, SIZE_HEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = YES;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.backgroundColor = [UIColor whiteColor];
        
        [_tableview setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                      green:145/255.0
                                                       blue:145/255.0
                                                      alpha:0.2]];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        
        if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableview setLayoutMargins:UIEdgeInsetsZero];
        }

        
    }
    
    return _tableview;

}


#pragma mark -返回有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

#pragma mark -返回每块有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
    
}

#pragma mark -返回每一行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==5) {
    
        return 50;
        
    }
    
    return 40;
    
}

#pragma mark -返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *cellName = @"orderCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell== nil) {
        
        //如果cell不存在 创建一个新的 否则去缓存池中去重用
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }
    
    while ([[cell.contentView subviews] count] > 0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    if (indexPath.row == 0) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text= [isorderInfoArray valueForKey:@"O_TYPE_C_NAME"];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                              green:145/255.0
                                               blue:145/255.0
                                              alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    if (indexPath.row == 1) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text=[NSString stringWithFormat:@"客户姓名:%@",[isorderInfoArray valueForKey:@"CUSTOMERNAME"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    
    if (indexPath.row == 2) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text= [NSString stringWithFormat:@"订单时间:%@",[_orderInfoArray valueForKey:@"CREATEDT"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    if (indexPath.row == 3 ) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text= [NSString stringWithFormat:@"客户地址:%@",[isorderInfoArray valueForKey:@"SERVICE_ADDR"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    
    if (indexPath.row == 4) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        
        NSString *usertel = [isorderInfoArray valueForKey:@"CUSTMOILE"];
        usertel = [usertel getStrsssss:usertel];
        ordertitle.text= [NSString stringWithFormat:@"客户电话:%@",usertel];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
        
    }
    
    if (indexPath.row == 5) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        
        NSString *usertel = [isorderInfoArray valueForKey:@"SERVICE_REQUIREMENT"];
        usertel = [usertel getStrsssss:usertel];
        ordertitle.text= [NSString stringWithFormat:@"客户电话:%@",usertel];
        ordertitle.text= [NSString stringWithFormat:@"客户要求:%@",usertel];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
        
    }
    if (indexPath.row == 6) {
        
        UIButton *orderfuncbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        orderfuncbut.frame =CGRectMake(15,5, SIZE_WIDTH-30, 40);
        [orderfuncbut setTitle:@" 指派任务 " forState:UIControlStateNormal];
        [orderfuncbut setBackgroundColor:[UIColor colorWithRed:49/255.0
                                                          green:164/255.0
                                                           blue:229/255.0
                                                          alpha:1.0]];
        orderfuncbut.layer.cornerRadius = 15;
        [orderfuncbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderfuncbut.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [orderfuncbut addTarget:self action:@selector(orderfunc:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:orderfuncbut];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

}


-(void)orderfunc:(id)sender{

    
    NSLog(@"orderfunc");
    order_ServicepressonController *sevicepesson=[[order_ServicepressonController alloc]init];
    sevicepesson.orderArray = _orderInfoArray;
    [self.navigationController pushViewController:sevicepesson animated:YES];

}

-(void)orderBlackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -获取订单详情
-(void)orderinfofunc{
    

    //添加参数
    NSDictionary *LoginParam=@{@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"order_id":[_orderInfoArray valueForKey:@"ORDER_ID"]};
    NSString *service_Url = service;
    NSString *login_Url = orderinfo;
    NSString *sendLoginUrl=[NSString stringWithFormat:@"%@%@",service_Url,login_Url];
    NSLog(@"LoginParam----%@",LoginParam);
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    [manager POST:sendLoginUrl parameters:LoginParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        
        NSLog(@"responseObject---%@",responseObject);
        
        if([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"succ"]){
            
            NSArray *tempArray =[[responseObject valueForKey:@"param"] objectAtIndex:0];
            isorderInfoArray  = [tempArray objectAtIndex:0];
            NSLog(@"responseObject---%@",[isorderInfoArray valueForKey:@"O_TYPENAME"]);
            
            
            [_tableview reloadData];
            
        }else{
            
            
        
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败%@",error);
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败了！请您检查下网络连接是否正常！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
