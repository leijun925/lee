//
//  adminPersonnelViewController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//



#import "adminPersonnelViewController.h"

static const NSString *pagecount = @"10";

@interface adminPersonnelViewController (){

    MJRefreshAutoGifFooter *footer;
    MJRefreshNormalHeader *hread;


}

@end

@implementation adminPersonnelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    showArray= [[NSMutableArray alloc]init];
    page= 1;
    namearray = [[NSMutableArray alloc]init];
    
    UIImageView *adminheardView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH, 64)];
    adminheardView.image = [UIImage imageNamed:@"nav.png"];
    adminheardView.contentMode = UIViewContentModeScaleAspectFill;
    adminheardView.userInteractionEnabled = YES;
    [self.view addSubview:adminheardView];
    
    //标题
    UILabel *admintitleHreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 30, SIZE_WIDTH-160, 38)];
    admintitleHreadLabel.text = @"人员管理";
    admintitleHreadLabel.textAlignment = NSTextAlignmentCenter;
    admintitleHreadLabel.textColor = [UIColor whiteColor];
    [admintitleHreadLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]];
    
    [adminheardView addSubview:admintitleHreadLabel];
    
    
    [self.view addSubview:self.adminatbleview];
    
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.backgroundColor = [UIColor clearColor];
    RightBack.userInteractionEnabled = YES;
    RightBack.frame = CGRectMake(SIZE_WIDTH-80,30,70, 38);
    [RightBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RightBack.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    [RightBack setTitle:@"添加" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(dorctConFunc:) forControlEvents:UIControlEventTouchUpInside];

    [adminheardView addSubview:RightBack];

    
    searchBar=[[UISearchBar  alloc] initWithFrame:CGRectMake(0.0f, 64, SIZE_WIDTH, 44.0f)];
    searchBar.tintColor=[UIColor blackColor];
    searchBar.barTintColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    searchBar.autocorrectionType=UITextAutocorrectionTypeNo;
    searchBar.autocapitalizationType=UITextAutocapitalizationTypeNone;
    searchBar.keyboardType=UIKeyboardTypeDefault;
    searchBar.hidden=NO;
    searchBar.placeholder=[NSString stringWithCString:"搜索"  encoding: NSUTF8StringEncoding];
  //  _adminatbleview.tableHeaderView=searchBar;
    
    searchDc=[[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDc.searchResultsDataSource=self;
    searchDc.searchResultsDelegate=self;
    searchDc.searchBar.backgroundColor = [UIColor whiteColor];
    [searchDc  setActive:NO];
    
    [self.view addSubview:searchBar];
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(UITableView *)adminatbleview{

    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH,SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.jpg"];

    
    if (!_adminatbleview) {
        
        _adminatbleview = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, SIZE_WIDTH, SIZE_HEIGHT-158) style:UITableViewStylePlain];
        _adminatbleview.delegate = self;
        _adminatbleview.dataSource = self;
        _adminatbleview.backgroundView = imageTableView;
        _adminatbleview.showsVerticalScrollIndicator = NO;
        _adminatbleview.backgroundColor = [UIColor blueColor];
        
        _adminatbleview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        if ([_adminatbleview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_adminatbleview setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_adminatbleview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_adminatbleview setLayoutMargins:UIEdgeInsetsZero];
        }
        
        [_adminatbleview setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                       green:145/255.0
                                                        blue:145/255.0
                                                       alpha:0.4]];
        

        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
        hread = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _adminatbleview.mj_header = hread;
        hread.lastUpdatedTimeLabel.hidden = YES;
        // 马上进入刷新状态
        //下拉刷新
        [_adminatbleview.mj_header beginRefreshing];
        //上拉刷新
        
         footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        _adminatbleview.mj_footer = footer;

        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:@"数据刷新中...." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"数据刷新完成" forState:MJRefreshStateNoMoreData];

    }
    return _adminatbleview;;

}

//表视图协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

          return showArray.count;


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
    NSString *workname = [[showArray objectAtIndex:indexPath.row] valueForKey:@"ORG_NAME"];
    workname = [workname getStrsssss:workname];
    servicenum.text = [NSString stringWithFormat:@"所属公司:%@",[[showArray objectAtIndex:indexPath.row] valueForKey:@"ORG_NAME"]];
    servicenum.textColor = [UIColor colorWithRed:147/255.0
                                        green:145/255.0
                                         blue:145/255.0
                                        alpha:1.0];
    
    servicenum.font = [UIFont systemFontOfSize:12.0];
  
    [cell.contentView addSubview:servicenum];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

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

        //创建请求
        manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
        
        //发送POST请求
        [manager POST:sendLoginUrl parameters:LoginParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
            if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"error"]) {
       
            }else{
                
                userArray = [[responseObject valueForKey:@"param"] objectAtIndex:0];
                
                [self arrayselect:userArray];
                [_adminatbleview reloadData];
                
            }
            
            [_adminatbleview.mj_header endRefreshing];
            [_adminatbleview.mj_footer endRefreshing];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [_adminatbleview.mj_header endRefreshing];
            [_adminatbleview.mj_footer endRefreshing];
            
        }];
        
        
    } @catch (NSException *exception) {
        
        NSLog(@"异常");
        
    } @finally {
        
    }
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UserinfoController *UserinfoCon = [[UserinfoController alloc]init];
    UserinfoCon.hidesBottomBarWhenPushed = YES;
    UserinfoCon.userArray = [showArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:UserinfoCon animated:YES];

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

//添加服务员
-(void)dorctConFunc:(id)sender{

    registerCon = [[registerController alloc]init];
    registerNav = [[UINavigationController alloc]initWithRootViewController:registerCon];
    [registerNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.png"] forBarMetrics:UIBarMetricsDefault];
    [self presentViewController:registerNav animated:YES completion:^{
        
        
    }];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
