//
//  LSEmotionToolBar.m
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionToolBar.h"


#define LSEmotionButtonMaxCount 4


@interface LSEmotionToolBar ()
@property (nonatomic, weak) UIButton *selectedButton;
@end
@implementation LSEmotionToolBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self addButtonWithName:@"最近" tag:LSEmotionToolBarButtonTypeRecent];
        [self addButtonWithName:@"默认" tag:LSEmotionToolBarButtonTypeDefault];
        [self addButtonWithName:@"Emoji" tag:LSEmotionToolBarButtonTypeEmoji];
        [self addButtonWithName:@"浪小花" tag:LSEmotionToolBarButtonTypeLxh];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedEmotion) name:LSEmotionSelectedEmotionNotification object:nil];
        
    }
    return self;
}

-(void)addButtonWithName:(NSString*)name tag:(LSEmotionToolBarButtonType)type
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    文字
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    btn.tag=type;
    
    [self addSubview:btn];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    int count=self.subviews.count;
    if (count==1) {
        
        
        
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    }else if(count==LSEmotionButtonMaxCount){
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }else{
        
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithStretchableName:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    
    
}
//点击事件

-(void)click:(UIButton*)sender
{
    
    self.selectedButton.selected=NO;
    sender.selected=YES;
    self.selectedButton=sender;
    if ([self.delegate respondsToSelector:@selector(emotionToolBar:buttonType:)]) {
        [self.delegate emotionToolBar:self buttonType:sender.tag];
    }
}
-(void)setDelegate:(id<LSEmotionToolBarDelegate>)delegate
{
    _delegate=delegate;
    UIButton *btn= (UIButton*)[self viewWithTag:LSEmotionToolBarButtonTypeRecent];
    [self click:btn];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w=self.width/LSEmotionButtonMaxCount;
    CGFloat h=self.height;
    for (int i=0; i<self.subviews.count; i++) {
        UIButton *btn=self.subviews[i];
        btn.width=w;
        btn.height=h;
        btn.x=i*w;
    }
}

-(void)selectedEmotion
{
    if (self.selectedButton.tag==LSEmotionToolBarButtonTypeRecent) {
        [self.delegate emotionToolBar:self buttonType:self.selectedButton.tag];
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
