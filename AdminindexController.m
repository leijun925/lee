//
//  AdminindexController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "AdminindexController.h"
static const int safety= 157;

@interface AdminindexController (){

    UIView *bottomView;
    NSArray *strTitleArray;
}

@end

@implementation AdminindexController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    statubut = 0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *heardView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH, 64)];
    heardView.image = [UIImage imageNamed:@"nav.png"];
    heardView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:heardView];
    
    //标题
    UILabel *titleHreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 26, SIZE_WIDTH-40, 38)];
    titleHreadLabel.text = @"12349 智慧养老服务通";
    titleHreadLabel.textColor = [UIColor whiteColor];
    [titleHreadLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]];
    
    [heardView addSubview:titleHreadLabel];

    
    [self TopscrollerView];

    [self chushihuatableview];
    [self ContentScrollerView];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self chushihuatableview];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}


//上滑动菜单

-(void)TopscrollerView{

    arrabut = [[NSMutableArray alloc]init];
    strTitleArray =@[@"待派订单",@"已派订单",@"已经完成"];
    UIView *topScroview = [[UIView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH,48)];
    topScroview.userInteractionEnabled = YES ;
    for (int i=0; i<strTitleArray.count; i++) {
        
        UIButton * but = [UIButton  buttonWithType:UIButtonTypeCustom];
        but.frame =  CGRectMake(i*(SIZE_WIDTH/strTitleArray.count)+(SIZE_WIDTH/strTitleArray.count-(SIZE_WIDTH/strTitleArray.count)/2)/2,12, (SIZE_WIDTH/strTitleArray.count)/2,topScroview.frame.size.height/2);
        [but setTitle:[strTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
        but.tag = i;
        if(i==0){
        
            [self selectfun:but];
        }
        [but addTarget:self action:@selector(TopScrollerFuncs:) forControlEvents:UIControlEventTouchUpInside];
        [but setBackgroundColor:[UIColor whiteColor]];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        [topScroview addSubview:but];
        [arrabut addObject:but];
    }
    
//    TopScrollerView *scroView = [[TopScrollerView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH, 40) titeleArray:strTitleArray];
//    scroView.delegate = self;
    [self.view addSubview:topScroview];

} 


-(void)TopScrollerFuncs:(id)index{

    UIButton *but = (UIButton *)index;
    NSInteger indexnum = but.tag;
    CGPoint Ponit =CGPointMake(SIZE_WIDTH*indexnum, 0);
    [_scrollView setContentOffset:Ponit animated:YES];
    
//    NSInteger butindex = scrollView.contentOffset.x/SIZE_WIDTH;
//    bottomView.frame=CGRectMake(indexstatus*(SIZE_WIDTH/3),106,bottomView.frame.size.width, 2);
    
    for (int i =0; i<arrabut.count; i++) {
        
        if (i == indexnum) {
            
            UIButton *bs = arrabut[i];
            [self selectfun:bs];
            
        }else if(i == statubut){
            
            UIButton *buts =  (UIButton *)arrabut[i];
            [self selectfunsmil:buts];
        }
    }
    
    statubut = indexnum;

}


//滚动展示
-(void)ContentScrollerView{

    
    [self.view addSubview:self.scrollView];


}
//scrollView懒加载
-(UIScrollView *)scrollView{

    if (!_scrollView) {
        
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,116, SIZE_WIDTH,SIZE_HEIGHT-safety)];
        
       
        for (int i=0; i<strTitleArray.count; i++) {
            
          if (i==0) {

//                ordertable.delegate = self;
//                [_scrollView addSubview:ordertable];
              
          }else if(i==1){
          
              
          }else if (i==2){
          
             
          
          }
          
          else{
            
                UITableView *tableview = [[UITableView alloc]init];
                tableview.frame = CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height);
                tableview.backgroundColor = [UIColor redColor];
                [_scrollView addSubview:tableview];
          }
            
        }
      
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;

        _scrollView.delegate=self;
        //contentSzie定义了一个区域范围，在该区域范围内，UIScrollView可以左右/上下移动。
        _scrollView.contentSize = CGSizeMake(SIZE_WIDTH*3,0);
        //ContentOffset当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，。
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        
        
    }

    return _scrollView;
}

