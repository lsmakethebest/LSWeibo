//
//  LSUserTool.h
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSUser.h"
@class LSUnreadResult,LSLikeListResult;
@interface LSUserTool : NSObject
//获取用户信息
+(void)userInfoWithAccessToken:(NSString*)token success:(void (^)(LSUser *))success failure:(void (^)(NSError *))failure;
//获取未读数
+(void)getUnreadCountSuccess:(void(^)( LSUnreadResult *result))success failure:(void(^)(NSError*error))failure;
//获取关注列表
+(void)getLikeListSuccess:(void(^)(LSLikeListResult* result))success failure:(void(^)(NSError*error))failure;
//获取微博关注粉丝数量
+(void)getWioboLikeFlowerCountWith:(NSString*)uid success:(void(^)(NSDictionary* resultDict))success failure:(void(^)(NSError*error))failure;
@end
