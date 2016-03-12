

//
//  LSTitleButton.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSTitleButton.h"

#define LSLeftMargin 10
@implementation LSTitleButton
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.height=40;
        self.adjustsImageWhenHighlighted=NO;
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=LSTitleFont;
        self.titleLabel.numberOfLines=0;
        self.imageView.contentMode=UIViewContentModeCenter;
        [self setBackgroundImage:[UIImage imageWithStretchableName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
    }
    return self;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX,imageY,imageW,imageH;
    imageW=30;
    imageX=self.width-imageW;
    imageY=0;
    imageH=self.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX,titleY,titleW,titleH;
    titleX=0;
    titleY=0;
    titleW=self.width-30;
    titleH=40;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGFloat w =[title sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, 20) font:LSTitleFont].width+30;
    self.width=w;
    
    
}
@end
