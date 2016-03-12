//
//  LSSendStatusTool.h
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSendStatusTool : NSObject
+(void)sendStatusWithString:(NSString *)text pics:(NSArray*)pics success:(void (^)(id responseObject)) success failure:(void (^)(NSError *error)) failure;
+(void)sendStatusWithString:(NSString *)text success:(void (^)(id responseObject)) success failure:(void (^)(NSError *error)) failure;
@end
