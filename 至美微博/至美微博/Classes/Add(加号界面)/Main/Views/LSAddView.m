








//
//  LSAddView.m
//  新浪微博
//
//  Created by song on 15/9/20.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSAddView.h"
#import "LSAddButton.h"
#define ViewHeight 200
#define ViewY 200
#define TitleFont [UIFont systemFontOfSize:14]
@interface LSAddView ()


@property (nonatomic, weak) UIView *view1;
@property (nonatomic, weak) UIView *view2;


@end
@implementation LSAddView

+(instancetype)addView
{
    LSAddView *view=[[self alloc]init];
    return view;
}

-(instancetype)init
{
    if (self=[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        UIView *view1=[[UIView alloc]init];
        NSArray *arr= [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"addText" ofType:@"plist"]];
        for (int i=0; i<6; i++) {
            LSAddButton *btn=[[LSAddButton alloc]init];
            [btn addGestureRecognizer:[[UIGestureRecognizer  alloc]initWithTarget:self action:@selector(handleTapGesture:)]];
            [btn addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)]];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            btn.imageView.backgroundColor=[UIColor redColor];
//            btn.backgroundColor=[UIColor blueColor];
            btn.titleLabel.font=TitleFont;
            [view1  addSubview:btn];
        }
        [self addSubview:view1];
        self.view1=view1;
 
         UIView *view2=[[UIView alloc]init];
        for (int i=6; i<12; i++) {
            LSAddButton *btn=[[LSAddButton alloc]init];
             [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn addGestureRecognizer:[[UIGestureRecognizer  alloc]initWithTarget:self action:@selector(handleTapGesture:)]];
            [btn addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)]];
             btn.titleLabel.font=TitleFont;
            btn.titleLabel.textAlignment=NSTextAlignmentCenter;
//              btn.backgroundColor=[UIColor blueColor];
            [view2  addSubview:btn];
        }
        [self addSubview:view2];
        self.view2=view2;
    }
    return  self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    
    
    //设置view1的frame
    //设置view2的frame
    self.view2.frame=CGRectMake(w, ViewY, w, ViewHeight);
    self.view1.frame=CGRectMake(0, ViewY, w, ViewHeight);
    
    CGFloat btnX,btnY,btnW,btnH;
    btnW=80;
    btnH=100;
    //设置子控件frame
    
    for (int i=0;i<6;i++) {
        btnX=45+80*(i%3);
        btnY=(btnH+10)*(i/3);
        self.view1.subviews[i].frame=CGRectMake(btnX, btnY, btnW, btnH);
        self.view2.subviews[i].frame=CGRectMake(btnX, btnY, btnW, btnH);
    }

    for (LSAddView* btn in self.view1.subviews) {
        btn.backgroundColor=[UIColor blueColor];
    }
//    self.view1.backgroundColor=[UIColor blueColor];
//    NSLog(@"%@",NSStringFromCGRect( self.view1.frame));
}
-(void)handleLongPressGesture:(UILongPressGestureRecognizer*)longPress
{
    if (longPress.state==UIGestureRecognizerStateBegan) {
        
    }
    else if(longPress.state==UIGestureRecognizerStateEnded)
    {
        
    }
        
    
}
//单击手势
-(void)handleTapGesture:(UITapGestureRecognizer*)tap
{
    
}

@end
