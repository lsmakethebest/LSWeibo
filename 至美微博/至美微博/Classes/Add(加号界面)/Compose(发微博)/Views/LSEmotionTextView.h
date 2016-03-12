//
//  LSEmotionTextView.h
//  至美微博
//
//  Created by song on 15/10/23.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSTextView.h"
@class LSEmotion;
@interface LSEmotionTextView : LSTextView
//添加表情
-(void)addEmotion:(LSEmotion*)emotion;
//真实文本
-(NSString*)realText;
@end