//滚动指示条
-(void)ScrollerGunView{

    bottomView= [[UIView alloc]initWithFrame:CGRectMake(0,106, SIZE_WIDTH/3, 2)];
    bottomView.backgroundColor = [UIColor colorWithRed:255/255.0
                                                 green:139/255.0
                                                  blue:148/255.0
                                                 alpha:1.0];
    
    [self.view addSubview:bottomView];

}


//scrollview协议方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

////    float indexstatus = scrollView.contentOffset.x/SIZE_WIDTH;
//    NSInteger butindex = scrollView.contentOffset.x/SIZE_WIDTH;
//    
////    bottomView.frame=CGRectMake(indexstatus*(SIZE_WIDTH/3),106,bottomView.frame.size.width, 2);
//
//    for (int i =0; i<arrabut.count; i++) {
//        
//        if (i == butindex) {
//            
//            UIButton *bs = arrabut[i];
//            [self selectfun:bs];
//            
//        }else if(i == statubut){
//   
//            UIButton *buts =  (UIButton *)arrabut[i];
////            [UIView animateWithDuration:0.3 animations:^{
////               buts.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0];
////            }];
//            [self selectfunsmil:buts];
//        }
//    }
//    
//    statubut = butindex;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //    float indexstatus = scrollView.contentOffset.x/SIZE_WIDTH;
    NSInteger butindex = scrollView.contentOffset.x/SIZE_WIDTH;
    
    //    bottomView.frame=CGRectMake(indexstatus*(SIZE_WIDTH/3),106,bottomView.frame.size.width, 2);
    
    for (int i =0; i<arrabut.count; i++) {
        
        if (i == butindex) {
            
            UIButton *bs = arrabut[i];
            [self selectfun:bs];
            
        }else if(i == statubut){
            
            UIButton *buts =  (UIButton *)arrabut[i];
            [self selectfunsmil:buts];
        }
    }
    
    statubut = butindex;
    
    NSLog(@"butindex---%ld",(long)butindex);
    
    [self chushihuatableview];
    

}

//ordertableview 协议方法现实
-(void)OrderTableViewFunc:(NSInteger)index orderArrray:(NSArray *)array{

    OrderInfoController *orderCon = [[OrderInfoController alloc]init];
    orderCon.orderInfoArray = array;
    orderCon.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:orderCon animated:YES];

}

//所有滚动tableview初始化函数
-(void)chushihuatableview{

    ordertable = [[OrderTableView alloc]initWithFrame:CGRectMake(0*_scrollView.frame.size.width,0, _scrollView.frame.size.width,_scrollView.frame.size.height) dataUrl:@"leijun"];
    ordertable.delegate = self;
    [_scrollView addSubview:ordertable];
    
    alreadytable = [[AlreadyTableView alloc]initWithFrame:CGRectMake(1*_scrollView.frame.size.width,0, _scrollView.frame.size.width,_scrollView.frame.size.height) dataUrl:@"lee"];
    alreadytable.delegate = self;
    [_scrollView addSubview:alreadytable];


    complete =[[completeView alloc]initWithFrame:CGRectMake(2*_scrollView.frame.size.width,0, _scrollView.frame.size.width,_scrollView.frame.size.height) dataUrl:@"dee"];
    complete.delegate = self;
    [_scrollView addSubview:complete];
}


//completeViewDelegate 协议方法现实
-(void)completeViewFunc:(NSInteger)index showsarray:(NSArray *)array{

    completeController *completeCon = [[completeController alloc]init];
    completeCon.orderInfoArray = array;
    completeCon.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:completeCon animated:YES];
    
}

//alreadyTableview。 协议方法实现
-(void)alreadorderinfo:(NSArray *)array{
    
    usrCompleteController *userViewrecor=[[usrCompleteController alloc]init];
    userViewrecor.status = @"admincon";
    userViewrecor.orderInfoArray = array;
    userViewrecor.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userViewrecor animated:YES];
    
}

