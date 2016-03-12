


//
//  LSCommentCell.m
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSCommentCell.h"
#import "LSComment.h"
#import "LSCommentFrame.h"
#import "LSUser.h"
#import "UIImageView+WebCache.h"
#import "LSStatusLabel.h"
@interface LSCommentCell ()
//头像
@property (nonatomic, weak) UIImageView *icon ;
//昵称
@property (nonatomic, weak) UILabel *name;

//时间
@property (nonatomic, weak) UILabel *time;
//评论内容
@property (nonatomic, weak) LSStatusLabel *text;
//线
@property (nonatomic, weak) UIView *line;
@end
@implementation LSCommentCell
+(instancetype)commentCellWithTableView:(UITableView *)tableView
{
    static NSString *commetnCell=@"commetnCell";
    LSCommentCell *cell=[tableView dequeueReusableCellWithIdentifier:commetnCell];
    if (cell==nil) {
        cell=[[LSCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commetnCell];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupAllChildView];
        
    }
    return self;
}
-(void)setupAllChildView
{
    
    UIImageView *icon=[[UIImageView alloc]init];
    [self.contentView addSubview:icon];
    self.icon=icon;
//    icon.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_card_background_highlighted"]];
    icon.layer.borderColor=[UIColor colorWithWhite:0.8 alpha:1.0].CGColor;
    icon.layer.borderWidth=0.5;
    icon.layer.contents=(id)[UIImage imageNamed:@"icon"].CGImage;
    UILabel *name=[[UILabel alloc]init];
    name.numberOfLines=0;
    name.font=[UIFont systemFontOfSize:12];
    [self.contentView addSubview:name];
    self.name=name;
//    name.backgroundColor=[UIColor redColor];
    UILabel *time=[[UILabel alloc]init];
    time.numberOfLines=0;
    time.textColor=[UIColor lightGrayColor];
    time.font=[UIFont systemFontOfSize:10];
    [self.contentView addSubview:time];
    self.time=time;
//    time.backgroundColor=[UIColor blueColor];
    LSStatusLabel *text=[[LSStatusLabel alloc]init];
    [self.contentView addSubview:text];
    self.text=text;
//    text.backgroundColor=[UIColor yellowColor];
    UIView *line=[[UIView alloc]init];
    [self.contentView addSubview:line];
    line.backgroundColor=[UIColor colorWithWhite:0.5 alpha:1];
    self.line=line;
}
-(void)setCommentFrame:(LSCommentFrame *)commentFrame
{
    _commentFrame=commentFrame;
    
    LSComment *comment=_commentFrame.comment;
    //设置数据
    [self.icon setImageWithURL:comment.user.profile_image_url ];
    self.name.text=comment.user.name;
    self.time.text=[comment.created_at getDetailTime];
    self.text.attributedText=comment.attributedText;
    
    //设置frame
    self.icon.frame=_commentFrame.iconFrame;
    self.name.frame=_commentFrame.nameFrame;
    self.time.frame=_commentFrame.timeFrame;
    self.text.frame=_commentFrame.textFrame;
    self.line.frame=CGRectMake(0, _commentFrame.cellHeight-1, LSScreenWidth, 1);
    
}
@end
