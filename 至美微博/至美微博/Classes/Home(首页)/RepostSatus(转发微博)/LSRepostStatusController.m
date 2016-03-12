




//
//  LSRepostStatusController.m
//  至美微博
//
//  Created by song on 15/10/29.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSRepostStatusController.h"
#import "LSRepostStatusTool.h"
@interface LSRepostStatusController ()

@end

@implementation LSRepostStatusController

- (void)viewDidLoad {
    self.topTitle=@"转发微博";
    [super viewDidLoad];
    self.placeholoder=@"转发同时说上发表你的看法。。。";
    if (self.defaultText) {
        
        self.textView.text=self.defaultText;
        self.textView.selectedRange=NSMakeRange(0, 0);
        [self.textView textChange];
        [self textViewDidChange:self.textView];
    }
    
    
    
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
        [LSRepostStatusTool repostStatusWithStatusId:self.statusId text:[self.textView realText] success:^(id responseObject) {
            [KVNProgress showSuccessWithStatus:@"转发成功"];
        } failure:^(NSError *error) {
            [KVNProgress showErrorWithStatus:@"转发失败"];
            NSLog(@"%@",error.localizedDescription);
            
        }];
        
    }
}
@end
