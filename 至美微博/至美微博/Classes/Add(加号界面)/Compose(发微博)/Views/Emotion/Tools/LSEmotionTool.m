






//
//  LSEmotionTool.m
//  至美微博
//
//  Created by song on 15/10/20.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionTool.h"
#import "LSEmotion.h"
#import "MJExtension.h"

#define LSRecentEmotionPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"recentEmotion.data"]
static NSArray *_defaultEmotions;
static NSArray *_emojiEmotions;
static NSArray *_lxhEmotions;
static NSMutableArray *_recentEmotions;
@implementation LSEmotionTool

+(NSArray *)emojiEmotions
{
    if (_emojiEmotions==nil) {
        
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"emoji.plist" ofType:nil];
        NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:plist];
        _emojiEmotions=[LSEmotion objectArrayWithKeyValuesArray:dict[@"emoticons"]];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
        
    }
    return _emojiEmotions;
}
+(NSArray *)defaultEmotions
{
    if (_defaultEmotions==nil) {
        
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"default.plist" ofType:nil];
        NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:plist];
        _defaultEmotions=[LSEmotion objectArrayWithKeyValuesArray:dict[@"emoticons"]];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
        
    }
    return _defaultEmotions;
}
+(NSArray *)lxhEmotions
{
    if (_lxhEmotions==nil) {
        
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"lxh.plist" ofType:nil];
        NSDictionary *dict=[NSDictionary dictionaryWithContentsOfFile:plist];
        _lxhEmotions=[LSEmotion objectArrayWithKeyValuesArray:dict[@"emoticons"]];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
        
    }
    return _lxhEmotions;
}
+(NSArray*)recentEmotions
{
    if (_recentEmotions==nil) {
        _recentEmotions=[NSKeyedUnarchiver unarchiveObjectWithFile:LSRecentEmotionPath];
        if (_recentEmotions==nil) {
            _recentEmotions=[NSMutableArray array];
        }
    }
    return _recentEmotions;
}
+(void)addRecentEmotion:(LSEmotion*)emotion
{
    [self recentEmotions];
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:LSRecentEmotionPath];
}
+(LSEmotion*)emotionWithText:(NSString*)text
{
   __block LSEmotion *foundEmotion=nil;
    
//    for (LSEmotion *emotion in [self defaultEmotions]) {
//        if ([text isEqualToString:emotion.chs]) {
//            foundEmotion=emotion;
//            break;
//        }
//    }
//    if (foundEmotion) return foundEmotion;
//    for (LSEmotion *emotion in [self lxhEmotions]) {
//        if ([text isEqualToString:emotion.chs]) {
//            foundEmotion=emotion;
//            break;
//        }
//    }
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(LSEmotion * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([text isEqualToString:obj.chs]) {
            foundEmotion=obj;
            *stop=YES;
        }
    }];
    if (foundEmotion) return foundEmotion;
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(LSEmotion * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([text isEqualToString:obj.chs]) {
            foundEmotion=obj;
            *stop=YES;
        }
    }];
    return  foundEmotion;
}
@end
