//
//  feedController.h
//  ServiceConnectionApp
//
//  Created by lee on 2017/7/18.
//  Copyright © 2017年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceConnectionPublic.h"

@protocol feeddeletegate <NSObject>

@optional
-(void)sendfeedfunc:(NSString *)bz_txt;

@end


@interface feedController : UIViewController<UITextViewDelegate>{

    UITextView *feedTextFile;
    UILabel *palaceLabel;


}
@property(nonatomic,strong)id<feeddeletegate> delegate;

@end
