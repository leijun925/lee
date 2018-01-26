//
//  ServiceCompleteTableView.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/22.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "ServiceCompleteTableView.h"

static const NSString *pagecount = @"10";

@implementation ServiceCompleteTableView{

    MJRefreshAutoGifFooter *footer;
    MJRefreshNormalHeader *hread;

}

-(id)initWithFrame:(CGRect)frame dataUrl:(NSString *)url{


    self = [super initWithFrame:frame];
    
    if (self!=nil) {
    
        showArray= [[NSMutableArray alloc]init];
        page= 1;
        self.frame=frame;
        [self addSubview:self.ServiceCompletetableView];
        
    }

    return self;
}

//懒加载
-(UITableView *)ServiceCompletetableView{

    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.jpg"];
    
    
    if (!_ServiceCompletetableView) {
        
        _ServiceCompletetableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
        _ServiceCompletetableView.delegate = self;
        _ServiceCompletetableView.dataSource = self;
        _ServiceCompletetableView.backgroundView = imageTableView;
        _ServiceCompletetableView.showsVerticalScrollIndicator = NO;
        _ServiceCompletetableView.backgroundColor = [UIColor blueColor];
        
        if ([_ServiceCompletetableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_ServiceCompletetableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_ServiceCompletetableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_ServiceCompletetableView setLayoutMargins:UIEdgeInsetsZero];
        }
        
        _ServiceCompletetableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        hread = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _ServiceCompletetableView.mj_header = hread;
        hread.lastUpdatedTimeLabel.hidden = YES;
        // 马上进入刷新状态
        //下拉刷新
        [_ServiceCompletetableView.mj_header beginRefreshing];
        //上拉刷新
        
        
        //上拉刷新
        footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        _ServiceCompletetableView.mj_footer = footer ;
        
        
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"数据刷新中...." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"数据刷新完成" forState:MJRefreshStateNoMoreData];

    }
    
    return _ServiceCompletetableView;

}

//tableview协议方法
//返回表视图有几块内容
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

