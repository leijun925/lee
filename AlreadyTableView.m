//
//  AlreadyTableView.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "AlreadyTableView.h"

static const NSString *pagecount = @"10";

@implementation AlreadyTableView{

    MJRefreshNormalHeader * hread;
    MJRefreshAutoNormalFooter *footer;

}

-(id)initWithFrame:(CGRect)frame dataUrl:(NSString *)url{

    self = [super initWithFrame:frame];
    if (self!=nil) {

        self.frame = frame;
        showArray= [[NSMutableArray alloc]init];
        page= 1;
        [self addSubview:self.tableView];
      //  [self GetHttpsDataDoctor];
    }

    return self;

}

//懒加载
-(UITableView *)tableView{
    
    
    NSLog(@"order%f",self.frame.size.height);
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.jpg"];
    
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundView = imageTableView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor blueColor];
        [_tableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                      green:145/255.0
                                                       blue:145/255.0
                                                      alpha:0.2]];
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        hread = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_header = hread;
        // 马上进入刷新状态
        [_tableView.mj_header beginRefreshing];
        hread.lastUpdatedTimeLabel.hidden = YES;
        footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        self.tableView.mj_footer = footer;
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"数据刷新中...." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"数据刷新完成" forState:MJRefreshStateNoMoreData];

    
        
    }
    
    return _tableView;
}

#pragma mark -返回有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

#pragma mark -返回每块有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return showArray.count;
    
}

#pragma mark -返回每一行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 210;
    
}

