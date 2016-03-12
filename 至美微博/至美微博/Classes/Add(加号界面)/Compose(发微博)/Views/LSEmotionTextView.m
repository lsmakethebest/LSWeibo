//
//  LSEmotionTextView.m
//  至美微博
//
//  Created by song on 15/10/23.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionTextView.h"
#import "NSString+Emoji.h"
#import "LSEmotion.h"
#import "LSTextAttachment.h"

@implementation LSEmotionTextView

-(void)addEmotion:(LSEmotion *)emotion
{
    NSInteger index=self.selectedRange.location;
    if (emotion.code) {
        NSString *str= [NSString emojiWithStringCode:emotion.code];
        [self insertText:str];
    }else{
        NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc ]initWithAttributedString:self.attributedText];
        LSTextAttachment *ata=[[LSTextAttachment alloc]init];
        ata.emotion=emotion;
        ata.bounds=CGRectMake(0, -4, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *att=[NSAttributedString attributedStringWithAttachment:ata];
        
        [attributedString insertAttributedString:att atIndex:index];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedString.length)];
        self.attributedText=attributedString;
        self.selectedRange=NSMakeRange(index+1, 0);
    }
    
}
-(NSString *)realText
{
    NSMutableString *str=[NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        LSTextAttachment *ata=attrs[@"NSAttachment"];
        if (ata) {
            [str appendString:ata.emotion.chs];
        }else {
            NSString *name=[self.attributedText attributedSubstringFromRange:range].string;
            [str appendString:name];
        }
    }];
    return str;
}
@end
