

//
//  LSRetweetView.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSRetweetView.h"
#import "LSPhotos.h"
#import "LSStatusFrame.h"
#import "LSStatus.h"
#import "LSUser.h"
#import "LSPhotos.h"
#import "LSStatusLabel.h"
#import "LSRetweetToolbar.h"
@interface LSRetweetView ()
@property (nonatomic, weak) LSStatusLabel  *nameAndText;

@property (nonatomic, weak) LSPhotos *photosView;
@property (nonatomic, weak) LSRetweetToolbar *toolbar;
@end
@implementation LSRetweetView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;

//        self.layer.backgroundColor=[UIColor redColor].CGColor;
//        UIImage *image=[UIImage imageNamed:@"timeline_retweet_background"];
//        self.layer.contents=(id)image.CGImage;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
        [self setHighlightedImage:[UIImage imageWithStretchableName:@"timeline_retweet_background_highlighted"]];
        [self setupAllChildView];
        
    }
    return self;
}
-(void)setupAllChildView
{

    //名称和内容视图
    LSStatusLabel *nameAndText=[[LSStatusLabel alloc]init];
    [self addSubview:nameAndText];
    self.nameAndText=nameAndText;


    //图片数组视图
    LSPhotos *photosView=[[LSPhotos alloc]init];
    [self addSubview:photosView];
    self.photosView=photosView;
    //toolbar
    LSRetweetToolbar *toolbar=[[LSRetweetToolbar alloc]init];
//    toolbar.backgroundColor=[UIColor redColor];
    [self addSubview:toolbar];
    self.toolbar=toolbar;

}
-(void)setStatusFrame:(LSStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    
    self.nameAndText.attributedText=statusFrame.status.retweeted_status.attributedText;
    
    //设置frame
    self.nameAndText.frame=statusFrame.retweetNameAndTextFrame;
    self.photosView.frame=statusFrame.retweetPhotosFrame;
    self.photosView.pic_urls=_statusFrame.status.retweeted_status.pic_urls;
    
    self.toolbar.frame=_statusFrame.retweetToolbarFrame;
    self.toolbar.statusFrame=_statusFrame;
}
@end
