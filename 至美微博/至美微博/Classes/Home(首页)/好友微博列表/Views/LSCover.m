


//
//  LSCover.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSCover.h"

@implementation LSCover

+(instancetype)show
{
    LSCover *cover=[[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
//    cover.backgroundColor=[UIColor lightGrayColor];
//    cover.alpha=0.5;
    return cover;
}
-(void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground=dimBackground;
    if (!_dimBackground) {
        self.backgroundColor=[UIColor redColor];
    }
    else
    {
        self.backgroundColor=[UIColor redColor]  ;
    }

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(coverClick:)]) {
        [self.delegate coverClick:self];
    }
}
@end
