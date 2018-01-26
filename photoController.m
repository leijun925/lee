//
//  photoController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/7/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "photoController.h"

@interface photoController (){

  

}

@end

@implementation photoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"--s----");

    self.view.backgroundColor = [UIColor whiteColor];

    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"选择图片";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(photocloaeFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    UIButton *RightBack = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBack.backgroundColor = [UIColor clearColor];
    RightBack.titleLabel.font = [UIFont systemFontOfSize:12.0];
    RightBack.frame = CGRectMake(0, 0,70, 30);
    [RightBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    RightBack.titleLabel.font = [UIFont fontWithName:@"ArialHebrew" size:14.0];
    [RightBack setTitle:@"保存" forState:UIControlStateNormal];
    [RightBack addTarget:self action:@selector(saveimageConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBack];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *bottomBut = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBut.frame = CGRectMake(0, SIZE_HEIGHT-44-64, SIZE_WIDTH, 44);
    [bottomBut setTitle:@"拍照" forState:UIControlStateNormal];
    [bottomBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bottomBut setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav"]]];
    [bottomBut addTarget:self action:@selector(photoFunc) forControlEvents:UIControlEventTouchUpInside];
    
  
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.CollectionView addGestureRecognizer:_longPress];
    [self.view addSubview:self.CollectionView];
    
    [self.view addSubview:bottomBut];
}

//添加一个collectionView 用于展示多个选择上传的图片
-(UICollectionView *)CollectionView{

    if (!_CollectionView) {
        
        UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
        //设定每一个cell的大小
        layout.itemSize=CGSizeMake(SIZE_WIDTH/3,SIZE_WIDTH/3);
        layout.minimumLineSpacing = 0;
        // 设置垂直间距
        layout.minimumInteritemSpacing = 0;
        
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _CollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, SIZE_WIDTH, SIZE_HEIGHT-20) collectionViewLayout:layout];
        
        _CollectionView.backgroundColor = [UIColor whiteColor];
        _CollectionView.delegate = self;
        _CollectionView.dataSource = self;
        
        //手动注册视图类了
        [_CollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
      
        
        }
    

    return _CollectionView;

}



//实现代理类
#pragma mark -返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

#pragma mark -返回每个分区中cell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _selectImageArray.count;
    
}



#pragma mark -返回每个collectionCell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    //如果重用了cell 把cell里面的contengView的内容清空
    while ([[cell.contentView subviews] count]>0) {
        
        NSLog(@"collectionView");
        //如果contentView中的子视图数量不是0 就说明有子视图
        
        [[[cell.contentView subviews] objectAtIndex:0]
         removeFromSuperview];
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0,10, SIZE_WIDTH/3, SIZE_WIDTH/3-10)];
    imageView.image= [_selectImageArray objectAtIndex:indexPath.row];
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
    cell.selected = YES;
    [cell.contentView addSubview:imageView];
    
    UIButton *deletebut = [UIButton buttonWithType:UIButtonTypeCustom];
    [deletebut setImage:[UIImage imageNamed:@"PayButYes"] forState:UIControlStateNormal];
    deletebut.frame = CGRectMake(0, 0, 50, 50);
    deletebut.tag = indexPath.row;
    deletebut.hidden = YES;
    deletebut.selected = NO;
    [deletebut addTarget:self action:@selector(deleteimagefunc:) forControlEvents:UIControlEventTouchUpInside];

    [cell.contentView addSubview:deletebut];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"%ld",(long)indexPath.row);
    scrollerPhotoController *scro= [[scrollerPhotoController alloc]init];
    scro.imageArray = _selectImageArray;
    scro.nums = indexPath.row;
    [self presentViewController:scro animated:YES completion:^{
        
       
    }];
    



}


