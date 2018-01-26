//
//  scrollerPhotoController.m
//  ServiceConnectionApp
//
//  Created by lee on 2017/7/24.
//  Copyright © 2017年 lee. All rights reserved.
//

#import "scrollerPhotoController.h"

@interface scrollerPhotoController ()

@end

@implementation scrollerPhotoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];

}

//懒加载
-(UIScrollView *)scrollView{

    NSLog(@"lanjiazai");
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
            
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*_scrollView.frame.size.width, 0, _scrollView.frame.size.width,_scrollView.frame.size.height)];
            imageview.image = [_imageArray objectAtIndex:i];
            [_scrollView addSubview:imageview];
            
        }

        UITapGestureRecognizer *scroMaxZoonImagetap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeConmodelFunc)];
        
        [_scrollView addGestureRecognizer:scroMaxZoonImagetap];
        //contentSzie定义了一个区域范围，在该区域范围内，UIScrollView可以左右/上下移动。
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*(_imageArray.count),0);
        //ContentOffset当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，。
        [_scrollView setContentOffset:CGPointMake(_nums*_scrollView.frame.size.width, 0)];

        
    }
    
    return _scrollView;

}

-(void)closeConmodelFunc{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}


@end