//派发人员名单协议
-(void)SELECTUSERINFO:(NSArray *)array{
    
    NSLog(@"SELECTUSERFUNC--%@",array);
    
    [self getsenduserinfofunc:array];
    
    



}


-(void)RECFORDERFUNC:(NSArray *)array{

    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定重新派发该工单吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self sendorderfunc:array];
        
    }]];
    
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertCon animated:YES completion:nil];


}

-(void)selectFunc:(id)sender{
    
    UIButton *buts =(UIButton *)sender;
    NSInteger selectIndex = buts.tag;
 
    [self TopScrollerFunc:selectIndex];
    
}

//缩放按钮动画
-(void)selectfun:(UIButton *)sender{
    
    UIButton *senderbutlay = (UIButton *)sender;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //设定动画持续时间
    animation.duration = 0.1;
    //设定重复次数
    animation.repeatCount = 0;
    //结束时候逆行动画
    animation.autoreverses = NO;

    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.5]; // 结束时的倍率
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //添加动画
    [senderbutlay.layer addAnimation:animation forKey:@"scale-layer"];
    
    
}

//缩放按钮动画
-(void)selectfunsmil:(UIButton *)sender{
    
    UIButton *senderbutlay = (UIButton *)sender;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //设定动画持续时间
    animation.duration = 0.1;
    //设定重复次数
    animation.repeatCount = 0;
    //结束时候逆行动画
    animation.autoreverses = NO;
    
    animation.fromValue = [NSNumber numberWithFloat:1.5]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:1.0]; // 结束时的倍率
    
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //添加动画
    [senderbutlay.layer addAnimation:animation forKey:@"scale-layer"];
    
    
}

//获取人员列表
-(void)getsenduserinfofunc:(NSArray *)array{
    
    @try {
        //添加参数
        NSString *a_id = [array valueForKey:@"AID"];
        NSDictionary *LoginParam=@{@"aid":a_id,@"User_id":[USER_DEFAULT objectForKey:@"User_ID"]};
        NSString *service_Url = service;
        NSString *login_Url = getsenduserinfo;
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
            
            NSLog(@"responseObject---%@",responseObject);
            
            if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"error"]) {
                
                
            }else{
                
                orderArray = [[responseObject valueForKey:@"param"] objectAtIndex:0];
                
                selectuserinfo  = [[selectuserinfoController alloc]init];
                selectuserinfo.userArray = orderArray;
                selectuserinfoNav = [[UINavigationController alloc]initWithRootViewController:selectuserinfo];
                [selectuserinfoNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav.png"] forBarMetrics:UIBarMetricsDefault];
                [self presentViewController:selectuserinfoNav animated:YES completion:^{
                    
                }];
                
                
            }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    } @catch (NSException *exception) {
        
        NSLog(@"异常2");
        
    } @finally {
        
    }
    
    
}

//重新派发工单
-(void)sendorderfunc:(NSArray *)array{
    
    @try {
        //添加参数
        NSString *a_id = [array valueForKey:@"AID"];
        NSString *ORDER_ID = [array valueForKey:@"ORDER_ID"];
        NSDictionary *LoginParam=@{@"aid":a_id,@"User_id":[USER_DEFAULT objectForKey:@"User_ID"],@"order_id":ORDER_ID};
        NSString *service_Url = service;
        NSString *login_Url = sendaglinorderfunc;
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
            
            NSLog(@"responseObject---%@",responseObject);
            
            if ([[[responseObject objectAtIndex:0] valueForKey:@"result"] isEqualToString:@"error"]) {
                
                
            }else{
                
                UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"工单已经取消成功，如有需要请重新派发" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self chushihuatableview];
                    
                }]];
                
               [self presentViewController:alertCon animated:YES completion:nil];

                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
        }];
    } @catch (NSException *exception) {
        
        NSLog(@"异常2");
        
    } @finally {
        
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
