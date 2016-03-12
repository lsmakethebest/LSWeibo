




//
//  LSSendStatusTool.m
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSendStatusTool.h"
#import "LSHttpTool.h"
#import "LSSendParam.h"
#import "MJExtension.h"
#import "AFNetworking.h"
@implementation LSSendStatusTool
//发送文字图片微博
+(void)sendStatusWithString:(NSString *)text pics:(NSArray *)pics success:(void (^)(id))success failure:(void (^)(NSError *))failure
{

    LSSendParam *param=[LSSendParam param];
    param.status=text;
    [[AFHTTPRequestOperationManager manager] POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image=[pics firstObject];
        NSData *data=UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpeg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}
//发送文字微博
+(void)sendStatusWithString:(NSString *)text success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    LSSendParam *param=[LSSendParam param];
    param.status=text;
    [LSHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
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
