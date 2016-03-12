


//
//  LSToolBar.m
//  至美微博
//
//  Created by song on 15/10/10.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSToolBar.h"
#import "LSStatusFrame.h"



@interface LSToolBar ()

@property (nonatomic, weak) UIButton *retweet;
@property (nonatomic, weak) UIButton *comment;
@property (nonatomic, weak) UIButton *unlike;

@property (nonatomic, strong) NSMutableArray *lines;
@end
@implementation LSToolBar

-(NSMutableArray *)lines
{
    if (_lines==nil) {
        _lines=[NSMutableArray array];
        
    }
    return _lines;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.userInteractionEnabled=YES;
        self.image=[UIImage imageWithStretchableName:@"timeline_card_bottom_background"] ;
        [self setHighlightedImage:[UIImage imageWithStretchableName:@"timeline_card_bottom_background_highlighted"]];
//        self.backgroundColor=LSRandomColor;
        [self setupAllChildView];
    }
    return self;
}
-(void)setupAllChildView
{
    self.retweet=[self setTitle:@"转发" imageName:@"timeline_icon_retweet"];
    self.comment=[self setTitle:@"评论" imageName:@"timeline_icon_comment"];
    self.unlike=[self setTitle:@"赞" imageName:@"timeline_icon_unlike"];
    UIImageView *line1=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    line1.highlightedImage=[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"];
    [self.comment addSubview:line1];
    [self.lines addObject:line1];
    
    UIImageView *line2=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        line2.highlightedImage=[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"];
    [self.unlike addSubview:line2];
    [self.lines addObject:line2];
    
}
-(void)setStatusFrame:(LSStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    self.frame=_statusFrame.toolBarFrame;
    [self setNumber:@"转发" btn:self.retweet count:_statusFrame.status.reposts_count];
    [self setNumber:@"评论" btn:self.comment count:_statusFrame.status.comments_count];
    [self setNumber:@"赞" btn:self.unlike count:_statusFrame.status.attitudes_count];
    
    
}
-(void)setNumber:(NSString *)name btn:(UIButton *)btn count:(int)count
{
    //设置数据
    NSString *title;
    if (count>10000) {
        title =[NSString stringWithFormat:@"%.1fW",count/10000.0];
        title=[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    else if(count==0){
        title=name;
    }
    else {
        title=[NSString stringWithFormat:@"%d",count];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
-(UIButton *)setTitle:(NSString *)title imageName:(NSString *)name
{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.tag=self.subviews.count;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.width==0||self.height==0) {
        self.hidden=YES;
        return;
    }
    self.hidden=NO;
    CGFloat btnW=LSScreenWidth/3;
    
    self.retweet.frame=CGRectMake(0, 0, btnW, self.height);
    self.comment.frame=CGRectMake(btnW, 0, btnW, self.height);
    self.unlike.frame=CGRectMake(2*btnW, 0, btnW, self.height);

    for (UIImageView *imageView in self.lines) {
        imageView.frame=CGRectMake(0, (self.height- imageView.image.size.height)/2, 1,imageView.size.height );
    }
    
}
//按钮点击事件
-(void)buttonClick:(UIButton*)btn
{
    if ([self.delegate respondsToSelector:@selector(toolBar:buttonType:)]) {
        [self.delegate toolBar:self buttonType:btn.tag];
    }
}
@end
