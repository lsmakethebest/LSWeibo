//
//  LSEmotionTool.h
//  至美微博
//
//  Created by song on 15/10/20.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSEmotion;
@interface LSEmotionTool : NSObject
+(NSArray *)emojiEmotions;
+(NSArray *)defaultEmotions;
+(NSArray *)lxhEmotions;
+(NSArray*)recentEmotions;
+(void)addRecentEmotion:(LSEmotion*)emotion;
//根据描述找到对应的表情
+(LSEmotion*)emotionWithText:(NSString*)text;
@end
