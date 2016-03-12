//
//  LSCommentTool.h
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSCommentResult.h"
@interface LSCommentTool : NSObject
+(void)loadNewCommentWithId:(NSString*)idstr sinceId:(NSString*)sinceId success:(void (^)(LSCommentResult *result))success failure:(void (^)(NSError *error))failure;
+(void)loadMoreCommentWithId:(NSString*)idstr maxId:(NSString*)maxId success:(void (^)(LSCommentResult *result))success failure:(void (^)(NSError *error))failure;
@end
