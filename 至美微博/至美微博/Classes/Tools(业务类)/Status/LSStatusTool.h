//
//  LSStatusTool.h
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSStatus.h"
@interface LSStatusTool : NSObject
+(void)loadNewStatusWithSinceId:(NSString *)sinceId  maxId:(NSString*)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure;

@end
