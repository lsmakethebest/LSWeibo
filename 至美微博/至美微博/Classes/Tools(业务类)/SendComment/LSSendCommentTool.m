

//
//  LSSendCommentTool.m
//  至美微博
//
//  Created by song on 15/10/29.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSendCommentTool.h"
#import "LSSendCommentParam.h"
#import "LSHttpTool.h"
#import "MJExtension.h"
@implementation LSSendCommentTool
//发表评论(文字)
+(void)sendCommentWithStatusId:(NSString *)statusId text:(NSString *)text success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    LSSendCommentParam *param=[LSSendCommentParam param];
    param.comment=text;
    param.id=statusId;
    [LSHttpTool POST:@"https://api.weibo.com/2/comments/create.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