#pragma mark -调取相册 添加附件
-(void)photoFunc{

    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        //点击取消调用的方法
        
    }]];
    
    UIImagePickerController *imagePickerCon = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied){
                //无权限 做一个友好的提示
                UIAlertController *alertCons = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机->设置->隐私->相机" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertCons addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [self presentViewController:alertCons animated:YES completion:nil];
                return;
                
            } else {
                //调用相机的代码写在这里
                imagePickerCon.delegate = self;
                imagePickerCon.allowsEditing = YES;
                imagePickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerCon animated:YES completion:^{
                    
                }];
            }
    
        }]];
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"相册图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //点击确认调用的方法
            
            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
            if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
            {
                // 无权限
                // do something...
                UIAlertController *alertCons = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的相机->设置->隐私->相机" preferredStyle:UIAlertControllerStyleAlert];
                
                [alertCons addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [self presentViewController:alertCons animated:YES completion:nil];
                return;
                
            }else {
                NSLog(@"相册图片");
                // UIImagePickerController *imagePickerCon = [[UIImagePickerController alloc]init];
                imagePickerCon.delegate = self;
                imagePickerCon.allowsEditing = YES;
                imagePickerCon.videoMaximumDuration = 5;
                imagePickerCon.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:imagePickerCon animated:YES completion:^{
                    
                }];
            }
            
        }]];
    }
    
    // 由于它是一个控制器 直接modal出来就好了
    
    [self presentViewController:alertCon animated:YES completion:nil];
    
}


#pragma mark -选择完成后调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    NSLog(@"选取");
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //保存图片侄本地 上传图片到服务器需要使用
 //   NSString *fullpath = [self saveImage:image witchName:@"avatar.png"];
    
    //  NSString *fullpath = [[NSHomeDirectory() stringByAppendingString:@"Documents"] stringByAppendingPathComponent:@"avatar.png"];
    
//    UIImage *saveimage = [[UIImage alloc]initWithContentsOfFile:fullpath];
    
 //   addImage.image =image;
    
    [_selectImageArray addObject:image];
    
    
    [_CollectionView reloadData];
    
}



-(void)photocloaeFunc:(id)sender{


    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
  

}

-(void)saveimageConFunc:(id)sender{

    if([_delegate respondsToSelector:@selector(saveimageArray:)]){
    
        [_delegate saveimageArray:_selectImageArray];
    
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    
        
    }];

}


//长压手势判断
-(void)lonePressMoving:(UILongPressGestureRecognizer *)longPress{

    switch (longPress.state) {
            
        case UIGestureRecognizerStateBegan:
        {
            
            
            NSLog(@"-----常压-----");
            NSIndexPath *selectIndexPath = [self.CollectionView indexPathForItemAtPoint:[_longPress locationInView:self.CollectionView]];
            NSLog(@"----selectIndexPath---%ld",(long)selectIndexPath.row);
            // 找到当前的cell
            UICollectionViewCell *cell = (UICollectionViewCell *)[self.CollectionView cellForItemAtIndexPath:selectIndexPath];
            
            UIButton *but = (UIButton *)[[cell.contentView subviews] objectAtIndex:1];
            
            NSLog(@"cell---%@",cell);
            
            if(but.selected == NO){
                NSLog(@"noooooooo");
             //   cell.selected = NO;
                but.selected=YES;
                but.hidden = NO;
                
            }else{
            
                NSLog(@"yesssssss");
            //    cell.selected = YES;
                but.selected=NO;
                but.hidden = YES;
               
            
            }
       
            
            
            
            // 定义cell的时候btn是隐藏的, 在这里设置为NO
           //            cell.btnDelete.tag = selectIndexPath.item;
//            
//            //添加删除的点击事件
//            [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
            
//            [_CollectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
        }
            
                      break;
            
        default:
            break;
    }

}

- (void)btnDelete:(UIButton *)btn{


    
}

-(void)deleteimagefunc:(id)sender{

    NSLog(@"delete");
    UIButton *but = (UIButton *)sender;
    [_selectImageArray removeObjectAtIndex:but.tag];
    
    [_CollectionView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
