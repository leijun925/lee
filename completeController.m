//
//  completeController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "completeController.h"

@interface completeController ()

@end

@implementation completeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    imageSaveArray  = [[NSMutableArray alloc]init];
    loadimageArray  = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"orderInfoArray------%@",_orderInfoArray);
    imageSaveArray = [[NSMutableArray alloc]init];
    UILabel *orderTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    orderTitle.textColor = [UIColor whiteColor];
    [orderTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]];
    orderTitle.text = @"服务详情";
    orderTitle.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = orderTitle;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(completeorderBlackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    [self startOrderupdatafunc];
    
    [self.view addSubview:self.tableView];
    
//    if([_status isEqualToString:@"admin"]){
//        
//        [self banjiebutfunc];
//        
//    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

//懒加载
-(UITableView *)tableView{
    
    //状态栏高度
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    //导航栏高度
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    
    NSLog(@"加载懒吗");
    if(!_tableview){
        
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, SIZE_WIDTH, SIZE_HEIGHT-rectOfStatusbar.size.height-rectOfNavigationbar.size.height-10) style:UITableViewStylePlain];
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
    
    return 19+imagearray.count;
    
}

#pragma mark -返回每一行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row ==17) {
        
        return 80;
        
    }
    if (indexPath.row > 18) {
        
        return 260;
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
        ordertitle.text=[NSString stringWithFormat:@"订单任务名称:%@",[completeorderarray valueForKey:@"TYPENAME"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    else if (indexPath.row == 1) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text= [NSString stringWithFormat:@"订单发起时间:%@",[completeorderarray valueForKey:@"CREATEDT"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    
    else if (indexPath.row == 2) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text= [NSString stringWithFormat:@"订单分配时间:%@",[completeorderarray valueForKey:@"SENDCREATEDT"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    else if (indexPath.row == 3 ) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text= [NSString stringWithFormat:@"订单接受时间:%@",[completeorderarray valueForKey:@"REC_TIME_N"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    
    else if (indexPath.row == 4) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text= [NSString stringWithFormat:@"开始服务时间:%@",[completeorderarray valueForKey:@"START_TIME_N"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
        
    }
    
    else if (indexPath.row == 5) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text=[NSString stringWithFormat:@"服务完成时间:%@",[completeorderarray valueForKey:@"END_TIME_N"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];    }
    
    else if (indexPath.row == 6) {
        
        UILabel *ordertitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        ordertitle.text=[NSString stringWithFormat:@"服务用时间:%@",[completeorderarray valueForKey:@"ENDTIMESS"]];
        ordertitle.textAlignment = NSTextAlignmentLeft;
        ordertitle.textColor = [UIColor colorWithRed:147/255.0
                                               green:145/255.0
                                                blue:145/255.0
                                               alpha:1.0];
        ordertitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:ordertitle];
    }
    
    
    
    else if (indexPath.row == 7) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        infoitle.text= [NSString stringWithFormat:@"客户名称:%@",[completeorderarray valueForKey:@"C_NAME"]];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    
    else if (indexPath.row == 8) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        infoitle.text= [NSString stringWithFormat:@"客户地址:%@",[completeorderarray valueForKey:@"SERVICE_ADDR"]];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
        
    }
    
    else if (indexPath.row == 9) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"MOBILE"];
        usertel = [usertel getStrsssss:usertel];
        infoitle.text=[NSString stringWithFormat:@"客户电话:%@",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    else if (indexPath.row == 10) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"PRICE"];
        usertel = [usertel getStrsssss:usertel];
        
        infoitle.text=[NSString stringWithFormat:@"服务单价:%@ 元",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    
    else if (indexPath.row == 11) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"QUANTITY"];
        usertel = [usertel getStrsssss:usertel];
        
        infoitle.text=[NSString stringWithFormat:@"服务次数:%@ 次",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    
    else if (indexPath.row == 12) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"PAY"];
        usertel = [usertel getStrsssss:usertel];
        
        infoitle.text=[NSString stringWithFormat:@"账户支付:%@ 元",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    
    else if (indexPath.row == 13) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"SELFPAY"];
        usertel = [usertel getStrsssss:usertel];
        
        infoitle.text=[NSString stringWithFormat:@"个人支付:%@ 元",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    
    else if (indexPath.row == 14) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"TOTAL"];
        usertel = [usertel getStrsssss:usertel];
        
        infoitle.text=[NSString stringWithFormat:@"结算总额:%@ 元",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }

    else if (indexPath.row == 15) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"SERVICE_REQUIREMENT"];
        usertel = [usertel getStrsssss:usertel];

        infoitle.text=[NSString stringWithFormat:@"客户需求:%@",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    
    else if (indexPath.row == 16) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        infoitle.text= [NSString stringWithFormat:@"服务人员:%@",[completeorderarray valueForKey:@"NAME"]];;
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:infoitle];
    }
    
    else if (indexPath.row == 17) {
        
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        NSString *usertel = [completeorderarray valueForKey:@"BZ_TXT"];
        usertel = [usertel getStrsssss:usertel];
        infoitle.text= [NSString stringWithFormat:@"备注:%@",usertel];
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        infoitle.numberOfLines = 0;
        
        [cell.contentView addSubview:infoitle];
        
    }
    
    else if (indexPath.row == 18) {
        
        UILabel *infoitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-40, 40)];
        infoitle.text= @"工作照片";
        infoitle.textColor = [UIColor colorWithRed:147/255.0
                                             green:145/255.0
                                              blue:145/255.0
                                             alpha:0.8];
        infoitle.font = [UIFont systemFontOfSize:14.0];
        infoitle.numberOfLines = 0;
        
        [cell.contentView addSubview:infoitle];
    }
    else{
        
        NSString *iamgeurlpath = [NSString stringWithFormat:@"%@",[[imagearray objectAtIndex:indexPath.row-19] valueForKey:@"IMAGE_PATH"]];
        NSString *service_Url = service;
        NSString *imageuserserr = [NSString stringWithFormat:@"%@%@",service_Url,iamgeurlpath];
        NSLog(@"imageuserserr----%@",imageuserserr);
        AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(40, 10, SIZE_WIDTH-80, 250)];
        asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
        asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",service_Url,iamgeurlpath];
        asynImageView.contentMode=UIViewContentModeScaleAspectFill;
        asynImageView.clipsToBounds=YES;
        
        asynImageView.userInteractionEnabled = YES;
        asynImageView.tag = indexPath.row-19;
        
        //        [loadimageArray addObject:asynImageView.image];
        
        UITapGestureRecognizer *addImageTap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImageTapFuncs:)];
        addImageTap.view.tag = asynImageView.tag;
        [asynImageView addGestureRecognizer:addImageTap];
        
        //        NSString *imageurl = [[imageSaveArray objectAtIndex:indexPath.row-15] valueForKey:@"IMAGE_PATH"];
        //        wordimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, SIZE_WIDTH-20, 200)];
        //        wordimage.contentMode = UIViewContentModeScaleToFill;
        //        wordimage.image = [imageSaveArray objectAtIndex:indexPath.row-15];
        //      NSString *imagenamesss =[NSString stringWithFormat:@"%@%ld",[completeorderarray valueForKey:@"AID"],(long)indexPath.row];
        //      NSString *imagenamesss =[NSString stringWithFormat:@"%@",@"123"];
        //  [self dowlntaskfunc:imageurl imageName:[NSString stringWithFormat:@"%@",imagenamesss]];
        [cell.contentView addSubview:asynImageView];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)orderinfofunc:(id)sender{
    
    
    NSLog(@"orderinfofunc");
    
}