#pragma mark -返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"AlreadyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell== nil) {
        
        //如果cell不存在 创建一个新的 否则去缓存池中去重用
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }
    
    while ([[cell.contentView subviews] count] > 0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 205)];
    cellView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [cell.contentView addSubview:cellView];
    
    UILabel *orderName = [[UILabel alloc]initWithFrame:CGRectMake(10,5,SIZE_WIDTH/2-20, 25)];
    orderName.textColor  = [UIColor blackColor];
    orderName.text = [NSString stringWithFormat:@"%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"O_TYPE_C"]];
    orderName.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:orderName];
    
    UILabel *orderstatus = [[UILabel alloc]initWithFrame:CGRectMake(10+SIZE_WIDTH/2-20,5,SIZE_WIDTH/2-20, 25)];
    orderstatus.textColor  = [UIColor redColor];
    NSString *strstatus = [NSString stringWithFormat:@"%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"O_STAT"]];
    
    if ([strstatus isEqualToString:@"0"]) {
        
        orderstatus.text = @"未接单";
    
    }else if([strstatus isEqualToString:@"1"]){
    
       orderstatus.text = @"等待服务";
    
    }else if ([strstatus isEqualToString:@"2"]){
    
      orderstatus.text = @"服务中";
    
    }else if ([strstatus isEqualToString:@"3"]){
    
        orderstatus.text = @"服务完成";
    
    }else{
    
    
    }
    
    
    orderstatus.textAlignment = NSTextAlignmentRight;
    orderstatus.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:orderstatus];

    
    UILabel *serviceName = [[UILabel alloc]initWithFrame:CGRectMake(10,30,SIZE_WIDTH-20, 25)];
    if ([strstatus isEqualToString:@"0"]) {
        
        serviceName.text = @"等待服务人员接单";
        
    }else{
    
    
        serviceName.text = [NSString stringWithFormat:@"服务人员:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"NAME"]];
    }
    
    serviceName.textColor = [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:0.8];
    
    serviceName.font = [UIFont systemFontOfSize:13.0];
    
    [cellView addSubview:serviceName];
    
    UILabel *orderadress = [[UILabel alloc]initWithFrame:CGRectMake(10,55,SIZE_WIDTH, 25)];
    orderadress.text = [NSString stringWithFormat:@"服务地址:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"SERVICE_ADDR"]];
    orderadress.textColor  =  [UIColor colorWithRed:147/255.0
                                              green:145/255.0
                                               blue:145/255.0
                                              alpha:0.8];;
    orderadress.font = [UIFont systemFontOfSize:13.0];
    
    [cellView addSubview:orderadress];
    UILabel *CustName = [[UILabel alloc]initWithFrame:CGRectMake(10,80,SIZE_WIDTH, 25)];
    CustName.text = [NSString stringWithFormat:@"客户名称:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"C_NAME"]];
    CustName.textColor  =  [UIColor colorWithRed:147/255.0
                                           green:145/255.0
                                            blue:145/255.0
                                           alpha:0.8];
    CustName.font = [UIFont systemFontOfSize:13.0];
    
    [cellView addSubview:CustName];
    
    UILabel *CustTel = [[UILabel alloc]initWithFrame:CGRectMake(10,105,SIZE_WIDTH, 25)];
    NSString *usertel = [[showArray objectAtIndex:indexPath.row] valueForKey:@"MOBILE"];
    usertel = [usertel getStrsssss:usertel];
    CustTel.text = [NSString stringWithFormat:@"客户电话:%@",usertel];
    CustTel.textColor  = [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:0.8];
    CustTel.font = [UIFont systemFontOfSize:13.0];
    [cellView addSubview:CustTel];
    
    UILabel *orderTime = [[UILabel alloc]initWithFrame:CGRectMake(10,130,SIZE_WIDTH, 25)];
    orderTime.text = [NSString stringWithFormat:@"订单安排时间:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"CREATEDT"]];
    orderTime.textColor  = [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:0.8];
    orderTime.font = [UIFont systemFontOfSize:13.0];
    [cellView addSubview:orderTime];
    
    
    
    
    
    if ([strstatus isEqualToString:@"0"]) {
        
        UIButton *orderONE = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        orderONE.frame =CGRectMake(20,160, (SIZE_WIDTH)/2-40, 35);
        [orderONE setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderONE.tag = indexPath.row;
        [orderONE setBackgroundColor:[UIColor colorWithRed:49/255.0
                                                         green:164/255.0
                                                          blue:229/255.0
                                                         alpha:1.0]];
        orderONE.layer.cornerRadius = 15;
        [orderONE setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderONE.titleLabel.font = [UIFont systemFontOfSize:14.0];

        
        UIButton *orderTOW = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        orderTOW.frame =CGRectMake((SIZE_WIDTH)/2+20,160, (SIZE_WIDTH)/2-40, 35);
        [orderTOW setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderTOW.tag = indexPath.row;
        [orderTOW setBackgroundColor:[UIColor colorWithRed:49/255.0
                                                     green:164/255.0
                                                      blue:229/255.0
                                                     alpha:1.0]];
        orderTOW.layer.cornerRadius = 15;
        [orderTOW setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderTOW.titleLabel.font = [UIFont systemFontOfSize:14.0];


        [orderONE setTitle:@" 等待接单 " forState:UIControlStateNormal];
        [orderONE addTarget:self action:@selector(SELECTUSERFUNC:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [orderTOW setTitle:@" 重新派发 " forState:UIControlStateNormal];
        [orderTOW addTarget:self action:@selector(RECFBUTFUNC:) forControlEvents:UIControlEventTouchUpInside];
        
        [cellView addSubview:orderONE];
        [cellView addSubview:orderTOW];

        
    }else if([strstatus isEqualToString:@"1"]){

        UIButton *orderfuncbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        orderfuncbut.frame =CGRectMake(30,160, SIZE_WIDTH-60, 35);
        orderfuncbut.tag = indexPath.row;

        [orderfuncbut setTitle:@" 电话催促 " forState:UIControlStateNormal];
        [orderfuncbut addTarget:self action:@selector(tellConFunc:) forControlEvents:UIControlEventTouchUpInside];
        [orderfuncbut setBackgroundColor:[UIColor colorWithRed:49/255.0
                                                         green:164/255.0
                                                          blue:229/255.0
                                                         alpha:1.0]];
        orderfuncbut.layer.cornerRadius = 15;
        [orderfuncbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderfuncbut.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [cellView addSubview:orderfuncbut];

        
    }else if ([strstatus isEqualToString:@"2"]){
        
        UIButton *orderfuncbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        orderfuncbut.frame =CGRectMake(30,160, SIZE_WIDTH-60, 35);
        orderfuncbut.tag = indexPath.row;

        [orderfuncbut setTitle:@" 电话询问 " forState:UIControlStateNormal];
        [orderfuncbut addTarget:self action:@selector(tellConFunc:) forControlEvents:UIControlEventTouchUpInside];
        [orderfuncbut setBackgroundColor:[UIColor colorWithRed:49/255.0
                                                         green:164/255.0
                                                          blue:229/255.0
                                                         alpha:1.0]];
        orderfuncbut.layer.cornerRadius = 15;
        [orderfuncbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderfuncbut.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [cellView addSubview:orderfuncbut];

        
        
    }else if ([strstatus isEqualToString:@"3"]){
        
        UIButton *orderfuncbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        orderfuncbut.frame =CGRectMake(30,160, SIZE_WIDTH-60, 35);
        orderfuncbut.tag = indexPath.row;

        [orderfuncbut setTitle:@" 查看详情 " forState:UIControlStateNormal];
        [orderfuncbut addTarget:self action:@selector(chakanConFunc:) forControlEvents:UIControlEventTouchUpInside];
        [orderfuncbut setBackgroundColor:[UIColor colorWithRed:49/255.0
                                                         green:164/255.0
                                                          blue:229/255.0
                                                         alpha:1.0]];
        orderfuncbut.layer.cornerRadius = 15;
        [orderfuncbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        orderfuncbut.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [cellView addSubview:orderfuncbut];

        
    }else{
        
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


#pragma mark -拨打电话方法
-(void)tellConFunc:(id)sender{

    UIButton *but = (UIButton *)sender;
    NSInteger numindex = but.tag;
    NSString *usertell = [NSString stringWithFormat:@"%@",[[showArray objectAtIndex:numindex] valueForKey:@"MOBILE"]];

    if ([usertell isEqualToString:@"<null>"] )
    {
        //当标签为空时
        usertell=@"12349";
        NSLog(@"字符串为空");
    }
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",usertell];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];
    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}

-(void)GetHttpsDataDoctor{
    
     @try {
    //添加参数
    NSString *srepage = [NSString stringWithFormat:@"%d",page];
    NSDictionary *LoginParam=@{@"service_id":[USER_DEFAULT objectForKey:@"SERVICEID"],@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"pagecount":pagecount,@"page":srepage};
    NSString *service_Url = service;
    NSString *login_Url = sendorderinfo;
    NSString *sendLoginUrl=[NSString stringWithFormat:@"%@%@",service_Url,login_Url];
    
    NSLog(@"LoginParam---2---%@",LoginParam);
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    //发送POST请求
    [manager POST:sendLoginUrl parameters:LoginParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
        NSLog(@"----responseObject---2----2-----%@",responseObject);
        
        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"error"]) {
            
            
        }else{
        
        orderArray = [[responseObject valueForKey:@"param"] objectAtIndex:0];
        
            if (orderArray.count<=0) {
                
                _tableView.mj_footer.hidden =YES;
                
                
            }else{
                [self arrayselect:orderArray];
        
               [_tableView reloadData];
            }
            
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    }];
    } @catch (NSException *exception) {
         
         NSLog(@"异常2");
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
     } @finally {
         
    }

        
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"index%ld",(long)indexPath.row);
    
}



-(void)loadNewData{
    
    page=1;
    [showArray removeAllObjects];
    [self GetHttpsDataDoctor];
}

-(void)loadMoreData{

     page++;
    [self GetHttpsDataDoctor];
}

-(void)arrayselect:(NSArray *)array{

    [showArray addObjectsFromArray:array];
}

-(void)chakanConFunc:(id)sender{

    UIButton *but = (UIButton *)sender;
    
    NSArray *array = [showArray objectAtIndex:but.tag];
    
    if ([_delegate respondsToSelector:@selector(alreadorderinfo:)]) {
        
        [_delegate alreadorderinfo:array];
        
    }
    
    NSLog(@"查看详情");

}

//显示派发人员函数
-(void)SELECTUSERFUNC:(id)sender{
    
    UIButton *but = (UIButton *)sender;
    NSArray *array = [showArray objectAtIndex:but.tag];

    if ([_delegate respondsToSelector:@selector(SELECTUSERINFO:)]) {
        
        [_delegate SELECTUSERINFO:array];
    }
    
    
}
//重新派发订单函数
-(void)RECFBUTFUNC:(id)sender{

     NSLog(@"RECFBUTFUNC");
    UIButton *but = (UIButton *)sender;
    NSArray *array = [showArray objectAtIndex:but.tag];
    
    if ([_delegate respondsToSelector:@selector(RECFORDERFUNC:)]) {
        
        [_delegate RECFORDERFUNC:array];
    }



}

@end //AlreadyTableView
