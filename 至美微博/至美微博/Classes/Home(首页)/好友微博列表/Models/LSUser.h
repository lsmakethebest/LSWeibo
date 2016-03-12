//
//  LSUser.h
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUser : NSObject
/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;
/**
 * 简介
 */
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *myDdescription;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
