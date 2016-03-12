//
//  LSRepostTool.h
//  至美微博
//
//  Created by song on 15/10/14.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSRepostResult.h"
@interface LSRepostTool : NSObject
+(void)loadNewRepostWithId:(NSString *)idstr sinceId:(NSString*)sinceId success:(void (^)(LSRepostResult *result))success failure:(void (^)(NSError *error))failure;
@end
