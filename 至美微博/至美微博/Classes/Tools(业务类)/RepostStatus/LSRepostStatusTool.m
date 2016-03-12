



//
//  LSRepostStatusTool.m
//  至美微博
//
//  Created by song on 15/10/29.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSRepostStatusTool.h"
#import "LSRepostStatusParam.h"
#import "LSHttpTool.h"
#import "MJExtension.h"
@implementation LSRepostStatusTool
//发表评论(文字)
+(void)repostStatusWithStatusId:(NSString *)statusId text:(NSString *)text success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    LSRepostStatusParam *param=[LSRepostStatusParam param];
    param.status=text;
    param.id=statusId;
    [LSHttpTool POST:@"https://api.weibo.com/2/statuses/repost.json" parameters:param.keyValues success:^(id responseObject) {
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
