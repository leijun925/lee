//
//  DataAnalysisController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/6/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "DataAnalysisController.h"

//定义图标和名称的距离常量
static const int  outags = 50;


@interface DataAnalysisController (){

    NSArray *datatitle;


}

@end

@implementation DataAnalysisController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *DataheardView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH, 64)];
    DataheardView.image = [UIImage imageNamed:@"nav.png"];
    DataheardView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:DataheardView];
    
    //标题
    UILabel *datatitleHreadLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 30, SIZE_WIDTH-80, 38)];
    datatitleHreadLabel.text = @"统计分析";
    datatitleHreadLabel.textAlignment = NSTextAlignmentCenter;
    datatitleHreadLabel.textColor = [UIColor whiteColor];
    [datatitleHreadLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]];
    
    [DataheardView addSubview:datatitleHreadLabel];
    
    [self.view addSubview:self.dataTableView];
    
    datatitle=@[@"服务订单量",@"区域统计",@"个人统计",@"服务商服务统计"];


}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}



//懒加载
-(UITableView *)dataTableView{

    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH ,SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.jpg"];
    
    
    if (!_dataTableView) {
        
        _dataTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH, SIZE_HEIGHT) style:UITableViewStylePlain];
        _dataTableView.delegate=self;
        _dataTableView.dataSource = self;
        _dataTableView.backgroundView = imageTableView;
        
        _dataTableView.showsVerticalScrollIndicator = NO;
        _dataTableView.backgroundColor = [UIColor blueColor];
        
        //多余的cell线不现实
        _dataTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        
        //定义表视图分界线颜色透明度
        [_dataTableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                       green:145/255.0
                                                        blue:145/255.0
                                                       alpha:0.2]];
        if ([_dataTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_dataTableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_dataTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_dataTableView setLayoutMargins:UIEdgeInsetsZero];
        }

    }

    return _dataTableView;

}

//表示图协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *cellidentifier = @"dataanaysis";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    
    while (cell.contentView.subviews.count>0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
        
    }
    //定义字符大小
     UIFont *fonts=[UIFont systemFontOfSize:14.0];
    
    if (indexPath.row==0) {
        
        hreadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT*0.22)];
        hreadView.image = [UIImage imageNamed:@"data_bj.png"];
        hreadView.contentMode = UIViewContentModeScaleAspectFill;
        hreadView.clipsToBounds=YES;
        
        [cell.contentView addSubview:hreadView];
        
    }
    if (indexPath.row == 1) {
        
        UIView *NullCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 10)];
        NullCellView.backgroundColor =[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        [cell.contentView addSubview:NullCellView];
    }
    if(indexPath.row == 2){
    
    
        UIImageView *leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 22, 22)];
        leftLogo.image = [UIImage imageNamed:@"user_4.png"];
        leftLogo.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:leftLogo];
        
        
        UILabel *personInfo = [[UILabel alloc]initWithFrame:CGRectMake(outags,10, SIZE_WIDTH-100, 30)];
        personInfo.text = @"公司年度服务次数统计";
        personInfo.textColor = [UIColor blackColor];
        personInfo.font = fonts;
        
        [cell.contentView addSubview:personInfo];

    }

    if(indexPath.row == 3){
        
        
        UIImageView *leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 22, 22)];
        leftLogo.image = [UIImage imageNamed:@"user_4.png"];
        leftLogo.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:leftLogo];
        
        
        UILabel *personInfo = [[UILabel alloc]initWithFrame:CGRectMake(outags, 10, SIZE_WIDTH-100, 30)];
        personInfo.text = @"公司服务类型数据统计";
        personInfo.textColor = [UIColor blackColor];
        personInfo.font = fonts;
        
        [cell.contentView addSubview:personInfo];
        
    }

    if(indexPath.row == 4){
        
        
        UIImageView *leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 22, 22)];
        leftLogo.image = [UIImage imageNamed:@"user_4.png"];
        leftLogo.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:leftLogo];
        
        
        UILabel *personInfo = [[UILabel alloc]initWithFrame:CGRectMake(outags,10, SIZE_WIDTH-100, 30)];
        personInfo.text = @"公司服务员服务次数统计";
        personInfo.textColor = [UIColor blackColor];
        personInfo.font = fonts;
        
        [cell.contentView addSubview:personInfo];
        
    }

//    if(indexPath.row == 5){
//        
//        
//        UIImageView *leftLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 14, 22, 22)];
//        leftLogo.image = [UIImage imageNamed:@"user_4.png"];
//        leftLogo.contentMode = UIViewContentModeScaleAspectFill;
//        [cell.contentView addSubview:leftLogo];
//        
//        
//        UILabel *personInfo = [[UILabel alloc]initWithFrame:CGRectMake(outags,10, SIZE_WIDTH-100, 30)];
//        personInfo.text = @"服务员服务次数数据统计";
//        personInfo.textColor = [UIColor blackColor];
//        personInfo.font = fonts;
//        
//        [cell.contentView addSubview:personInfo];
//        
//    }
    if (indexPath.row!=0 && indexPath.row !=1) {
        
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *strtitle = @"";
    NSString *datapage = @"";
    
    if (indexPath.row == 0) {
        
        return;
    }
    
    if (indexPath.row == 1) {
        
        return;
    }
    
  
    if (indexPath.row == 2 ) {

        strtitle = @"公司年度服务次数统计";
        datapage = @"DATA_ONE";
        
    }
    if (indexPath.row == 3 ) {

        strtitle = @"公司服务类型数据统计";
        datapage = @"DATA_TOW";
        
    }
    if (indexPath.row == 4 ) {

        strtitle = @"公司服务员服务次数统计";
        datapage = @"DATA_THREE";
        
    }
//    if (indexPath.row == 5 ) {
//
//        strtitle = @"服务员服务次数数据统计";
//        datapage = @"DATA_FOVE";
//        
//    }
    
    DataAnalysisinfoController *DataAnalysisinfoCon = [[DataAnalysisinfoController alloc]init];
    DataAnalysisinfoCon.strTitle = strtitle;
    DataAnalysisinfoCon.pagestatus = datapage;
    DataAnalysisinfoCon.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:DataAnalysisinfoCon animated:YES];
        


}


//返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) {
        
        return  SIZE_HEIGHT*0.22;
    }
    
    if (indexPath.row == 1) {
        
        return 10;
    }
    
    return 50;


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
