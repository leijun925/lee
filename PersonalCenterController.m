//
//  PersonalCenterController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "PersonalCenterController.h"

//定义图标和名称的距离常量
static const int  outags = 50;


@interface PersonalCenterController (){

    UIImageView *hreadImageView;

}

@end

@implementation PersonalCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *userheardView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH, 210)];
    userheardView.image = [UIImage imageNamed:@"userlogo.png"];
    userheardView.contentMode = UIViewContentModeScaleAspectFill;
    userheardView.userInteractionEnabled = YES;
    [self.view addSubview:userheardView];
    
    //标题
    UILabel *titleHreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, SIZE_WIDTH-80, 38)];
    titleHreadLabel.text = @"个人中心";
    titleHreadLabel.textAlignment = NSTextAlignmentCenter;
    titleHreadLabel.textColor = [UIColor whiteColor];
    [titleHreadLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]];
    
    [userheardView addSubview:titleHreadLabel];
    

    hreadImageView = [[UIImageView alloc]initWithFrame:CGRectMake((SIZE_WIDTH-80)/2, (210-80)/2, 80, 80)];
    hreadImageView.image = [UIImage imageNamed:@"logof.png"];
    hreadImageView.layer.cornerRadius = 80/2;
    hreadImageView.layer.masksToBounds = true;
    hreadImageView.layer.borderColor = [[UIColor whiteColor]CGColor];
    hreadImageView.userInteractionEnabled = YES;
    hreadImageView.layer.borderWidth = 2 ;

//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userInfoChangeFunc:)];
//    [hreadImageView addGestureRecognizer:tapGesture];
    [userheardView addSubview:hreadImageView];
    
    [self.view addSubview:self.tableView];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

//懒加载表示图
-(UITableView *)tableView{

    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,210, SIZE_WIDTH,SIZE_HEIGHT-68) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                       green:145/255.0
                                                        blue:145/255.0
                                                       alpha:0.2]];
        
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        _tableView.scrollEnabled = NO;
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }

    }

    return _tableView;
}

#pragma mark -返回有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

#pragma mark -返回每块有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}

#pragma mark -返回每一行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.row == 0 || indexPath.row==3 ) {
        
        return 10;
    }
    
    
    return 40;
    
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
    
    UIFont *fonts=[UIFont systemFontOfSize:14.0];
    
    
   

    if (indexPath.row == 1) {
        
        
        UIImageView *leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 22, 22)];
        leftLogo.image = [UIImage imageNamed:@"user_3.png"];
        leftLogo.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:leftLogo];
        
        
        UILabel *personInfo = [[UILabel alloc]initWithFrame:CGRectMake(outags, 5, SIZE_WIDTH-100, 30)];
        personInfo.text = @"修改密码";
        personInfo.textColor = [UIColor blackColor];
        personInfo.font = fonts;
        
        [cell.contentView addSubview:personInfo];
        
    }
    if (indexPath.row == 2) {
        
        
        UIImageView *leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 22, 22)];
        leftLogo.image = [UIImage imageNamed:@"user_4.png"];
        leftLogo.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:leftLogo];
        
        
        UILabel *personInfo = [[UILabel alloc]initWithFrame:CGRectMake(outags, 5, SIZE_WIDTH-100, 30)];
        personInfo.text = @"修改电话";
        personInfo.textColor = [UIColor blackColor];
        personInfo.font = fonts;
        
        [cell.contentView addSubview:personInfo];
        
    }

    if (indexPath.row == 4) {
        
        
        UIImageView *leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9, 22, 22)];
        leftLogo.image = [UIImage imageNamed:@"user_2.png"];
        leftLogo.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:leftLogo];
        
        
        UILabel *personInfo = [[UILabel alloc]initWithFrame:CGRectMake(outags, 5, SIZE_WIDTH-100, 30)];
        personInfo.text = @"注销退出";
        personInfo.textColor = [UIColor blackColor];
        personInfo.font = fonts;
        
        [cell.contentView addSubview:personInfo];
        
    }


    
    if (indexPath.row ==0 || indexPath.row==3 ) {
        
        UIView *NullCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 10)];
        NullCellView.backgroundColor =[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        [cell.contentView addSubview:NullCellView];
        
        
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"index%ld",(long)indexPath.row);
 
    modifyPswdController *modifyPswdCon = [[modifyPswdController alloc]init];
    modifyTelController *modifyTelCon = [[modifyTelController alloc]init];
    
    switch (indexPath.row) {
            
        case 1:
            
            //修改密码
            modifyPswdCon.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyPswdCon animated:YES];
            
            break;

        case 2:
            
            //修改密码
            modifyTelCon.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyTelCon animated:YES];
            
            break;

            
        case 4:
            
            [self ActionUserOutFunc];
            
            break;
            
        default:
            break;
    }
    
    
}

-(void)ActionUserOutFunc{

      UIAlertController *AlertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登陆吗?" preferredStyle:UIAlertControllerStyleAlert];

    [AlertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        NSLog(@"点击取消回调方法");
        
    }]];
    
    [AlertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        NSLog(@"点击确定回调方法");
        

        [USER_DEFAULT setObject:NULL forKey:@"User_Name"];
        [USER_DEFAULT setObject:NULL forKey:@"User_ID"];
        [USER_DEFAULT setObject:NULL forKey:@"ORGID"];
        [USER_DEFAULT setObject:NULL forKey:@"TYPE"];
        [USER_DEFAULT setObject:NULL forKey:@"SERVICEID"];
 
        
        //   [self.navigationController popToRootViewControllerAnimated:YES];
        if ([_delegate respondsToSelector:@selector(PersonalCenterViewFunc)]) {
            
            [_delegate PersonalCenterViewFunc];
            
        }
        
    }]];
    [self presentViewController:AlertCon animated:YES completion:nil];

}

#pragma mark -用户头像
-(void)userInfoChangeFunc:(id)sender{
    NSLog(@"头像");
    
    userLoginController *userlogon = [[userLoginController alloc]init];
    [self.navigationController pushViewController:userlogon animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
