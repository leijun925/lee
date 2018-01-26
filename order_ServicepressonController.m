//
//  order_ServicepressonController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/27.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "order_ServicepressonController.h"

static const NSString *pagecount = @"10";

@interface order_ServicepressonController ()

@end

@implementation order_ServicepressonController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    showArray = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor  = [UIColor whiteColor];

    UILabel *alreadyTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    alreadyTitle.textColor = [UIColor whiteColor];
    [alreadyTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]];
    alreadyTitle.text = @"选择人员";
    alreadyTitle.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = alreadyTitle;
    
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(orderBlackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.titleLabel.font = [UIFont systemFontOfSize:14.0];
    RightBack.frame = CGRectMake(0, 0, 40, 30);
    [RightBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [RightBack setTitle:@"派单" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(sendpopfunc) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBack];

    self.navigationItem.rightBarButtonItem = RightButtonItem;
    
    [self.view addSubview:self.tableView];
    
    //定位控件的时候可以忽略导航栏 状态栏高度
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    butArray = [[NSMutableArray alloc]init];
    
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchBar.barTintColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    //搜索栏输入时候更新列表
    searchController.searchResultsUpdater = self;
    // 设置为NO的时候 列表的单元格可以点击 默认为YES无法点击无效
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.delegate = self;
    // 保证搜索导航栏中可见
    [searchController.searchBar sizeToFit];
    // 把搜索框 设置为表头
    _tableview.tableHeaderView = searchController.searchBar;
    self.definesPresentationContext = YES;
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}


-(UITableView *)tableView{
    
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0,44, SIZE_WIDTH,SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.jpg"];
    
    
    if (!_tableview) {
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SIZE_WIDTH, SIZE_HEIGHT-59) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundView = imageTableView;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.backgroundColor = [UIColor blueColor];
        
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableview setLayoutMargins:UIEdgeInsetsZero];
        }
        
        [_tableview setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                           green:145/255.0
                                                            blue:145/255.0
                                                           alpha:0.4]];
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
        // 马上进入刷新状态
        [_tableview.mj_header beginRefreshing];
        _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    
    return _tableview;;
    
}

//表视图协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
  //  return userArray.count;
    return showArray.count;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    


}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 95;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellidentifier = @"adminCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        
    }
    
    while (cell.contentView.subviews.count>0) {
        
        [[cell.contentView.subviews objectAtIndex:0] removeFromSuperview];
        
    }
    
    _userlogoimage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 8, 44, 44)];
    _userlogoimage.image = [UIImage imageNamed:@"logof.png"];
    _userlogoimage.layer.cornerRadius = 5;
    _userlogoimage.layer.masksToBounds = true;
    _userlogoimage.layer.borderColor = [[UIColor whiteColor]CGColor];
    _userlogoimage.layer.borderWidth = 2 ;
    
    [cell.contentView addSubview:_userlogoimage];
    
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(60,2, SIZE_WIDTH/2, 25)];
    userName.text = [NSString stringWithFormat:@"%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"NAME"]];
    userName.textColor = [UIColor blackColor];
    userName.font = [UIFont systemFontOfSize:14.0];
    
    [cell.contentView addSubview:userName];
    
    UILabel *userword = [[UILabel alloc]initWithFrame:CGRectMake(60,27, SIZE_WIDTH/2, 20)];
    NSString *sexclass = [[showArray objectAtIndex:indexPath.row] valueForKey:@"SEX"];
    sexclass = [sexclass getStrsssss:sexclass];
    userword.text = [NSString stringWithFormat:@"性别:%@",sexclass];
    userword.textColor = [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:1.0];
    
    userword.font = [UIFont systemFontOfSize:12.0];
    [cell.contentView addSubview:userword];
    
    UILabel *usertel = [[UILabel alloc]initWithFrame:CGRectMake(60,47, SIZE_WIDTH/2, 20)];
    NSString *usertelsss = [[showArray objectAtIndex:indexPath.row] valueForKey:@"ACCOUNT"];
    usertelsss = [usertelsss getStrsssss:usertelsss];
    usertel.text = [NSString stringWithFormat:@"电话:%@",usertelsss];
    usertel.textColor = [UIColor colorWithRed:147/255.0
                                        green:145/255.0
                                         blue:145/255.0
                                        alpha:1.0];
    
    usertel.font = [UIFont systemFontOfSize:12.0];
    
    [cell.contentView addSubview:usertel];
    
    
    
    UILabel *servicenum = [[UILabel alloc]initWithFrame:CGRectMake(60,67, SIZE_WIDTH/2, 20)];
    NSString *workname = [[showArray objectAtIndex:indexPath.row] valueForKey:@"ACCOUNT"];
    workname = [workname getStrsssss:workname];
    servicenum.text = [NSString stringWithFormat:@"所属公司:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"ORG_NAME"]];
    servicenum.textColor = [UIColor colorWithRed:147/255.0
                                           green:145/255.0
                                            blue:145/255.0
                                           alpha:1.0];
    
    servicenum.font = [UIFont systemFontOfSize:12.0];
    
    [cell.contentView addSubview:servicenum];
    

    NSString *butstatus = @"1";
    NSString *statusx = [NSString stringWithFormat:@"%lu",(long)indexPath.row];
    
    for (int i=0; i<butArray.count; i++) {
        
        if ([[butArray objectAtIndex:i] isEqual:statusx]) {
            
            butstatus=@"2";
        }
        
    }
    
    UIButton *selectPerssonBut= [UIButton buttonWithType:UIButtonTypeCustom];

    
    if ([butstatus isEqualToString:@"2"]) {
        
        selectPerssonBut.selected =YES;
        
    }else{
        
        selectPerssonBut.selected =NO;
    }
    selectPerssonBut.tag = indexPath.row;
    selectPerssonBut.frame = CGRectMake(SIZE_WIDTH-50, 20, 40, 40);
    [selectPerssonBut setBackgroundImage:[UIImage imageNamed:@"PayButNo.png"] forState:UIControlStateNormal];
    [selectPerssonBut setBackgroundImage:[UIImage imageNamed:@"PayButNo.png"] forState: UIControlStateHighlighted];
    [selectPerssonBut setBackgroundImage:[UIImage imageNamed:@"PayButYes.png"] forState:UIControlStateSelected];
    [selectPerssonBut setBackgroundImage:[UIImage imageNamed:@"PayButYes.png"] forState:UIControlStateSelected | UIControlStateHighlighted];
    [selectPerssonBut addTarget:self action:@selector(selectButFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:selectPerssonBut];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"index%ld",(long)indexPath.row);
    
}


-(void)selectButFunc:(id)sender{
    
    UIButton *but = (UIButton *)sender;
    BOOL trueboole = false;
    
    
    for (int i =0;i<butArray.count;i++) {
        
        NSInteger buttap = [[butArray objectAtIndex:i] intValue];
        
        if (but.tag == buttap) {
            
            trueboole = true;
            break;
            
        }else{
            
            trueboole = false;
            
        }
        
        
    }
    
    NSString *buttap = [NSString stringWithFormat:@"%ld",(long)but.tag];
    if (trueboole) {
        
        
        [butArray removeObject:buttap];
        
        
    }else{
        
        [butArray addObject:buttap];
        
    }
    
    
    NSLog(@"butattay%lu",(unsigned long)butArray.count);
    
    [_tableview reloadData];
    
}


-(void)GetHttpsuserDataDoctor{

    
    //添加参数
    @try {
        
        NSString *srepage = [NSString stringWithFormat:@"%d",page];
        NSString *orgid = [NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"ORGID"]];
        NSDictionary *LoginParam=@{@"ORGID":orgid,@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"SERVICEID":[USER_DEFAULT objectForKey:@"SERVICEID"],@"pagecount":pagecount,@"page":srepage};
        NSString *service_Url = service;
        NSString *login_Url = userList;
        NSString *sendLoginUrl=[NSString stringWithFormat:@"%@%@",service_Url,login_Url];
        
        NSLog(@"GetHttpsDataDoctor------%@",LoginParam);        //创建请求
        manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
        
        //发送POST请求
        [manager POST:sendLoginUrl parameters:LoginParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            NSLog(@"----responseObject--6--%@",responseObject);
            
            if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"error"]) {
                
                
                
            }else{
                
                userArray = [[responseObject valueForKey:@"param"] objectAtIndex:0];
                [self arrayselect:userArray];
                
                [_tableview reloadData];
                
            }
            
            [_tableview.mj_header endRefreshing];
            [_tableview.mj_footer endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [_tableview.mj_header endRefreshing];
            [_tableview.mj_footer endRefreshing];
 
            
        }];
        
        
    } @catch (NSException *exception) {
        
        NSLog(@"异常");
        [_tableview.mj_header endRefreshing];
        
    } @finally {
        
    }
    
}

