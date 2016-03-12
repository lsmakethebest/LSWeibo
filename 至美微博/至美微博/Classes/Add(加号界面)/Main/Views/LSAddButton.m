



//
//  LSAddButton.m
//  新浪微博
//
//  Created by song on 15/9/20.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSAddButton.h"

#define ButtonW 71
#define ButtonH 100
#define LSAddTitleFont [UIFont systemFontOfSize:16]
#define LSTitleBigFont [UIFont systemFontOfSize:18]
@implementation LSAddButton
-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return  CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    NSString *text=[self titleForState:UIControlStateNormal];
    CGSize size;

         size=[text sizeOfTextWithMaxSize:CGSizeMake(CGFLOAT_MAX, 20) font:LSAddTitleFont];
        return CGRectMake((contentRect.size.width-size.width)*0.5, contentRect.size.width+10, size.width, 20);
    
}
-(void)setHighlighted:(BOOL)highlighted
{}
@end
