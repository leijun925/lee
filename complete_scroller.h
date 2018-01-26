//
//  complete_scroller.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/11/22.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"

@interface complete_scroller : UIViewController<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,readwrite)NSInteger nums;

@end
