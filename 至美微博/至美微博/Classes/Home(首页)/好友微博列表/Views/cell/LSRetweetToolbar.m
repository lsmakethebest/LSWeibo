





//
//  LSRetweetToolbar.m
//  至美微博
//
//  Created by song on 15/10/26.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSRetweetToolbar.h"
#import "LSStatusFrame.h"
@interface LSRetweetToolbar ()
@property (nonatomic, weak) UIButton *repost;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@end
@implementation LSRetweetToolbar
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
//        self.backgroundColor=[UIColor blueColor];
//        self.backgroundColor=[UIColor blueColor];

        [self setupButtons];
    }
    return self;
}
-(void)setupButtons
{
    
    self.repost=[self setTitle:@"转发" imageName:@"timeline_icon_retweet"];
    self.comment=[self setTitle:@"评论" imageName:@"timeline_icon_comment"];
    self.unlike=[self setTitle:@"赞" imageName:@"timeline_icon_unlike"];
    
}
-(UIButton *)setTitle:(NSString *)title imageName:(NSString *)name
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];

    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
//    btn.backgroundColor=[UIColor redColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.font=LSReteetToolbarFont;
    [btn setBackgroundImage:[UIImage imageWithStretchableName:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    return btn;
    
}
-(void)setStatusFrame:(LSStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    
    //设置数据
    [self setNumberWithbtn:self.repost count:statusFrame.status.retweeted_status.reposts_count];
    [self setNumberWithbtn:self.comment count:statusFrame.status.retweeted_status.comments_count];
    [self setNumberWithbtn:self.unlike count:statusFrame.status.retweeted_status.attitudes_count];
    
    //设置frame
    self.repost.frame=_statusFrame.repostFrame;
    self.comment.frame=_statusFrame.commentFrame;
    self.unlike.frame=_statusFrame.unlikeFrame;
    
}
-(void)setNumberWithbtn:(UIButton *)btn count:(int)count
{
    //设置数据
    NSString *title;
    if (count>10000) {
        title =[NSString stringWithFormat:@"%.1fW",count/10000.0];
        title=[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    else {
        title=[NSString stringWithFormat:@"%d",count];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
