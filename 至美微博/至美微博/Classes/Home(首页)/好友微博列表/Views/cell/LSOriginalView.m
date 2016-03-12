






//
//  LSOriginalView.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSOriginalView.h"
#import "LSStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "LSUser.h"
#import "LSPhotos.h"
#import "LSStatusLabel.h"
@interface LSOriginalView ()
@property (nonatomic, weak) UIImageView *icon;
@property (nonatomic, weak) UILabel *name;
@property (nonatomic, weak) UIImageView *vip;
@property (nonatomic, weak) UILabel *time;
@property (nonatomic, weak) UILabel *source;
@property (nonatomic, weak) LSStatusLabel  *text;
@property (nonatomic, weak) LSPhotos *photosView;
@end
@implementation LSOriginalView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        UIImage *image=[UIImage imageWithStretchableName:@"timeline_card_top_background"];
        self.image=image;
        [self setHighlightedImage:[UIImage imageWithStretchableName:@"timeline_card_top_background_highlighted"]];

        [self setupAllChildView];
        
    }
    return self;
}
-(void)setupAllChildView
{
    


    LSPhotos *photosView=[[LSPhotos alloc]init];
    self.photosView=photosView;
    [self addSubview:photosView];

    
    //添加头像
    UIImageView *icon=[[UIImageView alloc]init];
    [self addSubview:icon];
    self.icon=icon;
    
    UILabel *name= [[UILabel alloc]init];
    [self addSubview:name];
    self.name=name;
    self.name.font=LSNameFont;
    UIImageView *vip=[[UIImageView alloc]init];
    [self addSubview:vip];
    self.vip=vip;
    
    
    UILabel *time=[[UILabel alloc]init];
    time.font=LSTimeFont;
    [self addSubview:time];
    self.time=time;
    time.numberOfLines=0;
//    time.backgroundColor=[UIColor blackColor];
    UILabel *source=[[UILabel alloc]init];
    [self addSubview:source];
    self.source=source;
    self.source.font=LSSourceFont;
    source.textColor=[UIColor colorWithWhite:0.5 alpha:0.8];
   
    LSStatusLabel *text=[[LSStatusLabel alloc]init];
    [self addSubview: text];
    self.text=text;



}
-(void)setStatusFrame:(LSStatusFrame *)statusFrame
{
    //设置数据
    
    _statusFrame=statusFrame;
    LSStatus *status=_statusFrame.status;
    [self.icon setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.name.text=status.user.name;

    if (self.vip) {
        self.vip.hidden=NO;
        self.name.textColor=[UIColor redColor];
        self.time.textColor=[UIColor redColor];

    }else{
        self.name.textColor=[UIColor blackColor];
        self.vip.hidden=YES;
        self.time.textColor=[UIColor blackColor];

    }
    
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];

    self.vip.image=[UIImage imageNamed:imageName];
    

    //设置frame
    _statusFrame=statusFrame;
    self.icon.frame=_statusFrame.originalIconFrame;
    self.name.frame=_statusFrame.originalNameFrame;
    self.vip.frame=_statusFrame.originalVipFrame;


    //时间frame
    CGFloat timeX=_statusFrame.originalNameFrame.origin.x;
    CGFloat timeY=CGRectGetMaxY(_statusFrame.originalNameFrame)+5;
    CGFloat timeW=[NSString sizeWithText:[NSString getTimeWithString:_statusFrame.status.created_at] maxSize:CGSizeMake(200, 20) font:LSTimeFont].width;
    CGFloat timeH=[NSString sizeWithText:_statusFrame.status.created_at maxSize:CGSizeMake(200, 20) font:LSTimeFont].height;
    self.time.frame=CGRectMake(timeX, timeY, timeW, timeH);
    
    //来源frame
    CGFloat resourceX=CGRectGetMaxX(self.time.frame)+10;
    CGFloat resourceY=timeY;
    CGFloat resourceW=[NSString sizeWithText:_statusFrame.status.source maxSize:CGSizeMake(200, 20) font:LSSourceFont].width;
    CGFloat resourceH=[NSString sizeWithText:_statusFrame.status.source maxSize:CGSizeMake(200, 20) font:LSSourceFont].height;
    self.source.frame=CGRectMake(resourceX, resourceY, resourceW, resourceH);
    
    self.time.text=[NSString getTimeWithString:status.created_at];
    self.source.text=status.source;
    
//    设置原创微博内容
    if (status.isRetweet) {
        NSMutableAttributedString *att=[[NSMutableAttributedString alloc]initWithAttributedString:status.attributedText];
        int length=status.user.name.length+2;
        [att deleteCharactersInRange:NSMakeRange(0, length)];
        self.text.attributedText=att;
        
        
    }else {
        self.text.attributedText=status.attributedText;
    }
    
    self.text.frame=_statusFrame.originalTextFrame;
    self.photosView.frame=_statusFrame.originalPhotosFrame;
    self.photosView.pic_urls=_statusFrame.status.pic_urls;
    
    
    
    
}

@end
