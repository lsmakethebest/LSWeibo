//
//  LSRepostStatusTool.h
//  至美微博
//
//  Created by song on 15/10/29.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRepostStatusTool : NSObject
+(void)repostStatusWithStatusId:(NSString *)statusId text:(NSString *)text success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
