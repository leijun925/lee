//
//  photoController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/7/20.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<AVFoundation/AVCaptureDevice.h>
#import<AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "ServiceConnectionPublic.h"
#import "scrollerPhotoController.h"

@protocol photosaveimageDelegate <NSObject>

@optional

-(void)saveimageArray:(NSArray *)array;


@end


@interface photoController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{


    

}

@property (nonatomic,strong)NSMutableArray *selectImageArray;
@property (nonatomic,strong)UICollectionView *CollectionView;
@property (nonatomic,strong)id<photosaveimageDelegate>  delegate;
@property (nonatomic,strong)UILongPressGestureRecognizer *longPress;

@end