-(void)completeorderBlackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)startOrderupdatafunc{
    
    //添加参数
    
    NSString *Order_id = [NSString stringWithFormat:@"%@",[_orderInfoArray valueForKey:@"ORDER_ID"]];
    NSString *t_id = [NSString stringWithFormat:@"%@",[_orderInfoArray valueForKey:@"AID"]];
    NSString *User_id =[NSString stringWithFormat:@"%@",[_orderInfoArray valueForKey:@"USER_ID"]];
  
    NSDictionary *Param=@{@"User_id":User_id,@"t_id":t_id,@"Order_id":Order_id};
    NSString *service_Url = service;
    NSString *login_Url = completeorderinfo;
    NSString *sendLoginUrl=[NSString stringWithFormat:@"%@%@",service_Url,login_Url];
    NSLog(@"sendLoginUrl---%@",Param);
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    
    //发送POST请求
    [manager POST:sendLoginUrl parameters:Param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSLog(@"----responseObject---5-%@",responseObject);
        
        if([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"error"]){
            
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"订单信息出现问题，请联系管理！" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [self presentViewController:alertCon animated:YES completion:nil];
            
        }else{
            
            completeorderarray = [[responseObject valueForKey:@"param"] objectAtIndex:0];
            imagearray = [completeorderarray valueForKey:@"imagearray"];
            
            NSLog(@"imagearray---%@",imagearray);
            
            
            for (int i=0; i<imagearray.count; i++) {
                
//              NSString *imagenamesss =[NSString stringWithFormat:@"%@%d",[completeorderarray valueForKey:@"AID"],i];
                NSString *iamgeurlpath = [NSString stringWithFormat:@"%@",[[imagearray objectAtIndex:i] valueForKey:@"IMAGE_PATH"]];
                NSLog(@"iamgeurlpath---%@",iamgeurlpath);
                
                AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(60, 10, SIZE_WIDTH-120, 240)];
                asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
                asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",service_Url,iamgeurlpath];
                asynImageView.contentMode = UIViewContentModeScaleAspectFit;
                asynImageView.clipsToBounds=YES;
                asynImageView.userInteractionEnabled = YES;
        //        [loadimageArray addObject:asynImageView.image];
                
                // [self dowlntaskfunc:iamgeurlpath imageName:imagenamesss];
                
            }
            
            [_tableview reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败%@",error);
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示提示" message:@"订单信息获取失败了！请您检查下网络连接是否正常！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }];
}


