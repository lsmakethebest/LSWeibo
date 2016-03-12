




//
//  LSPopMenu.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSPopMenu.h"
@implementation LSPopMenu
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        [self setupAllChildView];
    }
    return self;
}
-(void)setupAllChildView
{
    self.image=[UIImage imageWithStretchableName:@"popover_background"];
}
+(instancetype)showInRect:(CGRect)rect
{
    LSPopMenu *popMenu=[[self alloc]initWithFrame:rect];
    [[UIApplication sharedApplication].keyWindow addSubview:popMenu];
    return popMenu;
}
+(void)hide
{
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([view isKindOfClass:[LSPopMenu class]]) {
            [view removeFromSuperview];
        
        }
    }
}
-(void)setConntentView:(UIView *)conntentView
{
    [_conntentView removeFromSuperview];
    _conntentView=conntentView;
    [self addSubview:_conntentView];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin=5;
    CGFloat y=9;
    CGFloat w=self.width-2*margin;
    CGFloat h=self.height-margin-40;
    _conntentView.frame=CGRectMake(margin,y , w, h);
    
}
@end
