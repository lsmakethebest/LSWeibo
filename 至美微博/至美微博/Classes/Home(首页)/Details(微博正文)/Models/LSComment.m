



//
//  LSComment.m
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSComment.h"
#import "LSEmotionTool.h"
#import "NSString+Emoji.h"
#import "LSRegexResult.h"
#import "LSTextAttachment.h"
#import "RegexKitLite.h"
@implementation LSComment
-(void)setText:(NSString *)text
{
    _text=[text copy];
self.attributedText=[self attributedStringWithText:text];
    
}
-(NSMutableAttributedString*)attributedStringWithText:(NSString*)text
{
    //匹配字符串
    NSArray *results= [self createAttributedArrayWithText:text];
    //遍历数组
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]init];
    [results enumerateObjectsUsingBlock:^(LSRegexResult * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LSEmotion *emotion=nil;
        if (obj.isEmotion) {//是表情
            emotion=[LSEmotionTool emotionWithText:obj.string];
        }
        if (emotion) {//找到对应表情
            
            LSTextAttachment *atach=[[LSTextAttachment alloc]init];
            atach.emotion=emotion;
            atach.bounds=CGRectMake(0, -3, LSTextFont.lineHeight, LSTextFont.lineHeight);
            NSAttributedString *att=[NSAttributedString attributedStringWithAttachment:atach];
            [attributedString appendAttributedString:att];
            
        }else {//没找到对应表情
            NSMutableAttributedString *subStr=[[NSMutableAttributedString alloc]initWithString:obj.string];
            //匹配#话题#
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [obj.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:LSHighTextColor range:*capturedRanges];
                [subStr addAttribute:LSHighLink value:*capturedStrings range:*capturedRanges];
            }];
            //匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [obj.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:LSHighTextColor range:*capturedRanges];
                [subStr addAttribute:LSHighLink value:*capturedStrings range:*capturedRanges];
            }];
            //匹配@
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+";
            [obj.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [subStr addAttribute:NSForegroundColorAttributeName value:LSHighTextColor range:*capturedRanges];
                [subStr addAttribute:LSHighLink value:*capturedStrings range:*capturedRanges];
            }];
            [attributedString  appendAttributedString:subStr];
        }
        
    }];
    //设置字体
    [attributedString addAttribute:NSFontAttributeName value:LSTextFont range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}
-(NSArray*)createAttributedArrayWithText:(NSString *)text
{
    NSMutableArray *results=[NSMutableArray array];
    NSString *regex=@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    //匹配表情
    [text enumerateStringsMatchedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        LSRegexResult *regexResult=[[LSRegexResult alloc]init];
        regexResult.string=*capturedStrings;
        //        NSLog(@"string======%@",*capturedStrings);
        regexResult.range=*capturedRanges;
        regexResult.emotion=YES;
        [results addObject:regexResult];
    }];
    //匹配非表情
    [text enumerateStringsSeparatedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        LSRegexResult *regexResult=[[LSRegexResult alloc]init];
        regexResult.string=*capturedStrings;
        regexResult.range=*capturedRanges;
        regexResult.emotion=NO;
        [results addObject:regexResult];
    }];
    //对数组进行排序
    [results sortUsingComparator:^NSComparisonResult(LSRegexResult * obj1, LSRegexResult* obj2) {
        int loc1=obj1.range.location;
        int loc2=obj2.range.location;
        return  [ @(loc1) compare:@(loc2)];
    }];
    return results;
}

@end
