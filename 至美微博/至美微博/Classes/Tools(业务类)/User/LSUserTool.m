

//
//  LSUserTool.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSUserTool.h"
#import "LSHttpTool.h"
#import "LSUserParam.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
#import "MJExtension.h"
#import "LSUnreadResult.h"
#import "LSLikeListResult.h"
@implementation LSUserTool
+(void)userInfoWithAccessToken:(NSString*)token success:(void (^)(LSUser *))success failure:(void (^)(NSError *))failure
{
    
    LSUserParam *param=[LSUserParam param];
    param.access_token=token;
    param.uid=[LSAccountTool currentAccount].uid;
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"access_token"]=[LSAccountTool currentAccount].access_token;
    params[@"uid"]=[LSAccountTool currentAccount].uid;
    [LSHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(id responseObject) {
        if (success) {
            //            NSLog(@"用户信息:%@",responseObject);
            
            LSUser *user=[LSUser objectWithKeyValues:responseObject];
            success(user);
        }
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];
}
/**
 *未读数列表
 */
//https://rm.api.weibo.com/2/remind/unread_count.json
+(void)getUnreadCountSuccess:(void(^)( LSUnreadResult *result))success failure:(void(^)(NSError*error))failure
{
    LSUserParam *param=[LSUserParam param];
    param.uid=[LSAccountTool currentAccount].uid;
    [LSHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        //        NSLog(@"responseObject=%@",responseObject);
        if (success) {
            LSUnreadResult *re=[LSUnreadResult objectWithKeyValues:responseObject];
            success(re);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


//获取关注列表信息
+(void)getLikeListSuccess:(void(^)(LSLikeListResult* result))success failure:(void(^)(NSError*error))failure
{
    
    LSUserParam *param=[LSUserParam param];
    param.uid=[LSAccountTool currentAccount].uid;
    [LSHttpTool GET:@"https://api.weibo.com/2/friendships/friends.json" parameters:param.keyValues success:^(id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if (success) {
            LSLikeListResult *re=[LSLikeListResult objectWithKeyValues:responseObject];
            success(re);
//            NSLog(@"关注列表信息:responseObject=%@",responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"%@",error.localizedDescription);
            failure(error);
        }
    }];
    
}

//获取微博关注粉丝数量
//https://api.weibo.com/2/users/counts.json
+(void)getWioboLikeFlowerCountWith:(NSString*)uid success:(void(^)(NSDictionary* resultDict))success failure:(void(^)(NSError*error))failure
{
    LSUserParam *param=[LSUserParam param];
    param.uids=[LSAccountTool currentAccount].uid;
    NSLog(@"%@",param.keyValues);
    [LSHttpTool GET:@"https://api.weibo.com/2/users/counts.json" parameters:param.keyValues success:^(id responseObject) {
        //        NSLog(@"%@",responseObject);
        NSArray *arr=responseObject;
        NSDictionary *dict=[arr firstObject];
        if (success) {
            NSLog(@"%@",dict);
            success(dict);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
@end
