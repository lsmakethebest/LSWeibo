
//
//  LSStatusDetailsFrame.m
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSStatusDetailsFrame.h"
#import "LSStatus.h"
#import "LSUser.h"
@implementation LSStatusDetailsFrame

-(void)setStatus:(LSStatus *)status
{
    _status=status;
    
    [self setupOriginalFrame];
    if (status.retweeted_status) {
        
        [self setupRetweetFrame];
        _headerViewHeight=CGRectGetMaxY(_retweetViewFrame)+LSCellMargin;
    }
    else{
        _retweetViewFrame=CGRectZero;
        _headerViewHeight=CGRectGetMaxY(_originalViewFrame)+LSCellMargin;
    }

    
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
    CGFloat contentW=[_status.text sizeOfTextWithMaxSize:CGSizeMake(size.width-2*LSCellMargin, CGFLOAT_MAX) font:LSTextFont].width;
    CGFloat contentH=[_status.text sizeOfTextWithMaxSize:CGSizeMake(size.width-2*10, CGFLOAT_MAX) font:LSTextFont].height;
    _originalTextFrame=CGRectMake(contectX, contentY, contentW, contentH);
    
    
    //图片(photos)frame
    
    CGFloat originalePhotosX=LSCellMargin;
    CGFloat originalePhotosY=CGRectGetMaxY(_originalTextFrame)+LSCellMargin;
    CGSize photosSize=[self sizeWithCount:_status.pic_urls.count];
    _originalPhotosFrame=CGRectMake(originalePhotosX, originalePhotosY, photosSize.width, photosSize.height);
    
    
    //原创微博视图frame
    CGFloat originalViewX=0;
    CGFloat originalViewY=LSCellMargin;
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
    NSString *nameAndText=[NSString stringWithFormat:@"%@:%@", _status.retweetName,_status.retweeted_status.text];
    nameW=[nameAndText sizeOfTextWithMaxSize: CGSizeMake( LSScreenWidth-2*LSCellMargin, CGFLOAT_MAX) font:LSTextFont].width;
    nameH=[nameAndText sizeOfTextWithMaxSize: CGSizeMake( LSScreenWidth-2*LSCellMargin, CGFLOAT_MAX) font:LSTextFont].height;
    _retweetNameAndTextFrame=CGRectMake(nameX, nameY, nameW, nameH);
    
    CGFloat photosX,photosY;
    photosX=LSCellMargin;
    photosY=CGRectGetMaxY(_retweetNameAndTextFrame)+LSCellMargin;
    CGSize size=[self sizeWithCount:_status.retweeted_status.pic_urls.count];
    _retweetPhotosFrame=CGRectMake(photosX, photosY, size.width, size.height);
    
    //3个按钮的统一Y值
    CGFloat toolbarY=CGRectGetMaxY(_retweetNameAndTextFrame)+LSCellMargin;
    if (_status.retweeted_status.pic_urls.count) {
        toolbarY=CGRectGetMaxY(_retweetPhotosFrame)+LSCellMargin;
    }
    
    CGFloat margin=40;
    CGFloat unlikeX,unlikeY,unlikeW,unlikeH;
    
    CGFloat toolbarH=30;
    //赞按钮frame
    NSString *unlikeStr=[self count:_status.retweeted_status.attitudes_count name:@"赞"];
CGSize unlikeSize=[unlikeStr sizeOfTextWithMaxSize:CGSizeMake(100,toolbarH) font:[UIFont systemFontOfSize:12]];
    unlikeW=unlikeSize.width+margin;
    unlikeH=toolbarH;
    unlikeX=LSScreenWidth-LSCellMargin-unlikeW;
    unlikeY=toolbarY;
    _unlikeFrame=CGRectMake(unlikeX, unlikeY, unlikeW, unlikeH);
    
     //评论按钮frame
    CGFloat commentX,commentY,commentW,commentH;
    NSString *commentStr=[self count:_status.retweeted_status.comments_count name:@"评论"];
    CGSize commentSize=[commentStr sizeOfTextWithMaxSize:CGSizeMake(100,toolbarH) font:[UIFont systemFontOfSize:12]];
    commentW=commentSize.width+margin;
    commentH=toolbarH;
    commentX=CGRectGetMinX(_unlikeFrame)-commentW-LSCellMargin;
    commentY=toolbarY;
    _commentFrame=CGRectMake(commentX, commentY, commentW, commentH);
    
    //转发按钮frame
    CGFloat retweetX,retweetY,retweetW,retweetH;
    NSString *retweetStr=[self count:_status.retweeted_status.reposts_count name:@"转发"];
    CGSize retweetSize=[retweetStr sizeOfTextWithMaxSize:CGSizeMake(100,toolbarH) font:[UIFont systemFontOfSize:12]];
    retweetW=retweetSize.width+margin;
    retweetH=toolbarH;
    retweetX=CGRectGetMinX(_commentFrame)-commentW-LSCellMargin;
    retweetY=toolbarY;
    _retweetFrame=CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
    
     CGFloat retweetViewX,retweetViewY,retweetViewW,retweetViewH;
    retweetViewX=0;
    retweetViewY=CGRectGetMaxY(_originalViewFrame);
    retweetViewW=LSScreenWidth;
    retweetViewH=CGRectGetMaxY(_commentFrame) +LSCellMargin;
    _retweetViewFrame=CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
    
    
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