//下载任务
-(void)dowlntaskfunc:(NSString *)imageURL imageName:(NSString *)imgName{
    
    NSString *fileName = imgName;
    NSString *service_Url = service;
    NSString *imageuserserr = [NSString stringWithFormat:@"%@%@",service_Url,imageURL];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@",imageuserserr];
    
    
    urlStr  = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //创建下载任务
    
    NSURLSessionDownloadTask *downtask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"-----下载任务-----");
        
        if(!error){
            
            NSError *saveError = nil;
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
            NSString *savePath = [cachePath stringByAppendingString:fileName];
            NSLog(@"%@",savePath);
            NSURL *url = [NSURL fileURLWithPath:savePath];
            [[NSFileManager defaultManager]copyItemAtURL:location toURL:url error:&saveError];
            
            if (!saveError) {
                
                NSLog(@"save success");
                
                imagepath = savePath;
                //    BOOL isfile = [self isFileExist:]
                
                UIImage *images = [UIImage imageNamed:imagepath];
                [imageSaveArray addObject:images];
                
                
            }else{
                
                NSLog(@"error is :%@",saveError.localizedDescription);
            }
        }else{
            
            NSLog(@"error is :%@",error.localizedDescription);
        }
        
    }];
    
    //执行下载任务
    [downtask resume];
    
    
}

-(void)banjiebutfunc{
    
    //状态栏高度
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    //导航栏高度
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    UIButton *bjbut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bjbut.frame =CGRectMake(0,SIZE_HEIGHT-rectOfStatusbar.size.height-rectOfNavigationbar.size.height-50, SIZE_WIDTH, 50);
    [bjbut setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav"]]];
    [bjbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bjbut setTitle:@" 办结工单 " forState:UIControlStateNormal];
    [bjbut addTarget:self action:@selector(bjorderButfunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:bjbut];
}

//判断文件是否存在
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}

//完成订单办结函数
-(void)bjorderButfunc:(id)sender{
    
    [self sendsmsfunc];
    
 /**
    NSString *Order_id = [NSString stringWithFormat:@"%@",[_orderInfoArray valueForKey:@"ORDER_ID"]];
    NSString *t_id = [NSString stringWithFormat:@"%@",[_orderInfoArray valueForKey:@"AID"]];
    
    NSDictionary *LoginParam=@{@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"aid":t_id,@"order_id":Order_id};
    NSString *service_Url = service;
    NSString *orderService = bjorder;
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
            
            NSLog(@"办结完成");
            
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    **/
}

-(void)addImageTapFuncs:(id)sender{
    
    NSLog(@"---s--");
    
    NSMutableArray *imageatt = [imagearray copy];
    complete_scroller *com_scr= [[complete_scroller alloc]init];
    com_scr.imageArray = imageatt;
    [self presentViewController:com_scr animated:YES completion:^{
        
        
    }];
    
}

-(void)sendsmsfunc{

    userSmsendController *sendsmsCon = [[userSmsendController alloc]init];
    [self presentViewController:sendsmsCon animated:YES completion:^{
        
        
    }];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
