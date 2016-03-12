//
//  LSBaseSendViewController.h
//  至美微博
//
//  Created by song on 15/10/29.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSEmotionTextView.h"
#import "LSSendStatusTool.h"
#import "KVNProgress.h"
#import "LSComposeToolBar.h"
#import "LSComposePhotosView.h"
#import "LSEmotionToolBar.h"
#import "LSEmotionKeyboard.h"
#import "LSEmotion.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
#import "NSString+Emoji.h"
#import "LSEmotionTextView.h"
@interface LSBaseSendViewController : UIViewController<UITextViewDelegate,LSComposeToolBarDelegaete,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, copy) NSString *placeholoder;
@property (nonatomic, weak) LSComposePhotosView *photosView;
@property (nonatomic, weak) LSEmotionTextView *textView;
@property (nonatomic, copy) NSString *topTitle;
//取消
-(void)cancel;
-(void)send;
-(void)textViewDidChange:(UITextView *)textView;
@end
