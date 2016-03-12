
//
//  LSTextView.m
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSTextView.h"
#import "UIView+Frame.h"
#import "LSEmotion.h"
#import "NSString+Emoji.h"
#import "RegexKitLite.h"
#import "LSTextAttachment.h"
@interface LSTextView()

@property (nonatomic, weak) UILabel * placeholderLabel ;
@end
@implementation LSTextView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UILabel *placeholderLabel=[[UILabel alloc]init];
        placeholderLabel.numberOfLines=0;
        placeholderLabel.textColor=[UIColor lightGrayColor];
        [self  addSubview:placeholderLabel];
        self.placeholderLabel=placeholderLabel;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
        self.font=[UIFont systemFontOfSize:14];
    }
    return self;
}

//监听文本变化通知
-(void)textChange
{
    self.placeholderLabel.hidden=self.attributedText.length!=0;
//    NSLog(@"note==%@",note.userInfo);
////    NSLog(@"lenght=%@",self.attributedText.string);
////
//        NSString *regex=@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
//    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]init];
////    NSLog(@"attributedString=%@",self.attributedText .string);
//[self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
//        LSTextAttachment *ata=attrs[@"NSAttachment"];
//        if (ata) {
//            NSAttributedString *att=[NSAttributedString attributedStringWithAttachment:ata];
//            [attributedString  appendAttributedString:att];
//        }else {
//            NSString *name=[self.attributedText attributedSubstringFromRange:range].string;
////            NSLog(@"name======%@",name);
//            NSAttributedString *str=[[NSAttributedString alloc]initWithString:name attributes:nil];
////            //匹配@用户
////            [name enumerateStringsMatchedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
////                
////            }];
//            [attributedString appendAttributedString:str];
//            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
//            
//        }
//    }];
//   self.attributedText=attributedString;
//
//
//    
//    
//    
    
 
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    self.placeholderLabel.text=placeholder;
    
    [self setNeedsLayout];
    
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor=placeholderColor;
    self.placeholderLabel.textColor=placeholderColor;
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font=font;
    [self setNeedsLayout];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.placeholderLabel.x=5;
    self.placeholderLabel.y=8
    ;
    self.placeholderLabel.width=self.width-2*self.placeholderLabel.x;
    CGSize size= [self.placeholderLabel.text boundingRectWithSize:CGSizeMake(self.placeholderLabel.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.placeholderLabel.font} context:nil].size;
    self.placeholderLabel.height=size.height;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textChange];
}
@end
