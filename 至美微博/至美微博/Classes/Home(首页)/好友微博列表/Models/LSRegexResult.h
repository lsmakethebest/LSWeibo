//
//  LSRegexResult.h
//  至美微博
//
//  Created by song on 15/10/25.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSRegexResult : NSObject
//匹配到的字符串
@property (nonatomic, copy) NSString *string;
//匹配到的范围
@property(nonatomic,assign) NSRange range;
//是否是表情
@property(nonatomic,assign,getter=isEmotion) BOOL emotion;

@end
