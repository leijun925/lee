//
//  completeView.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "completeView.h"

static const NSString *pagecount = @"10";

@implementation completeView{

    MJRefreshAutoGifFooter *footer;
    MJRefreshNormalHeader * hread;

}

-(id)initWithFrame:(CGRect)frame dataUrl:(NSString *)url{
    
    self = [super initWithFrame:frame];
    if (self!=nil) {
        
        showArray= [[NSMutableArray alloc]init];
        page= 1;
        self.frame = frame;
        [self addSubview:self.tableView];
        [self GetHttpsDataDoctor];
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
        
        //设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        hread = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_header = hread;
        // 马上进入刷新状态
        [_tableView.mj_header beginRefreshing];
        hread.lastUpdatedTimeLabel.hidden = YES;
        
        footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

        _tableView.mj_footer = footer;
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"数据刷新中...." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"数据刷新完成" forState:MJRefreshStateNoMoreData];
   //     footer.stateLabel.hidden = YES;
      
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
    
    return 100;
    
}

#pragma mark -返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"completeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell== nil) {
        
        //如果cell不存在 创建一个新的 否则去缓存池中去重用
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }
    
    while ([[cell.contentView subviews] count] > 0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 95)];
    cellView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0];
    [cell.contentView addSubview:cellView];
    
    UIImageView *imagelogo = [[UIImageView alloc]initWithFrame:CGRectMake(5, 14, 20,22)];
    imagelogo.image = [UIImage imageNamed:@"order_logo.png"];
    [cellView addSubview:imagelogo];
    
    UILabel *labeltitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, SIZE_WIDTH/2-20, 30)];
    labeltitle.text= [NSString stringWithFormat:@"%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"O_TYPE_C"]];
    labeltitle.textColor = [UIColor blackColor];
    labeltitle.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:labeltitle];
    
    UILabel *orderTime = [[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH/2+10, 10, SIZE_WIDTH/2-20, 30)];
    orderTime.text= [NSString stringWithFormat:@"%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"SEND_CREATEDT"]];;
    orderTime.textAlignment = NSTextAlignmentRight;
    orderTime.textColor = [UIColor colorWithRed:147/255.0
                                          green:145/255.0
                                           blue:145/255.0
                                          alpha:0.8];
    orderTime.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:orderTime];
    
    
    
    UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, SIZE_WIDTH/2-20, 25)];
    infoitle.text= [NSString stringWithFormat:@"服务人员:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"NAME"]];
    infoitle.textColor = [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:0.8];
    infoitle.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:infoitle];
    
    UILabel *sevicestime = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, SIZE_WIDTH-20, 25)];
    sevicestime.text= [NSString stringWithFormat:@"服务完成时间:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"END_TIMEDT"]];
    sevicestime.textColor = [UIColor colorWithRed:147/255.0
                                         green:145/255.0
                                          blue:145/255.0
                                         alpha:0.8];
    sevicestime.font = [UIFont systemFontOfSize:14.0];
    
    [cellView addSubview:sevicestime];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"index%ld",(long)indexPath.row);
    if ([_delegate respondsToSelector:@selector(completeViewFunc: showsarray:)]) {
        
        [_delegate completeViewFunc:indexPath.row showsarray:[showArray objectAtIndex:indexPath.row]];
        
    }
    
}

//已完结订单数据
-(void)GetHttpsDataDoctor{
    
    @try {
    //添加参数
    NSString *srepage = [NSString stringWithFormat:@"%d",page];
    NSString *SERVICEID = [NSString stringWithFormat:@"%@",[USER_DEFAULT objectForKey:@"SERVICEID"]];
    NSDictionary *LoginParam=@{@"SERVICEID":SERVICEID,@"stat":@"3",@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"pagecount":pagecount,@"page":srepage};
    NSString *service_Url = service;
    NSString *login_Url = completeorder;
    NSString *sendLoginUrl=[NSString stringWithFormat:@"%@%@",service_Url,login_Url];

    NSLog(@"LoginParam-------%@",LoginParam);
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    //发送POST请求
    [manager POST:sendLoginUrl parameters:LoginParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"----responseObject---x---x----%@",responseObject);

        if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"error"]) {
            
            
        }else{
            
        orderArray = [[responseObject valueForKey:@"param"] objectAtIndex:0];
        
        [self arrayselect:orderArray];
        
        [_tableView reloadData];
         
        
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    }];
        
    } @catch (NSException *exception) {
    
    NSLog(@"异常3");
        
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];

    
    } @finally {
        
        
    
    }
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
@end //completeView
