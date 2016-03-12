
//
//  LSEmotionGridView.m
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionGridView.h"
#import "LSEmotionView.h"
#import "LSEmotionPopView.h"
#import "LSEmotionTool.h"
@interface LSEmotionGridView ()

@property (nonatomic, weak) UIButton *deletedButton;
@property (nonatomic, strong) NSMutableArray *emotionViews;
@property (nonatomic, strong) LSEmotionPopView *popView;
@end

@implementation LSEmotionGridView

-(LSEmotionPopView *)popView
{
    
    if (_popView==nil) {
        _popView=[LSEmotionPopView popView];
    }
    return _popView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UIButton *deletedButton=[[UIButton alloc]init];
        [deletedButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deletedButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [self addSubview:deletedButton];
        self.deletedButton=deletedButton;
        [deletedButton addTarget:self action:@selector(deletedButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]init];
        [longPress addTarget: self action:@selector(longPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}
-(NSMutableArray *)emotionViews
{
    if (_emotionViews==nil) {
        _emotionViews=[NSMutableArray array];
    }
    return _emotionViews;
}
-(void)setEmotions:(NSArray *)emotions
{
    _emotions=emotions;
    
    int count=(int)emotions.count;
    int currentCount=(int)self.emotionViews.count;
    
    for (int i=0; i<count; i++) {
        LSEmotionView *emotionView=nil;
        if (i>=currentCount) {
            
            emotionView=[[LSEmotionView alloc]init];
            
            
            [emotionView addTarget:self action:@selector(emotionViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.emotionViews addObject:emotionView];
            [self addSubview:emotionView];
        }else{
            emotionView=self.emotionViews[i];
        }
        emotionView.emotion=emotions[i];
        emotionView.hidden=NO;
    }
    for (int i=count; i<self.emotionViews.count; i++) {
        LSEmotionView *emotionView= self.emotionViews[i];
        emotionView.hidden=YES;
    }
    
}

//emotionView点击事件
-(void)emotionViewClick:(LSEmotionView*)emotionView
{
    [self.popView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.popView dismiss];
        //        发送通知
        [self sendEmotion:emotionView.emotion];
    });
}



-(void)longPress:(UILongPressGestureRecognizer*)recognizer
{
    LSEmotionView *emotionView=[self selectedEmotionView:[recognizer locationInView:recognizer.view]];
    if (recognizer.state==UIGestureRecognizerStateEnded) {
        [self.popView dismiss];
        [self sendEmotion:emotionView.emotion];
    }else{
        
        [self.popView showFromEmotionView:emotionView];
    }
}
//长按式检测出在哪个表情范围
-(LSEmotionView*)selectedEmotionView:(CGPoint)point
{
    __block LSEmotionView *emotionView=nil;
    [self.emotionViews enumerateObjectsUsingBlock:^(LSEmotionView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            emotionView=obj;
            *stop=YES;
        }
    }];
    return emotionView;
}

//发送选中表情通知
-(void)sendEmotion:(LSEmotion*)emotion
{
    if (emotion==nil) return;
    [LSEmotionTool addRecentEmotion:emotion];
    [[NSNotificationCenter defaultCenter] postNotificationName:LSEmotionSelectedEmotionNotification object:nil userInfo:@{LSSelectedEmotion:emotion}];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //    设置每一个小表情的frame
    CGFloat leftMargin=15;
    CGFloat topMargin=15;
    CGFloat width=(self.width-2*leftMargin)/LSEmotionPerColMaxCount;
    CGFloat height=(self.height-2*topMargin)/LSEmotionPerRolMaxCount;
    for (int i=0; i<self.emotionViews.count; i++) {
        LSEmotionView *emotionView=self.emotionViews[i];
        emotionView.width=width;
        emotionView.height=height;
        emotionView.x=leftMargin+i%LSEmotionPerColMaxCount*width;
        emotionView.y=topMargin+i/LSEmotionPerColMaxCount*height;
        
    }
    //    设置删除按钮的frame
    self.deletedButton.height=height;
    self.deletedButton.width=width;
    self.deletedButton.x=self.width-leftMargin-self.deletedButton.width;
    self.deletedButton.y=self.height-topMargin-self.deletedButton.height;
    
}
//删除按钮点击事件
-(void)deletedButtonClick
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:LSEmotionDeletedEmotionNotification object:nil userInfo:nil];
    
}

@end
