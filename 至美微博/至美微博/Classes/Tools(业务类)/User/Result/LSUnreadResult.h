//
//  LSUnreadResult.h
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSUnreadResult : NSObject

// {
// "all_cmt" = 0;
// "all_follower" = 3;
// "all_mention_cmt" = 0;
// "all_mention_status" = 0;
// "attention_cmt" = 0;
// "attention_follower" = 0;
// "attention_mention_cmt" = 0;
// "attention_mention_status" = 0;
// badge = 0;
// "chat_group_client" = 0;
// "chat_group_notice" = 0;
// "chat_group_pc" = 0;
// cmt = 0;
// dm = 2;
// follower = 3;
// group = 0;
// invite = 0;
// "mention_cmt" = 0;
// "mention_status" = 0;
// notice = 0;
// "page_friends_to_me" = 0;
// photo = 0;
// status = 22;
// }

 


 /**
  新微博未读数
**/
@property (nonatomic, assign) int status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 *  新私信数
 */

@property (nonatomic, assign) int dm;

/**
 *  新提及我的微博数
 */

@property (nonatomic, assign) int mention_cmt;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_status;

/**
 *  消息未读数
 */
- (int)messageCount;

/**
 *  所有未读数
 */
- (int)totalCount;

@end
