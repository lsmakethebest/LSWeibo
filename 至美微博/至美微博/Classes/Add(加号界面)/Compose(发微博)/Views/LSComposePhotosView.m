



//
//  LSPhotosView.m
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSComposePhotosView.h"

@implementation LSComposePhotosView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
    }
    return self ;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    int count=self.subviews.count;
    CGFloat margin=10;
    int max=4;
    CGFloat w=(self.width-(max+1)*margin)/max;
    for (int i=0; i<count; i++) {
        UIImageView *imageView=self.subviews[i];
        imageView.width=w;
        imageView.height=w;
        imageView.x=margin+i%max*(margin+w);
        imageView.y=i/max*(margin+w);
    }
}

-(void)addImageViewWithImage:(UIImage *)image
{
    UIImageView *imageView=[[UIImageView alloc]init];
    imageView.image=image;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds=YES;
    [self addSubview:imageView];
    
}

-(NSArray*)images
{
    NSMutableArray *arr=[NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [arr addObject:imageView.image];
    }
    return arr;
}
@end
