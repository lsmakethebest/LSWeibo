//
//  LSAddController.m
//  新浪微博
//
//  Created by song on 15/9/20.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSAddController.h"
#import "LSAddView.h"
#import "LSAddButton.h"
#import "KVNProgress.h"
#import "LSNavigationController.h"
#define BottomHeight 49
#define MainViewHeight 230
#define ButtonW 71
#define ButtonH 100
#define TitleFont [UIFont systemFontOfSize:16]
#define TitleBigFont [UIFont systemFontOfSize:18]
#import "LSComposeController.h"
typedef  enum
{
    LSButtonTypeCompose,
    LSButtonTypeMore=5
}LSButtonType;

@interface LSAddController ()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *mainView;
@property(nonatomic,assign) CGRect ogiginalRect;

@property (nonatomic, weak) UIButton *backBtn;
@property (nonatomic, weak) UIButton *cancleBtn;
@property (nonatomic, strong) NSArray *myArr;
@property (nonatomic, weak) UIView *keyView;
@end

@implementation LSAddController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
//加载12个按钮view
-(void)settingMainView
{
    CGFloat screenH=[UIScreen mainScreen].bounds.size.height;
    UIView *keyView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [LSKeyWindow addSubview:keyView];
    keyView.backgroundColor=[UIColor colorWithRed:245/255.0 green:255/255.0 blue:250/255.0 alpha:1];
    self.keyView=keyView;
    
    //添加底部白条(存放两个按钮)
    UIView *bottomView=[[UIView alloc]init];
    bottomView.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    bottomView.frame=CGRectMake(0, screenH-BottomHeight, LSScreenWidth, BottomHeight);
    
    //添加底部关闭按钮
    UIButton *cancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.adjustsImageWhenHighlighted=NO;
    cancleBtn.frame=bottomView.bounds;
    [bottomView addSubview:cancleBtn];
    [cancleBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn=cancleBtn;
    [keyView addSubview:bottomView];
    
    //添加底部返回按钮
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return"] forState:UIControlStateNormal];
    backBtn.frame=CGRectMake(0, 0, LSScreenWidth/2.0, bottomView.frame.size.height);
    backBtn.hidden=YES;
    [backBtn addTarget:self action:@selector(hideBackBtn) forControlEvents:UIControlEventTouchUpInside];

    //添加底部按钮之间线
    UIView *lineView=[[UIView alloc]init];
    lineView.frame=CGRectMake(backBtn.frame.size.width-0.2, 0, 0.5, backBtn.frame.size.height);
    lineView.backgroundColor=[UIColor blackColor];
    lineView.alpha=0.2;
    [backBtn addSubview:lineView];
    self.backBtn=backBtn;
    [bottomView addSubview:backBtn];
    
    
    
    //创建显示所有按钮的View
    UIView *mainView=[[UIView alloc]init];
     self.mainView=mainView;
    UISwipeGestureRecognizer *viewSwipeGesture=[[UISwipeGestureRecognizer  alloc]initWithTarget:self action:@selector(handleMainViewSwipeGesture:)];
    viewSwipeGesture.delegate=self;
    [self.mainView addGestureRecognizer:viewSwipeGesture];
    
    //控制器view添加手势
    [self.view addGestureRecognizer:[[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(handleMainViewTapGesture:)]];
    [self.view addGestureRecognizer:viewSwipeGesture];
    
    //创建12个按钮
    [self setupButtons];
    
}
//创建12个按钮

-(void)setupButtons
{
    //创建12个button,及设置数据
    NSArray *arr= [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"addText" ofType:@"plist"]];
    NSArray *arrPic= [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"addPic" ofType:@"plist"]];
    self.myArr=arr;
    for (int i=0; i<12; i++) {
        LSAddButton *btn=[[LSAddButton alloc]init];
        [btn addGestureRecognizer:[[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(handleTapGesture:)]];
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
        btn.tag=i;
        [btn addGestureRecognizer:longPress];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setImage: [UIImage imageNamed: arrPic[i]] forState:UIControlStateNormal];
        
        //        btn.backgroundColor=[UIColor blueColor];
        btn.titleLabel.font=TitleFont;
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.mainView  addSubview:btn];
    }
//    [self.view addSubview:self.mainView];
    
    CGFloat btnX,btnY,btnW,btnH;
    btnW=ButtonW;
    btnH=ButtonH;
    CGFloat margin =(LSScreenWidth-3*ButtonW)/4.0;
    
    //设置子控件frame
    for (int i=0; i<6; i++) {
        btnX=margin+(ButtonW+margin)*(i%3);
        btnY=(ButtonH+30)*(i/3);
       self.mainView.subviews[i].frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
    for (int i=6; i<12; i++) {
        int num=i-6;
        btnX=LSScreenWidth+ margin+(ButtonW+margin)*(num%3);
        btnY=(ButtonH+30)*(num/3);
        self.mainView.subviews[i].frame=CGRectMake(btnX, btnY, btnW, btnH);
    }

}

