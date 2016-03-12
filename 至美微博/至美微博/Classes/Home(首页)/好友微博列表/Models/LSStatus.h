//
//  LSStatus.h
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@class LSUser,LSPhoto;
@interface LSStatus : NSObject<MJKeyValue>
/**
 *  转发微博
 */
@property (nonatomic, strong) LSStatus *retweeted_status;

/**
 *  转发微博昵称
 */
@property (nonatomic, copy) NSString *retweetName;

/**
 *  用户
 */
@property (nonatomic, strong) LSUser *user;

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSAttributedString *attributedText;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数(赞)
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  是否是原创微博
 */
@property(nonatomic,assign,getter=isRetweet) BOOL retweet;
/**
 *  是否显示在微博正文里
 */
@property(nonatomic,assign,getter=isDetail) BOOL detail;
/**
 *  配图数组(CZPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;

@end
