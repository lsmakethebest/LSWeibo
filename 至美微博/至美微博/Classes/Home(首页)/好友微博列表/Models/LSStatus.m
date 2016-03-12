






//
//  LSStatus.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSStatus.h"
#import "LSUser.h"
#import "LSPhoto.h"
#import "NSDate+MJ.h"
#import "RegexKitLite.h"
#import "LSRegexResult.h"
#import "LSTextAttachment.h"
#import "LSEmotionTool.h"
@implementation LSStatus
+(NSDictionary*)objectClassInArray
{
    return @{@"pic_urls":[LSPhoto class]};
}
//-(NSString *)created_at
//{
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    formatter.dateFormat=@"EEE MMM d HH:mm:ss Z yyyy";
//    [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US" ] ];
//    NSDate *  created_at=[formatter dateFromString:_created_at];
//
//    //是今年
//    if ([created_at isThisYear]) {
//        //是今天
//        if ([created_at isToday]) {
//
//            NSDateComponents *date=[created_at deltaWithNow];
//            if (date.hour>=1) {
//                 return [NSString stringWithFormat:@"%ld小时前",(long)date.hour];
//            }
//            else if(date.minute>1){
//                return [NSString stringWithFormat:@"%ld分钟前",(long)date.minute];
//            }
//            else{
//                return @"刚刚";
//            }
//
//        }
//        //是昨天
//        else if ([created_at isYesterday]){
//
//        formatter.dateFormat=@"昨天 HH:mm";
//            return [formatter stringFromDate:created_at];
//        }
//        else {
//            formatter.dateFormat=@"MM-dd HH:mm";
//            return [formatter stringFromDate:created_at];
//        }
//    }
//    //不是今年
//    else
//    {
//        formatter.dateFormat=@"yyyy-MM-dd HH:mm";
//         return [formatter stringFromDate:created_at];
//    }
//    return _created_at;
//}
-(void)setSource:(NSString *)source
{
    NSRange range=[source rangeOfString:@">"];
    source=[source substringFromIndex:range.location+range.length];
    range=[source rangeOfString:@"<"];
    source=[source substringToIndex:range.location];
    _source=[NSString stringWithFormat:@"来自%@",source];
}
- (void)setRetweeted_status:(LSStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    self.retweet=NO;
    _retweeted_status.retweet=YES;
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
    
}
-(void)setText:(NSString *)text
{
    _text=[text copy];
    [self  createAttributedString];
    
}
-(void)setRetweet:(BOOL)retweet
{
    _retweet=retweet;
    [self createAttributedString];
}
-(void)setUser:(LSUser *)user
{
    _user=user;
    [self  createAttributedString];
    
}
-(void)createAttributedString
{
    if (self.user==nil||self.text==nil) return;
    NSString *totalText;
    if (self.isRetweet) {
        
        totalText=[NSString stringWithFormat:@"@%@:%@",self.user.name,self.text];
    }else {
        totalText=[NSString stringWithFormat:@"%@",self.text];
    }
    NSAttributedString *attributedString=[self attributedStringWithText:totalText];
//    NSLog(@"attributedString====%@",attributedString.string);
    self.attributedText=attributedString;
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
