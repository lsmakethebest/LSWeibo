



//
//  LSSendCommentViewController.m
//  至美微博
//
//  Created by song on 15/10/29.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSendCommentViewController.h"
#import "LSSendCommentTool.h"

@interface LSSendCommentViewController ()

@end

@implementation LSSendCommentViewController

- (void)viewDidLoad {
    self.topTitle=@"发评论";
    [super viewDidLoad];
    
    self.placeholoder=@"发表你的评论。。。";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)send
{
    [self cancel];
    if (self.photosView.images.count) {
        
        
        
    }
    else{
        //发文字
        [LSSendCommentTool sendCommentWithStatusId:self.statusId text:[self.textView realText] success:^(id responseObject) {
            
            [KVNProgress showSuccessWithStatus:@"评论成功"];
        } failure:^(NSError *error) {
            [KVNProgress showErrorWithStatus:@"评论失败"];
            NSLog(@"%@",error.localizedDescription);
        }];
        
        
    }
    
    
    
}

@end
