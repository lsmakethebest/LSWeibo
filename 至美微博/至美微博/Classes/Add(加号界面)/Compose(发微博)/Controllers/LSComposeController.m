


//
//  LSComposeController.m
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSComposeController.h"

@interface LSComposeController ()
@end
@implementation LSComposeController


-(void)viewDidLoad
{
    self.topTitle=@"发微博";
    [super viewDidLoad];
    self.placeholoder=@"分享新鲜事。。。";
    
}

//发送微博
-(void)send
{
    
    [self cancel];
    if (self.photosView.images.count) {
        
        //发图片
        [LSSendStatusTool sendStatusWithString:[self.textView realText] pics:self.photosView.images success:^(id responseObject) {
            [KVNProgress showSuccessWithStatus:@"发送成功"];
        } failure:^(NSError *error) {
            [KVNProgress showErrorWithStatus:@"发送失败"];
        }];
    }
    else{
        //发文字
        NSLog(@"text====%@",[self.textView realText]);
        [LSSendStatusTool sendStatusWithString: [self.textView realText] success:^(id responseObject) {
            
            [KVNProgress showSuccessWithStatus:@"发送成功"];
            
        } failure:^(NSError *error) {
            [KVNProgress showErrorWithStatus:@"发送失败"];
        }];    
    }
    
}

@end
