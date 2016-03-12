

//
//  LSEmotionView.m
//  至美微博
//
//  Created by song on 15/10/19.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionView.h"
#import "LSEmotion.h"
#import "NSString+Emoji.h"
@implementation LSEmotionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
//        self.backgroundColor=LSRandomColor;
        self.titleLabel.font=[UIFont systemFontOfSize:32];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super  initWithCoder:aDecoder]) {
//        self.backgroundColor=LSRandomColor;
        self.titleLabel.font=[UIFont systemFontOfSize:32];
        self.adjustsImageWhenHighlighted=NO;
        
    }
    return self;
}
-(void)setEmotion:(LSEmotion *)emotion
{
    _emotion=emotion;
    if (emotion.code) {
        
        [UIView setAnimationsEnabled:NO];
        [self setTitle:[NSString emojiWithStringCode:emotion.code]forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        [UIView setAnimationsEnabled:YES];
        
    }else {
          [UIView setAnimationsEnabled:NO];
        [self setTitle:nil forState:UIControlStateNormal];
       [self setImage:[UIImage imageWithOriginalName:emotion.png] forState:UIControlStateNormal];
         [UIView setAnimationsEnabled:YES];
    }
}

@end
