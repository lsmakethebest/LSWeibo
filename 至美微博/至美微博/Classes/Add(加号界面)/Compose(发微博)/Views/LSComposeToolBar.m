



//
//  LSComposeToolBar.m
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSComposeToolBar.h"

@implementation LSComposeToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupAllChildView];
    }
    return self;
}
-(void)setupAllChildView
{
    [self addButtonWithIcon:@"compose_toolbar_picture" hlightIcon:@"compose_toolbar_picture_highlighted" tag:LSComposeButtonTypePic];
    [self addButtonWithIcon:@"compose_trendbutton_background" hlightIcon:@"compose_trendbutton_background_highlighted" tag:LSComposeButtonTypeTrend ];
    [self addButtonWithIcon:@"compose_mentionbutton_background" hlightIcon:@"compose_mentionbutton_background_highlighted" tag:LSComposeButtonTypeMention];
    [self addButtonWithIcon:@"compose_emoticonbutton_background" hlightIcon:@"compose_emoticonbutton_background_highlighted" tag:LSComposeButtonTypeEmotion];
    [self addButtonWithIcon:@"message_add_background" hlightIcon:@"message_add_background_highlighted" tag:LSComposeButtonTypeAdd];
    
}
-(void)addButtonWithIcon:(NSString*)icon hlightIcon:(NSString*)hlightIcon tag:(LSComposeButtonType)tag
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hlightIcon] forState:UIControlStateHighlighted];
    btn.tag=tag;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)layoutSubviews
{
    int count=self.subviews.count;
    CGFloat w=self.width/count;
    for (int i=0; i<count; i++) {
        UIButton *btn=self.subviews[i];
        btn.x=i*w;
        btn.y=0;
        btn.height=self.height;
        btn.width=w;
    }
}
-(void)click:(UIButton*)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:tag:)]) {
        [self.delegate composeToolBar:self tag:btn.tag];
    }
}
-(void)setShowEmotionButton:(BOOL)showEmotionButton
{
    _showEmotionButton=showEmotionButton;
    UIButton *btn=(UIButton *)[self viewWithTag:LSComposeButtonTypeEmotion];
    if (showEmotionButton) {
        [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
    
    
    }
}
@end