//返回每块有几行数据
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //section第几块的索引
    
    //返回有多少行
    return showArray.count;


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //返回每一行的高度
    return 180;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellidentifier = @"identifiercell";
    //创建一个cell 名字是上面定义的静态字符串
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    //如果cell不存在就创建新的 如果存在就从缓存池中重用一个cell
    if(cell == nil){
    
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }

    //在重用之前清楚cell上所有的View
    while (cell.contentView.subviews.count>0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
        
    }
    
    NSString *STATUS = [NSString stringWithFormat:@"%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"ASTAT"]];
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 175)];
    cellView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [cell.contentView addSubview:cellView];
    
    UILabel *orderTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SIZE_WIDTH/2-10, 25)];
    orderTitle.text =[NSString stringWithFormat:@"%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"TYPENAME"]];;
    orderTitle.textColor = [UIColor blackColor];
    orderTitle.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:orderTitle];
    
    UILabel *orderstatus = [[UILabel alloc]initWithFrame:CGRectMake(10+SIZE_WIDTH/2, 5, SIZE_WIDTH/2-20, 25)];
    
    
    if ([STATUS isEqualToString:@"1"]){
        
        orderstatus.text = @"未服务";
        
    }
    if ([STATUS isEqualToString:@"2"]) {
        
         orderstatus.text = @"服务中";
        
    }
    
    if ([STATUS isEqualToString:@"3"]) {
        
         orderstatus.text = @"服务完成";
    }
    if ([STATUS isEqualToString:@"4"]) {
        
        orderstatus.text = @"办结服务";
    }
    
    
    orderstatus.textAlignment = NSTextAlignmentRight;
    orderstatus.textColor = [UIColor colorWithRed:255/255.0
                                            green:139/255.0
                                             blue:148/255.0
                                            alpha:1.0];
    orderstatus.font = [UIFont systemFontOfSize:13.0];
    
    [cellView addSubview:orderstatus];
    
    UILabel *custName = [[UILabel alloc]initWithFrame:CGRectMake(10,30, SIZE_WIDTH/2-10, 25)];
    custName.text =[NSString stringWithFormat:@"客户姓名:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"C_NAME"]];;
    custName.textColor = [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:0.8];
    
    custName.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:custName];
    
    UILabel *custTel = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, SIZE_WIDTH-20, 25)];
    NSString *usertels = [[showArray objectAtIndex:indexPath.row] valueForKey:@"MOBILE"];
    usertels = [usertels getStrsssss:usertels];
    custTel.text =[NSString stringWithFormat:@"客户电话:%@",usertels];;
    custTel.textColor =  [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:0.8];
    custTel.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:custTel];
    
    UILabel *custAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SIZE_WIDTH-20, 25)];
    custAddress.text = [NSString stringWithFormat:@"客户地址:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"SERVICE_ADDR"]];
    custAddress.textColor =  [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
    custAddress.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:custAddress];
    
    UILabel *orderTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, SIZE_WIDTH-20, 25)];
    orderTime.text =  [NSString stringWithFormat:@"订单时间:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"CREATEDT"]];
    orderTime.textColor =  [UIColor colorWithRed:147/255.0
                                           green:145/255.0
                                            blue:145/255.0
                                           alpha:0.8];
    orderTime.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:orderTime];
  
    
    if ([STATUS isEqualToString:@"1"]){
    
        UIButton *intoService = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        intoService.frame =CGRectMake(30,135, (SIZE_WIDTH/2)-30, 30);
        [intoService setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
        intoService.layer.cornerRadius = 8;
        [intoService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        intoService.titleLabel.font = [UIFont systemFontOfSize:14.0];
        intoService.tag = indexPath.row;

        [intoService setTitle:@" 开始服务 " forState:UIControlStateNormal];
        [intoService addTarget:self action:@selector(startSrviceButfunc:) forControlEvents:UIControlEventTouchUpInside];
        
        [cellView addSubview:intoService];
        
        
        UIButton *noService = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        noService.frame =CGRectMake(30+10+(SIZE_WIDTH/2)-30,135, (SIZE_WIDTH/2)-30, 30);
        [noService setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
        noService.layer.cornerRadius = 8;
        [noService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        noService.titleLabel.font = [UIFont systemFontOfSize:14.0];
        noService.tag = indexPath.row;
        
        [noService setTitle:@" 申退服务 " forState:UIControlStateNormal];
        [noService addTarget:self action:@selector(noSrviceButfunc:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:noService];

        
        
        
    }
    if ([STATUS isEqualToString:@"2"]) {
        
        UIButton *intoService = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        intoService.frame =CGRectMake(30,135, SIZE_WIDTH-60, 30);
        [intoService setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
        intoService.layer.cornerRadius = 8;
        [intoService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        intoService.titleLabel.font = [UIFont systemFontOfSize:14.0];
        intoService.tag = indexPath.row;

        [intoService setTitle:@" 服务中 " forState:UIControlStateNormal];
        [intoService addTarget:self action:@selector(inserviceButsfunc:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:intoService];
        
    
    }
    
    if ([STATUS isEqualToString:@"3"]) {
        
        UIButton *intoService = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        intoService.frame =CGRectMake(30,135, SIZE_WIDTH-60, 30);
        [intoService setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
        intoService.layer.cornerRadius = 8;
        [intoService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        intoService.titleLabel.font = [UIFont systemFontOfSize:14.0];
        intoService.tag = indexPath.row;

        [intoService setTitle:@" 完成工单 " forState:UIControlStateNormal];
        [intoService addTarget:self action:@selector(ViewrecordButfunc:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:intoService];
        
    }
    if ([STATUS isEqualToString:@"4"]) {
        
        UIButton *intoService = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        intoService.frame =CGRectMake(30,135, SIZE_WIDTH-60, 30);
        [intoService setBackgroundColor:[UIColor colorWithRed:255/255.0 green:139/255.0 blue:148/255.0 alpha:1.0]];
        intoService.layer.cornerRadius = 8;
        [intoService setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        intoService.titleLabel.font = [UIFont systemFontOfSize:14.0];
        intoService.tag = indexPath.row;
        
        [intoService setTitle:@" 办结工单 " forState:UIControlStateNormal];
        [intoService addTarget:self action:@selector(ViewrecordButfunc:) forControlEvents:UIControlEventTouchUpInside];
        [cellView addSubview:intoService];
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
    return cell;

}

//tableview选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    if ([_delegate respondsToSelector:@selector(ServiceCompleteFunc:)]) {
        
        [_delegate ServiceCompleteFunc:indexPath.row];
    }

}

-(void)getUserInfoFunc{

    NSString *srepage = [NSString stringWithFormat:@"%d",page];
    NSDictionary *LoginParam=@{@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"pagecount":pagecount,@"page":srepage};
    NSString *service_Url = service;
    NSString *orderService = service_user_order;
    NSString *sendUserInfoUrl=[NSString stringWithFormat:@"%@%@",service_Url,orderService];
    
    NSLog(@"sendUserInfoUrl%@",LoginParam);
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    //发送POST请求
    [manager POST:sendUserInfoUrl parameters:LoginParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)  {
        
        NSLog(@"responseObject---%@",responseObject);
        
        NSString *status =[NSString stringWithFormat:@"%@",[[responseObject objectAtIndex:0] valueForKey:@"result"]];
        
        if ([status isEqualToString:@"succ"]) {
            
            orderArray = [[responseObject valueForKey:@"param"] objectAtIndex:0];
            [self arrayselect:orderArray];
            [_ServiceCompletetableView reloadData];
        }
        
        
        if (orderArray.count == 0) {
            NSLog(@"没有数据");
            _ServiceCompletetableView.mj_footer.hidden = YES;
        }
        

        
        
        [_ServiceCompletetableView.mj_header endRefreshing];
        [_ServiceCompletetableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [_ServiceCompletetableView.mj_header endRefreshing];
        [_ServiceCompletetableView.mj_footer endRefreshing];
        
    }];
}

-(void)loadNewData{

    page=1;
    [showArray removeAllObjects];
     [self getUserInfoFunc];

}

-(void)loadMoreData{
    
    page++;
    [self getUserInfoFunc];
    
}
-(void)arrayselect:(NSArray *)array{
    
    [showArray addObjectsFromArray:array];
    
}

//服务完成
-(void)ViewrecordButfunc:(id)sender{

    UIButton *but = (UIButton *)sender;
    NSArray *array = [showArray objectAtIndex:but.tag];

    if ([_delegate respondsToSelector:@selector(ViewrecordFunc:)]) {
        
        [_delegate ViewrecordFunc:array];
        
    }

}

//开始服务
-(void)startSrviceButfunc:(id)sender{


    UIButton *but = (UIButton *)sender;
    NSArray *array = [showArray objectAtIndex:but.tag];
    
    if ([_delegate respondsToSelector:@selector(startServiceController:)]) {
        
        [_delegate startServiceController:array];
    }

}
//服务完成
-(void)inserviceButsfunc:(id)sender{
    
    UIButton *but = (UIButton *)sender;
    NSArray *array = [showArray objectAtIndex:but.tag];
    
    if ([_delegate respondsToSelector:@selector(inserviceButfunc:)]) {
        
        [_delegate inserviceButfunc:array];
    }

}

//退单接口
-(void)noSrviceButfunc:(id)sender{

    
    UIButton *but = (UIButton *)sender;
    NSArray *array = [showArray objectAtIndex:but.tag];

    if ([_delegate respondsToSelector:@selector(noserviceorderfunc:)]) {
        
        [_delegate noserviceorderfunc:array];
    }

}



@end
