


//
//  LSCommentFrame.m
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSCommentFrame.h"
#import "LSComment.h"
#import "LSUser.h"
@implementation LSCommentFrame
-(void)setComment:(LSComment *)comment
{
    _comment=comment;

    //计算frame
    [self setupFrame];
}
   //计算frame
-(void)setupFrame
{
    
    //头像frame
    CGFloat iconX,iconY,iconW,iconH;
    iconX=LSCellMargin;
    iconY=LSCellMargin;
    iconW=35;
    iconH=iconW;
    _iconFrame=CGRectMake(iconX, iconY, iconW, iconH);
    
//    昵称frame
    CGFloat nameX,nameY,nameW,nameH;
    nameX=CGRectGetMaxX(_iconFrame)+LSCellMargin;
    nameY=LSCellMargin;
    CGSize nameSize=[_comment.user.name sizeOfTextWithMaxSize:CGSizeMake(LSScreenWidth-nameX, 20) font:[UIFont systemFontOfSize:12]];
    nameW=nameSize.width;
    nameH=nameSize.height;
    _nameFrame=CGRectMake(nameX , nameY , nameW, nameH);
    
    //    时间frame
    CGFloat timeX,timeY,timeW,timeH;
    timeX=nameX;
    timeY=CGRectGetMaxY(_nameFrame)+5;
    CGSize timeSize=[[_comment.created_at getDetailTime] sizeOfTextWithMaxSize:CGSizeMake(LSScreenWidth-nameX, 20) font:[UIFont systemFontOfSize:10]];
    timeW=timeSize.width;
    timeH=timeSize.height;
    _timeFrame=CGRectMake(timeX , timeY , timeW, timeH);

    
    //    评论内容frame
    CGFloat textX,textY,textW,textH;
    textX=nameX;
    textY=CGRectGetMaxY(_iconFrame)+5;
    CGSize textSize=[_comment.attributedText boundingRectWithSize:CGSizeMake(LSScreenWidth-nameX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    textW=textSize.width;
    textH=textSize.height;
    _textFrame=CGRectMake(textX , textY , textW, textH);
    _cellHeight=CGRectGetMaxY(_textFrame)+LSCellMargin;
}
@end
