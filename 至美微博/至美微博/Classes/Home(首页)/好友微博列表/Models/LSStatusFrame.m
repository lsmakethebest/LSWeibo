



//
//  LSAccountFrame.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSStatusFrame.h"
#import "LSUser.h"
#import "LSStatus.h"
#define LSCellMargin 10
@implementation LSStatusFrame
-(void)setStatus:(LSStatus *)status
{
    _status=status;
    
    [self setupOriginalFrame];
    if (status.retweeted_status) {
        
        [self setupRetweetFrame];
    }
    else{
        _retweetViewFrame=CGRectZero;
    }
    [self setupToolBarFrame];
    
}
-(void)setupOriginalFrame
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    //头像frame
    CGFloat originalIconX=LSCellMargin;
    CGFloat originalIconY=originalIconX;
    CGFloat originalIconW=35;
    CGFloat originalIconH=originalIconW;
    _originalIconFrame=CGRectMake(originalIconX, originalIconY, originalIconW , originalIconH);
    
    //昵称frame
    
    CGFloat originalNameW=[NSString sizeWithText:_status.user.name maxSize: CGSizeMake(size.width-100, CGFLOAT_MAX) font: LSNameFont].width;
    CGFloat originalNameH=[NSString sizeWithText:_status.user.name maxSize: CGSizeMake(size.width-100, CGFLOAT_MAX) font: LSNameFont].height;
    CGFloat originalNameX=CGRectGetMaxX(_originalIconFrame)+10;
    CGFloat originalNameY=originalIconY;
    _originalNameFrame=CGRectMake(originalNameX, originalNameY, originalNameW, originalNameH);
    
    //vip frame
    CGFloat vipX=CGRectGetMaxX(_originalNameFrame)+5;
    CGFloat vipY=originalNameY;
    CGFloat vipW=15;
    CGFloat vipH=vipW;
    _originalVipFrame=CGRectMake(vipX, vipY, vipW, vipH);
    
    
    
    //内容frame
    CGFloat contectX=LSCellMargin;
    CGFloat contentY=CGRectGetMaxY(_originalIconFrame)+LSCellMargin;
    CGFloat contentW=[_status.attributedText boundingRectWithSize:CGSizeMake(size.width-2*LSCellMargin, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
    CGFloat contentH=[_status.attributedText boundingRectWithSize:CGSizeMake(size.width-2*LSCellMargin, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    _originalTextFrame=CGRectMake(contectX, contentY, contentW, contentH);
    
    
    //图片(photos)frame
    
    CGFloat originalePhotosX=LSCellMargin;
    CGFloat originalePhotosY=CGRectGetMaxY(_originalTextFrame)+LSCellMargin;
    CGSize photosSize=[self sizeWithCount:_status.pic_urls.count];
    _originalPhotosFrame=CGRectMake(originalePhotosX, originalePhotosY, photosSize.width, photosSize.height);
    
    
    //原创微博视图frame
    CGFloat originalViewX=0;
    CGFloat originalViewY=0;
    CGFloat originalViewW=[UIScreen mainScreen].bounds.size.width;
    
    CGFloat originalViewH=CGRectGetMaxY(_originalTextFrame)+LSCellMargin;
    if (_status.pic_urls.count) {
        originalViewH=CGRectGetMaxY(_originalPhotosFrame)+LSCellMargin;
    }
    _originalViewFrame=CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
    
    
    
    
    
}
-(void)setupRetweetFrame
{
    //昵称和内容frame
    CGFloat nameX,nameY,nameW,nameH;
    nameX=LSCellMargin;
    nameY=LSCellMargin;
    nameW=[self.status.retweeted_status.attributedText boundingRectWithSize:CGSizeMake(LSScreenWidth-2*LSCellMargin, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.width;
    nameH=[self.status.retweeted_status.attributedText boundingRectWithSize:CGSizeMake(LSScreenWidth-2*LSCellMargin, CGFLOAT_MAX)  options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
    _retweetNameAndTextFrame=CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat photosX,photosY;
    photosX=LSCellMargin;
    photosY=CGRectGetMaxY(_retweetNameAndTextFrame)+LSCellMargin;
    CGSize size=[self sizeWithCount:_status.retweeted_status.pic_urls.count];
    _retweetPhotosFrame=CGRectMake(photosX, photosY, size.width, size.height);
    
    /**计算转发微博toolbar*************/
    if (_status.isDetail) {
        CGFloat repostX,repostY,repostW,repostH;
        repostH=LSReteetToolbarHeight;
        repostY=0;
        CGSize repostSize= [[ NSString stringWithFormat:@"%d",self.status.retweeted_status.reposts_count] sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, LSReteetToolbarHeight) font:LSReteetToolbarFont];
        repostW=repostSize.width+25;
        repostX= 0;
        _repostFrame=CGRectMake(repostX, repostY, repostW, repostH);
        
        CGFloat commentX,commentY,commentW,commentH;
        commentH=LSReteetToolbarHeight;
        commentY=0;
        CGSize commentSize= [[ NSString stringWithFormat:@"%d",self.status.retweeted_status.comments_count] sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, LSReteetToolbarHeight) font:LSReteetToolbarFont];
        commentW=commentSize.width+25;
        commentX= CGRectGetMaxX(_repostFrame)+15;
        _commentFrame=CGRectMake(commentX, commentY, commentW, commentH);
        
        
        CGFloat unlikeX,unlikeY,unlikeW,unlikeH;
        unlikeH=LSReteetToolbarHeight;
        unlikeY=0;
        CGSize unlikeSize= [[ NSString stringWithFormat:@"%d",self.status.retweeted_status.attitudes_count] sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, LSReteetToolbarHeight) font:LSReteetToolbarFont];
        unlikeW=unlikeSize.width+25;
        unlikeX=CGRectGetMaxX(_commentFrame)+15;
        _unlikeFrame=CGRectMake(unlikeX, unlikeY, unlikeW, unlikeH);
        
        CGFloat toolbarX,toolbarY,toolbarW,toolbarH;
        toolbarW=CGRectGetMaxX(_unlikeFrame);
        toolbarX=LSScreenWidth-toolbarW-10;
        
        if (_status.retweeted_status.pic_urls.count) {
            toolbarY=CGRectGetMaxY(_retweetPhotosFrame)+LSCellMargin;
        }else {
            toolbarY=CGRectGetMaxY(_retweetNameAndTextFrame)+LSCellMargin;
        }

            toolbarH=LSReteetToolbarHeight;
        
        _retweetToolbarFrame=CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        
        CGFloat retweetViewX,retweetViewY,retweetViewW,retweetViewH;
        retweetViewX=0;
        retweetViewY=CGRectGetMaxY(_originalViewFrame) ;
        retweetViewW=LSScreenWidth;
        retweetViewH=CGRectGetMaxY(_retweetToolbarFrame)+LSCellMargin;
        _retweetViewFrame=CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        
        
        
    }else{//不是展示在详情里
        _retweetToolbarFrame=CGRectZero;
        _repostFrame=CGRectZero;
        _commentFrame=CGRectZero;
        _unlikeFrame=CGRectZero;
        CGFloat retweetViewX,retweetViewY,retweetViewW,retweetViewH;
        retweetViewX=0;
        retweetViewY=CGRectGetMaxY(_originalViewFrame) ;
        retweetViewW=LSScreenWidth;
        if (_status.retweeted_status.pic_urls.count) {
            retweetViewH=CGRectGetMaxY(_retweetPhotosFrame)+LSCellMargin;
        }else {
            retweetViewH=CGRectGetMaxY(_retweetNameAndTextFrame)+LSCellMargin;
        }
        
        _retweetViewFrame=CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
    }
    
    
    
}
-(void)setupToolBarFrame
{
    if (_status.isDetail) {
        _toolBarFrame=CGRectZero;
        
        if (_status.retweeted_status) {
            _cellHeight=CGRectGetMaxY(_retweetViewFrame);
        }
        else{
            _cellHeight=CGRectGetMaxY(_originalViewFrame);
        }
        
    }else{
        if (_status.retweeted_status) {
            _toolBarFrame=CGRectMake(0, CGRectGetMaxY(_retweetViewFrame), LSScreenWidth, 35);
        }
        else{
            _toolBarFrame=CGRectMake(0, CGRectGetMaxY(_originalViewFrame), LSScreenWidth, 35);
        }
        _cellHeight=CGRectGetMaxY(_toolBarFrame);
        
    }
    
}
-(CGSize)sizeWithCount:(int)count
{
    if(count==0)return CGSizeZero;
    
    CGFloat  nineWidth=(LSScreenWidth-2*LSCellMargin-2*LSMicroMargin)/3;
    CGFloat  oneWidth=(LSScreenWidth-2*LSCellMargin-LSMicroMargin)/2;
    
    CGFloat w,h;
    if (count==4) {
        
        return CGSizeMake(2*nineWidth+LSMicroMargin, 2*nineWidth+LSMicroMargin) ;
    }
    if (count==1) {
        w=oneWidth;
        h=oneWidth;
        
    }
    else if(count==2){
        w=count*nineWidth+(count-1)*LSMicroMargin;
        h=nineWidth;
        
    }
    else if(count%3==0)
    {
        w= LSScreenWidth -2*LSCellMargin;
        h=count/3*nineWidth+(count/3-1)*LSMicroMargin;
    }
    else if(count%3!=0){
        
        w= LSScreenWidth -2*LSMicroMargin;
        h=(count/3+1)*nineWidth+count/3*LSMicroMargin;
        
    }
    
    return CGSizeMake(w,h);
}
-(NSString*)count:(int)count name:(NSString*)name
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
    return title;
}

@end
