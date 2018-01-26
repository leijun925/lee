//
//  complete_scroller.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/11/22.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "complete_scroller.h"

@interface complete_scroller (){
    UIImageView *imageview;
    NSMutableArray *arrayimage;

}

@end

@implementation complete_scroller

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    arrayimage =[[NSMutableArray alloc]initWithCapacity:10];
    
    for (int x=0; x<_imageArray.count; x++) {
        
        UIImageView *attimage =[[UIImageView alloc]initWithFrame:CGRectMake(x*SIZE_WIDTH, 100, SIZE_WIDTH,SIZE_HEIGHT-200)];

        [arrayimage addObject:attimage];
        
    }
    
    
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<_imageArray.count; i++) {
        
        NSString *imagepath = [[_imageArray objectAtIndex:i] objectForKey:@"IMAGE_PATH"];
        NSString *imagefileName =[NSString stringWithFormat:@"%@%d",[[_imageArray objectAtIndex:i] objectForKey:@"ORDER_ID"],i];
        [self downImageFunc:imagepath imageName:imagefileName black:^(UIImage *image) {
            
            UIImageView *imgsv = (UIImageView *)[arrayimage objectAtIndex:i];
            imgsv.image = image;
            
        }];
        
    }
    

}

//懒加载
-(UIScrollView *)scrollView{

    if ((!_scrollView)) {
        
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 19, SIZE_WIDTH, SIZE_HEIGHT-19);
        _scrollView.pagingEnabled = YES;
        _scrollView.userInteractionEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        
        _scrollView.delegate=self;
        
        for (int i = 0 ; i<_imageArray.count; i++) {
            
            
            UIImageView *imageView=(UIImageView *)[arrayimage objectAtIndex:i];
           
            imageView.image = [UIImage imageNamed:@"loading.jpg"];
            [_scrollView addSubview:imageView];
            
        }
        
        UITapGestureRecognizer *scroMaxZoonImagetap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closecom_scroFunc)];
        
        [_scrollView addGestureRecognizer:scroMaxZoonImagetap];
        //contentSzie定义了一个区域范围，在该区域范围内，UIScrollView可以左右/上下移动。
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*(_imageArray.count),0);
        //ContentOffset当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，。
        [_scrollView setContentOffset:CGPointMake(_nums*_scrollView.frame.size.width, 0)];
        
        
    }
    
    return _scrollView;
    
}

-(void)closecom_scroFunc{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

//下载图片
-(void)downImageFunc:(NSString *)image_url imageName:(NSString *)imageN black:(void(^)(UIImage *image))blockimage{

    
    NSLog(@"imageN----%@",imageN);
    //创建url
    NSString *services_url =service;
    NSString *image_urlpath =[services_url stringByAppendingString:image_url];
    NSURL *URLRquest =[NSURL URLWithString:image_urlpath];
    
    //先判断文件存在是否
    NSString *fileNN =[NSString stringWithFormat:@"%@",imageN];
    
    if ([self isFileExist:fileNN]) {
        
        NSLog(@"存在");
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        NSString *savePath = [cachePath stringByAppendingString:imageN];
        UIImage *image = [UIImage imageWithContentsOfFile:savePath];
        blockimage(image);
        
    }else{
    
        NSLog(@"不存在");

    //创建请求 连接请求
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:URLRquest];
    //利用请求创建对话
    //创建一个对话的session对象
    NSURLSession *session =[NSURLSession sharedSession];
    //创建下载任务
    NSURLSessionDownloadTask *downTask =[session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            //下载失败
        
             NSLog(@"error is :%@",error.localizedDescription);
        
        }else{
        
            //location 是下载图片后保存的临时路径
            NSError *saveError = nil;
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
            NSString *savePath = [cachePath stringByAppendingString:imageN];
            NSLog(@"savePath%@",savePath);
            //移动文件
            NSURL *url =[NSURL fileURLWithPath:savePath];
            [[NSFileManager defaultManager] copyItemAtURL:location toURL:url error:&saveError];
            
            if (!saveError) {
                //保存成功
                UIImage *image = [UIImage imageWithContentsOfFile:savePath];
                blockimage(image);
                
            }else{
                
                NSLog(@"error is :%@",saveError.localizedDescription);
                NSString *fileimagenamepath =[NSString stringWithFormat:@"%@%@",savePath,imageN];
                UIImage *image = [UIImage imageWithContentsOfFile:fileimagenamepath];
                blockimage(image);
            
            }
            
        }
       
    }];
        
         [downTask resume];
    }

}

//判断文件是否存在
-(BOOL) isFileExist:(NSString *)fileName
{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingString:fileName];
    NSLog(@"filePath---%@",filePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
