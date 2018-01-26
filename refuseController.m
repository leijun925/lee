//
//  refuseController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/28.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "refuseController.h"

@interface refuseController ()

@end

@implementation refuseController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
    
    
    UILabel *orderTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    orderTitle.textColor = [UIColor whiteColor];
    orderTitle.font = [UIFont systemFontOfSize:16.0];
    orderTitle.text = @"拒绝";
    orderTitle.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = orderTitle;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(resorderBlackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    
    [self feedControlerr];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}

#pragma mark -意见反馈控件
-(void)feedControlerr{
    
    
    feedTextFile = [[UITextView alloc]initWithFrame:CGRectMake(10,40,SIZE_WIDTH-20 , 160)];
    [feedTextFile.layer setMasksToBounds:YES];
    [feedTextFile.layer setCornerRadius:5.0];
    feedTextFile.font = [UIFont systemFontOfSize:14.0];
    feedTextFile.backgroundColor = [UIColor whiteColor];
    feedTextFile.keyboardType = UIKeyboardTypeDefault;
    feedTextFile.returnKeyType =UIReturnKeyDone;
    feedTextFile.delegate=self;
    feedTextFile.textAlignment = NSTextAlignmentLeft;
    feedTextFile.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.8];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    palaceLabel = [[UILabel alloc]init];
    palaceLabel.text = @"请输入您要反馈的内容";
    palaceLabel.textColor = [UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:0.6];
    palaceLabel.frame = CGRectMake(5, (feedTextFile.frame.size.height-20)/2, feedTextFile.frame.size.width, 20);
    palaceLabel.font = [UIFont systemFontOfSize:12.0];
    
    [feedTextFile addSubview:palaceLabel];
    
    [self.view addSubview:feedTextFile];
    
    
    UIButton *FeedPlusBut = [UIButton buttonWithType:UIButtonTypeCustom];
    FeedPlusBut.frame = CGRectMake(20, 40+(feedTextFile.frame.size.height)+20+10, SIZE_WIDTH-40, 35);
    [FeedPlusBut.layer setMasksToBounds:YES];
    [FeedPlusBut.layer setCornerRadius:3.0];
    [FeedPlusBut setTitle:@" 提交 " forState:UIControlStateNormal];
    FeedPlusBut.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [FeedPlusBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [FeedPlusBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [FeedPlusBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateHighlighted];
    [FeedPlusBut addTarget:self action:@selector(FeedPlusFuncinfo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:FeedPlusBut];
    
    UITapGestureRecognizer *touchCloseKey = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchCloseFunc:)];
    [self.view addGestureRecognizer:touchCloseKey];
    
}

#pragma -mark -关闭键盘
-(void)touchCloseFunc:(id)sender{
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
}

-(void)FeedBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)FeedPlusFuncinfo:(id)sender{


    NSLog(@"提交");
    
    
    if(feedTextFile.text.length<=0){
    
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请填写拒绝理由哟！" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
           
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];

        return;
        
    }
    
    
    [self sendnoServiceInfoFunc];
    [self.navigationController popViewControllerAnimated:YES];
    

}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    
    palaceLabel.text=@"";
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    NSLog(@"应编辑");
}

//将要结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if(feedTextFile.text.length<=0){
        
        palaceLabel.text = @"请输入您要反馈的内容";
        
    }
    return YES;
    
}

//服务完成接口
-(void)sendnoServiceInfoFunc{
    
    NSString *orderID= [NSString stringWithFormat:@"%@",[_orderArray valueForKey:@"ORDER_ID"]];
    NSString *t_id= [NSString stringWithFormat:@"%@",[_orderArray valueForKey:@"AID"]];
    NSString *td_txt = [NSString stringWithFormat:@"%@",feedTextFile.text];
    NSDictionary *LoginParam=@{@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"order_id":orderID,@"t_id":t_id,@"td_txt":td_txt};
    NSString *service_Url = service;
    NSString *orderService = refuseOrder;
    
    NSString *sendUserInfoUrl=[NSString stringWithFormat:@"%@%@",service_Url,orderService];
    
    NSLog(@"LoginParam------%@",LoginParam);
    NSLog(@"sendUserInfoUrl%@",sendUserInfoUrl);
    //创建请求
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    // UIImage *imagedatalogo = addImage.image;
    
    
    [manager POST:sendUserInfoUrl parameters:LoginParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        // 上传图片，以文件流的格式
        // [formData appendPartWithFormData:imageData name:@"filename"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"成功%@",responseObject);
        //      [quessactivityIndicatorView stopAnimating];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败%@",error);
        //      [quessactivityIndicatorView stopAnimating];
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"提交失败了！请稍后再试好吗 亲^_^" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // [self.navigationController popViewControllerAnimated:YES];
            
        }]];
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }];
    
    
}

-(void)resorderBlackFunc:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
