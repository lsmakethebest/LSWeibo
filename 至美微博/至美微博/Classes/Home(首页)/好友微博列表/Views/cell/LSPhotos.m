

//
//  LSPhotos.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSPhotos.h"
#import "LSPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "LSPhoto.h"
@implementation LSPhotos

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self  setupAllChildView];
    }
    return self;
}
-(void)setupAllChildView
{
    for (int i=0; i<9; i++) {
        LSPhotoView *photo= [[LSPhotoView alloc]init];

        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [photo addGestureRecognizer:tap];
        photo.tag=i;
        [self addSubview:photo];
    }
}
-(void)setPic_urls:(NSArray *)pic_urls
{
    //    NSLog(@"%@",self.subviews);
    _pic_urls=pic_urls;
    int count=pic_urls.count;
    for (int i=0; i<9; i++) {
        LSPhotoView *photo=  self.subviews[i];
        if (i<count) {
            self.subviews[i].hidden=NO;
            photo.photo=pic_urls[i];
        }
        else{
            photo.hidden=YES;
        }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    int count=_pic_urls.count;
    int rols=count==4?2:3;
    CGFloat x,y,w,h;
    CGFloat  nineWidth=(LSScreenWidth-2*LSCellMargin-2*LSMicroMargin)/3;
    CGFloat  oneWidth=(LSScreenWidth-2*LSCellMargin-LSMicroMargin)/2;
    if (count==0) {
        for (LSPhotoView *view in self.subviews) {
            view.frame=CGRectZero;
        }
        return;
    }
    if(count==1){
        self.subviews[0].frame=CGRectMake(0, 0, oneWidth, oneWidth);
        return;
    }
    else
    {
        for (int i=0; i<count; i++) {
            h=w=nineWidth;
            x=i%rols*(LSMicroMargin+nineWidth);
            y=i/rols*(LSMicroMargin+nineWidth);
            self.subviews[i].frame=CGRectMake(x, y, w, h);
        }
    }
}
-(void)tapGesture:(UITapGestureRecognizer *)recognizer
{
    MJPhotoBrowser *browser=[[MJPhotoBrowser alloc]init];
    NSMutableArray *photos=[NSMutableArray array];
    for (int i=0; i<self.pic_urls.count; i++) {
        LSPhoto *pic=self.pic_urls[i];
        MJPhoto *photo=[[MJPhoto alloc]init];
        photo.url=pic.bmiddle_pic;
        photo.srcImageView=self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos=photos;
    browser.currentPhotoIndex=recognizer.view.tag;
    [browser show];
    NSLog(@"sgdfkhskjdhfk");
    
    
    
}
@end
