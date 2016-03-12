


//
//  LSPhotoView.m
//  至美微博
//
//  Created by song on 15/10/10.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSPhotoView.h"
#import "UIImageView+WebCache.h"
#import "LSPhoto.h"

@interface LSPhotoView ()
@property (nonatomic, weak) UIImageView *gifView;
@end
@implementation LSPhotoView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.userInteractionEnabled=YES;
        self.clipsToBounds=YES;
//        self.backgroundColor=[UIColor blueColor];
        self.contentMode=UIViewContentModeScaleAspectFill;
        UIImageView *gifView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView=gifView;
    }
    return self;
}
-(void)setPhoto:(LSPhoto *)photo
{
    _photo=photo;
    [self setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    if ([[photo.thumbnail_pic absoluteString] hasSuffix:@"gif"]) {
        self.gifView.hidden=NO;
    }
    else{
        self.gifView.hidden=YES;
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.gifView.x=self.width-self.gifView.width;
    self.gifView.y=self.height-self.gifView.height;
    

    
    
}
@end
