//
//  LSAccount.h
//  至美微博
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAccount : NSObject<NSCoding>
/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *   过期时间 = 当前保存时间+有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_url;
/**
 *  是否是当前用户
 */
@property(nonatomic,assign,getter= isCurrentAccount) BOOL currentAccount;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
