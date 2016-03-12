//
//  LSBaseParam.h
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSBaseParam : NSObject
/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
+(instancetype)param;
@end