//12个button长按手势
-(void)handleLongPressGesture:(UILongPressGestureRecognizer*)longPress
{
    UIButton *touchView=(UIButton*)[longPress view];
    CGRect rect=touchView.frame;
    if (longPress.state==UIGestureRecognizerStateBegan) {
        NSLog(@"handleLongPressGestureBegan");
        self.ogiginalRect =touchView.frame;
        touchView.titleLabel.font=TitleBigFont;
        rect.size.width+=20;
        rect.size.height+=10;
        rect.origin.x-=10;
        rect.origin.y-=20;
       
    }
    else if(longPress.state==UIGestureRecognizerStateEnded)
    {
        NSLog(@"handleLongPressGestureend");
        rect=self.ogiginalRect;
    }
    [UIView animateWithDuration:0.2 animations:^{
        touchView.titleLabel.font=TitleFont;
        touchView.frame=rect;
    }];
    
}
//12个button单击手势
-(void)handleTapGesture:(UITapGestureRecognizer*)tap
{
    NSLog(@"handleTapGesture");
    UIView *touchView=[tap view];
    int number=touchView.tag;
    switch (number) {
        case LSButtonTypeMore:
        {
            [UIView animateWithDuration:0.5 animations:^{
                CGFloat w=[ UIScreen mainScreen].bounds.size.width;
                CGRect rect=self.mainView.frame;
                [UIView animateWithDuration:0.5 animations:^{
                    self.mainView.frame=CGRectMake(-w, rect.origin.y , rect.size.width  , rect.size.height);
                } completion:^(BOOL finished) {
                    
                }];
                
            }];
            self.backBtn.hidden=NO;
            CGRect rect=self.backBtn.frame;
            rect.origin.x+=rect.size.width;
            self.cancleBtn.frame=rect;
        }
            break;
            case LSButtonTypeCompose:
            [ self openComposeController];
        default:
            
            break;
    }
}
//打开发微博控制器
-(void)openComposeController
{

    LSComposeController *compose=[[LSComposeController alloc]init];
    LSNavigationController *nav=[[LSNavigationController alloc]initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
    
}

//控制器view单击手势
-(void)handleMainViewTapGesture:(UISwipeGestureRecognizer*)gesture
{
    NSLog(@"单击");

    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect=self.mainView.frame;
        CGFloat h=[ UIScreen mainScreen].bounds.size.height;
        self.mainView.frame=CGRectMake(rect.origin.x, h, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        self.tabBarController.selectedIndex=self.tabBarController.tabBar.tag;
        self.tabBarController.tabBar.hidden=NO;
        self.backBtn.hidden=YES;
        self.cancleBtn.frame=CGRectMake(0, 0, self.backBtn.frame.size.width*2, self.backBtn.frame.size.height);
        
    }];
    
}
//存放12个按钮view滑动手势
-(void)handleMainViewSwipeGesture:(UISwipeGestureRecognizer*)gesture
{

    if (self.mainView.frame.origin.x<0) {
        CGRect rect=self.mainView.frame;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.mainView.frame=CGRectMake(0, rect.origin.y , rect.size.width  , rect.size.height);
            NSLog(@"轻扫");
        } completion:^(BOOL finished) {
            
        }];
        //隐藏返回按钮
        self.backBtn.hidden=YES;
        self.cancleBtn.frame=CGRectMake(0, 0, self.backBtn.frame.size.width*2, self.backBtn.frame.size.height);
        
    }
}
//隐藏返回按钮
-(void)hideBackBtn
{
    //隐藏返回按钮
    self.backBtn.hidden=YES;
    self.cancleBtn.frame=CGRectMake(0, 0, self.backBtn.frame.size.width*2, self.backBtn.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect=self.mainView.frame;
        self.mainView.frame=CGRectMake(0, rect.origin.y , rect.size.width  , rect.size.height);
//        NSLog(@"轻扫");
    } completion:^(BOOL finished) {
        
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    CGFloat w=[ UIScreen mainScreen].bounds.size.width;
    CGFloat h=[ UIScreen mainScreen].bounds.size.height;
    CGFloat mainY=h-BottomHeight-100-MainViewHeight;
    self.mainView.frame=CGRectMake(0, h, 2*w, MainViewHeight);
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame=CGRectMake(0, mainY, 2*w, MainViewHeight);
    }];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}
//取消按钮
-(void)close
{
    [self handleMainViewTapGesture:nil];
}

@end