-(void)sendpopfunc{
    
    
    if (butArray.count<=0) {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请在选择服务人员后在进行排单！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }]];
        [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
        
        return;
    }


    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定把改订单任务派送选择的人员嘛！" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self SendOrderFunc];
        
       
        
    }]];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
       
        
    }]];
    [self presentViewController:alertCon animated:YES completion:nil];
    

}

-(void)loadNewData{
    
    NSLog(@"下拉刷新");
    page=1;
    [showArray removeAllObjects];
    [self GetHttpsuserDataDoctor];

}

-(void)loadMoreData{

    page++;
    [self GetHttpsuserDataDoctor];

}

-(void)arrayselect:(NSArray *)array{
    
    [showArray addObjectsFromArray:array];
    
}

-(void)orderBlackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -提交数据
-(void)SendOrderFunc{
             //添加参数
    NSString *admin_id =[USER_DEFAULT objectForKey:@"User_ID"];
    NSString *struserid=@"";
    NSString *strusername=@"";

    NSLog(@"--butArray--%lu",(unsigned long)butArray.count);
    for (int i=0;i<butArray.count; i++) {
        
        NSInteger indexnum =  [[butArray objectAtIndex:i] intValue];
        NSLog(@"--userArray--%lu",(unsigned long)userArray.count);
        
        if (i == 0) {
            
            
            struserid = [[showArray objectAtIndex:indexnum] valueForKey:@"ID"];
            
            strusername = [[showArray objectAtIndex:indexnum] valueForKey:@"NAME"];
            
        }else{
        
            struserid =[NSString stringWithFormat:@"%@,%@",struserid,[[showArray objectAtIndex:indexnum] valueForKey:@"ID"]];
            strusername = [NSString stringWithFormat:@"%@,%@",strusername,[[showArray objectAtIndex:indexnum] valueForKey:@"NAME"]];
        
        }
        
    }

    NSDictionary *sendorderParam=@{@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"ids":struserid,@"service_id":[USER_DEFAULT objectForKey:@"SERVICEID"],@"order_id":[_orderArray valueForKey:@"ORDER_ID"],@"star":@"0",@"admin_id":admin_id,@"order_name":[_orderArray valueForKey:@"O_TYPE_C"]};
    
    NSLog(@"sendorderParam--%@",sendorderParam);
    
    NSString *service_Url = service;
    NSString *sendorderUrl = sendOrder;
    NSString *sendOrderUrl=[NSString stringWithFormat:@"%@%@",service_Url,sendorderUrl];
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    //发送POST请求
    [manager POST:sendOrderUrl parameters:sendorderParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
        NSLog(@"responseObject---%@",responseObject);
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

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
