

//
//  LSSectionView.m
//  至美微博
//
//  Created by song on 15/10/13.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSectionView.h"
#import "LSStatus.h"
#define LSSectionTextWidth 30
@interface LSSectionView ()

//转发按钮
@property (nonatomic, weak) UIButton *repost;
//评论按钮
@property (nonatomic, weak) UIButton *comment;
//赞按钮
@property (nonatomic, weak) UIButton *unlike;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) UIView *line;

@end
@implementation LSSectionView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        [self setImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.userInteractionEnabled=YES;
        [self setupAllView];
    }
    return self;
}
-(void)setupAllView
{
    self.repost=[self setupBtn];
    self.repost.tag=LSButttonTypeRepost;
    self.comment=[self setupBtn];
    self.comment.tag=LSButttonTypeComment;
    self.unlike=[self setupBtn];
    self.unlike.tag=LSButttonTypeUnlike;
    UIView *line=[[UIView alloc]init];
    line.height=2;
    line.backgroundColor=[UIColor orangeColor];
    line.width=100;
    [self addSubview:line];
    self.line=line;
    
}
-(UIButton*)setupBtn
{
    UIButton *btn=[[UIButton alloc]init];
//    btn.backgroundColor=LSRandomColor;
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(sectionViewClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:btn];
    return btn;
    
}
-(void)sectionViewClick:(UIButton*)btn
{
    self.selectdButtonType=btn.tag;
    self.selectedBtn.selected=NO;
    btn.selected=YES;
    self.selectedBtn=btn;
    self.line.x=btn.x;
    self.line.y=self.height-2;
    self.line.width=btn.width;
    if ([self.delegate respondsToSelector:@selector(sectionView:buttonType:)]) {
        [self.delegate sectionView:self buttonType:btn.tag];
    }
}
-(void)setStatus:(LSStatus *)status
{
    //转发按钮
    NSString *repostStr=[self stringWithName:@"转发" number:status.reposts_count];
    CGSize repostSize=[repostStr sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, self.height) font:[UIFont systemFontOfSize:12]];
    self.repost.x=LSCellMargin;
    self.repost.width=repostSize.width;
    self.repost.height=self.height;
    [self.repost setTitle:repostStr forState:UIControlStateNormal];
    [self.repost setTitle:repostStr forState:UIControlStateSelected];
    
    
    //评论按钮
    NSString *commentStr=[self stringWithName:@"评论" number:status.comments_count];
    CGSize commentSize=[commentStr sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, self.height) font:[UIFont systemFontOfSize:12]];
    self.comment.x=CGRectGetMaxX(self.repost.frame)+ LSCellMargin;
    self.comment.width=commentSize.width;
    self.comment.height=self.height;
    [self.comment setTitle:commentStr forState:UIControlStateNormal];
    [self.comment setTitle:commentStr forState:UIControlStateSelected];
    
    //赞按钮
    NSString *unlikeStr=[self stringWithName:@"赞" number:status.attitudes_count];
    CGSize unlikeSize=[unlikeStr sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, self.height) font:[UIFont systemFontOfSize:12]];
    self.unlike.width=unlikeSize.width;
    self.unlike.x=LSScreenWidth-LSCellMargin-self.unlike.width;
    self.unlike.height=self.height;
    [self.unlike setTitle:unlikeStr forState:UIControlStateNormal];
    [self.unlike setTitle:unlikeStr forState:UIControlStateSelected];

    
}
-(NSString*)stringWithName:(NSString*)name number:(int)count
{
    NSString *title=nil;
    if (count>10000) {
        title =[NSString stringWithFormat:@"%.1fW",count/10000.0];
        title=[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        title=[NSString stringWithFormat:@"%@ %@",name,title];
    }else{
     title=[NSString stringWithFormat:@"%@ %d",name,count];
    }
    return title;
}
-(void)setDelegate:(id<LSSectionViewDelegate>)delegate
{
    _delegate=delegate;
    [self sectionViewClick:self.comment];
}
@end
