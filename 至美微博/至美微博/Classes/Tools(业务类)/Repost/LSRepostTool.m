



//
//  LSRepostTool.m
//  至美微博
//
//  Created by song on 15/10/14.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSRepostTool.h"
#import "LSCommentParam.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
#import "LSHttpTool.h"
#import "MJExtension.h"
@implementation LSRepostTool
+(void)loadNewRepostWithId:(NSString *)idstr sinceId:(NSString*)sinceId success:(void (^)(LSRepostResult *result))success failure:(void (^)(NSError *error))failure
{
    
    LSCommentParam *param=  [[LSCommentParam alloc]init];
    param.access_token=[LSAccountTool currentAccount].access_token;
    param.id=idstr;
    if (sinceId) {
        param.since_id=sinceId;
    }
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[@"access_token"]=[LSAccountTool currentAccount].access_token;
    dic[@"id"]=idstr;
    //    dic[@"since_id"]=@1000;
    
    //https://api.weibo.com/2/comments/show.json
    //https://api.weibo.com/2/statuses/repost_timeline.json
    
    [LSHttpTool GET:@"https://api.weibo.com/2/statuses/repost_timeline.json" parameters:dic success:^(id responseObject) {
        if (success) {
            
            LSRepostResult *result=[LSRepostResult objectWithKeyValues:responseObject];
//            LSCommentResult *result=[LSCommentResult objectWithKeyValues:responseObject];
            NSDictionary *dic=responseObject;
            [dic writeToFile:@"/Users/song/Desktop/comment.plist" atomically:YES];
            NSLog(@"%@",responseObject);
//            for (LSComment *comment in result.comments ) {
//                NSLog(@"comment==%@",comment);
//            }
            
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
@end
