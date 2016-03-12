



//
//  LSEmotionPopView.m
//  至美微博
//
//  Created by song on 15/10/19.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionPopView.h"
#import "LSEmotionView.h"
@interface LSEmotionPopView ()
@property (weak, nonatomic) IBOutlet LSEmotionView *emotionView;

@end
@implementation LSEmotionPopView
+(instancetype)popView
{
    LSEmotionPopView *popView=[[[NSBundle mainBundle]loadNibNamed:@"LSEmotionPopView" owner:nil options:nil]lastObject];
    return popView;
}

- (void)drawRect:(CGRect)rect {
    UIImage *image=[UIImage imageNamed:@"emoticon_keyboard_magnifier"];
    [image drawInRect:rect];
    
}
-(void)showFromEmotionView:(LSEmotionView *)emotionView
{
    if (emotionView==nil) return;
    
//    显示表情
    self.emotionView.emotion=emotionView.emotion;
    //添加到键盘窗口
    UIWindow *window=[[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = emotionView.centerX;
    CGFloat centerY = emotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:emotionView.superview];
}
-(void)dismiss
{
    [self removeFromSuperview];
}

@end
