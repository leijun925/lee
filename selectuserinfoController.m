//
//  selectuserinfoController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/8/21.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "selectuserinfoController.h"

@interface selectuserinfoController (){

    UIImageView *userlogoimage;

}




@end

@implementation selectuserinfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor whiteColor];
    ConTitleView.text = @"派发人员列表";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(closeFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    

    
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    NSLog(@"----userArray---%@",_userArray);
    
    [self.view addSubview:self.tableView];
    
    
    
}

-(void)closeFunc:(id)sender{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

//懒加载
-(UITableView *)tableView{

    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,SIZE_WIDTH,SIZE_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        
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
    }

    return _tableView;
}

//UITableView的协议方法
#pragma mark -返回有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

#pragma mark -返回有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return _userArray.count;

}

#pragma mark -返回每一行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
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
    
    userlogoimage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 8, 44, 44)];
    userlogoimage.image = [UIImage imageNamed:@"logof.png"];
    userlogoimage.layer.cornerRadius = 5;
    userlogoimage.layer.masksToBounds = true;
    userlogoimage.layer.borderColor = [[UIColor whiteColor]CGColor];
    userlogoimage.layer.borderWidth = 2 ;
    
    [cell.contentView addSubview:userlogoimage];
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(60,5, SIZE_WIDTH/2, 20)];
    NSString *userNameclass = [[_userArray objectAtIndex:indexPath.row] valueForKey:@"NAME"];
    userNameclass = [userNameclass getStrsssss:userNameclass];
    userName.text = [NSString stringWithFormat:@"%@",userNameclass];
    userName.textColor = [UIColor colorWithRed:147/255.0
                                        green:145/255.0
                                         blue:145/255.0
                                        alpha:1.0];
    
    userName.font = [UIFont systemFontOfSize:14.0];
    
    [cell.contentView addSubview:userName];

    
    UILabel *usertel = [[UILabel alloc]initWithFrame:CGRectMake(60,25, SIZE_WIDTH/2, 25)];
    NSString *usertelsss = [[_userArray objectAtIndex:indexPath.row] valueForKey:@"ACCOUNT"];
    usertelsss = [usertelsss getStrsssss:usertelsss];
    usertel.text = [NSString stringWithFormat:@"电话:%@",usertelsss];
    usertel.textColor = [UIColor colorWithRed:147/255.0
                                        green:145/255.0
                                         blue:145/255.0
                                        alpha:1.0];
    
    usertel.font = [UIFont systemFontOfSize:12.0];
    
    [cell.contentView addSubview:usertel];
    
    
    
    UILabel *workName = [[UILabel alloc]initWithFrame:CGRectMake(60,50, SIZE_WIDTH/2, 25)];
    NSString *workNameclass = [[_userArray objectAtIndex:indexPath.row] valueForKey:@"ORG_NAME"];
    workNameclass = [workNameclass getStrsssss:workNameclass];

    workName.text = [NSString stringWithFormat:@"所属公司:%@",workNameclass];;
    workName.textColor = [UIColor colorWithRed:147/255.0
                                           green:145/255.0
                                            blue:145/255.0
                                           alpha:1.0];
    
    workName.font = [UIFont systemFontOfSize:12.0];
    
    [cell.contentView addSubview:workName];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
