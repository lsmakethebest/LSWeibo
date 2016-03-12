

//
//  LSTabBar.m
//  新浪微博
//
//  Created by song on 15/9/19.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSTabBar.h"

@interface LSTabBar ()
@property (nonatomic, weak) UIButton *addBtn;
@end
@implementation LSTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        UIButton *addBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [addBtn setBackgroundImage:[UIImage imageWithOriginalName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
         [addBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        addBtn.adjustsImageWhenHighlighted=NO;

        [self addSubview:addBtn];
        self.addBtn=addBtn;
        [addBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
-(void)layoutSubviews
{
    NSLog(@"count==%d",self.subviews.count);
    [super layoutSubviews];
    int count=self.subviews.count;
    int max=5;
    CGFloat w=LSScreenWidth/max;
    CGFloat h=self.height;
    int number=0;
    for (int i=0; i<count; i++) {
     UIView * btn=self.subviews[i];
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {//是UITabBarButton
            if (number<2) {
                btn.frame=CGRectMake( number*w,0,w, h);
            }
            else if (number==2) {
              btn.frame=CGRectMake(3*w,0, w, h);
            }else if(number==3){
                
                btn.frame=CGRectMake(4*w,0, w, h);
            }
            number++;
        }else if([btn isKindOfClass:[UIButton class]]){//是新添加的按钮
            btn.frame=CGRectMake(2*w, 0, w, h);
        }
    }
}

-(void)click
{
    if ([self.myDelegate respondsToSelector:@selector(tabBarClick:)]) {
        [self.myDelegate tabBarClick:self];
    }

    
}

@end
