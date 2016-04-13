

//
//  LSTarBarController.m
//  新浪微博
//
//  Created by song on 15/9/19.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSTabBar.h"
#import "LSTarBarController.h"

#import "KVNProgress.h"
#import "LSAddButton.h"
#import "LSAddController.h"
#import "LSAddView.h"
#import "LSComposeController.h"
#import "LSDiscoverController.h"
#import "LSHomeController.h"
#import "LSMessageController.h"
#import "LSNavigationController.h"
#import "LSNavigationController.h"
#import "LSProfileController.h"
#import "LSUnreadResult.h"
#import "LSUserTool.h"
#define BottomHeight 49
#define MainViewHeight 230
#define ButtonW 71
#define ButtonH 100
#define TitleFont [UIFont systemFontOfSize:16]
#define TitleBigFont [UIFont systemFontOfSize:18]
typedef enum {
    LSButtonTypeCompose,
    LSButtonTypeMore = 5
} LSButtonType;
@interface LSTarBarController () <LSTabBarDelegate, UIGestureRecognizerDelegate, UITabBarControllerDelegate>
@property (nonatomic, weak) LSNavigationController* home;
@property (nonatomic, weak) UINavigationController* message;
@property (nonatomic, weak) UINavigationController* discover;
@property (nonatomic, weak) UINavigationController* profile;
@property (nonatomic, weak) UIView* mainView;
@property (nonatomic, assign) CGRect ogiginalRect;

@property (nonatomic, weak) UIButton* backBtn;
@property (nonatomic, weak) UIButton* cancleBtn;
@property (nonatomic, strong) NSArray* myArr;
@property (nonatomic, strong) UIView* keyView;
@property (nonatomic, weak) UINavigationController* lastViewController;
@end

@implementation LSTarBarController

//-(UIView *)keyView
//{
//    if (_keyView==nil) {
//        _keyView=[[LSView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//        _keyView.backgroundColor=[UIColor colorWithWhite:0.8 alpha:1];
//
//    }
//    return _keyView;
//}
- (void)viewDidLoad
{
    [super viewDidLoad];

    //自定义tabbar
    LSTabBar* tabBar = [[LSTabBar alloc] init];
    tabBar.myDelegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    //加载所有控制器
    [self setupControllers];

    //注册修该number通知
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    //创建定时器定时获取未读数量
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    UIBackgroundTaskIdentifier* task = [[UIApplication sharedApplication] beginBackgroundTaskWithName:nil expirationHandler:^{
        //       task en

    }];
    self.delegate = self;
    self.lastViewController = self.home;
}

- (void)getUnreadCount
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [LSUserTool getUnreadCountSuccess:^(LSUnreadResult* result) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        }
        else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        }
        else {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        }
        else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }

        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        NSLog(@"未读总数==%d", result.totalCount);

    }
        failure:^(NSError* error){

        }];
}
//加载所有控制器
- (void)setupControllers
{
    //设置选中状态时字体颜色
    NSDictionary* dict2 = @{ NSForegroundColorAttributeName : [UIColor orangeColor] };
    //设置默认状态时字体颜色
    NSDictionary* dict3 = @{ NSForegroundColorAttributeName : [UIColor whiteColor] };
    
    
    //首页
    LSHomeController* home = [[LSHomeController alloc] init];
    LSNavigationController* item1 = [[LSNavigationController alloc] initWithRootViewController:home];
    item1.tabBarItem.image = [UIImage imageWithOriginalName:@"tabbar_home"];
    //解决图片被渲染成蓝色 这样会不被渲染
    item1.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [item1.tabBarItem setTitleTextAttributes:dict2 forState:UIControlStateSelected];
    item1.tabBarItem.title = @"首页";
    self.home = item1;

    //消息
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MessageAndFriend" bundle:nil];
    LSNavigationController* item2 = [storyBoard instantiateInitialViewController];
    item2.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_message_center_selected"];
    item2.tabBarItem.image = [UIImage imageWithOriginalName:@"tabbar_message_center"];
    [item2.tabBarItem setTitleTextAttributes:dict2 forState:UIControlStateSelected];
    item2.tabBarItem.title = @"消息";
    self.message = item2;
    

    //    发现
    LSDiscoverController* discover = [[LSDiscoverController alloc] init];
    LSNavigationController* item4 = [[LSNavigationController alloc] initWithRootViewController:discover];
    item4.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_discover_selected"];
    item4.tabBarItem.image = [UIImage imageWithOriginalName:@"tabbar_discover"];
    [item4.tabBarItem setTitleTextAttributes:dict2 forState:UIControlStateSelected];
    item4.tabBarItem.title = @"发现";

    self.discover = item4;
    
    //    我
    LSProfileController* profile = [[LSProfileController alloc] init];
    LSNavigationController* item5 = [[LSNavigationController alloc] initWithRootViewController:profile];
    item5.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tabbar_profile_selected"];
    item5.tabBarItem.image = [UIImage imageWithOriginalName:@"tabbar_profile"];
    [item5.tabBarItem setTitleTextAttributes:dict2 forState:UIControlStateSelected];
    item5.tabBarItem.title = @"我";
    self.profile = item5;

    self.viewControllers = @[ item1, item2, item4, item5 ];
}
//创建背景大view
- (void)settingMainView
{

    UIView* keyView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    keyView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [LSKeyWindow addSubview:keyView];
    self.keyView = keyView;
    //添加底部白条(存放两个按钮)
    UIView* bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
    bottomView.frame = CGRectMake(0, LSScreenHeight - BottomHeight, LSScreenWidth, BottomHeight);

    //添加底部关闭按钮
    UIButton* cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.adjustsImageWhenHighlighted = NO;
    cancleBtn.frame = bottomView.bounds;
    [bottomView addSubview:cancleBtn];
    [cancleBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.cancleBtn = cancleBtn;
    [self.keyView addSubview:bottomView];

    //添加底部返回按钮
    UIButton* backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, LSScreenWidth / 2.0, bottomView.frame.size.height);
    backBtn.hidden = YES;
    [backBtn addTarget:self action:@selector(hideBackBtn) forControlEvents:UIControlEventTouchUpInside];

    //添加底部按钮之间线
    UIView* lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(backBtn.frame.size.width - 0.2, 0, 0.5, backBtn.frame.size.height);
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.2;
    [backBtn addSubview:lineView];
    self.backBtn = backBtn;
    [bottomView addSubview:backBtn];

    //创建显示所有12个按钮的View
    UIView* mainView = [[UIView alloc] init];
    mainView.x = 0;
    mainView.width = 2 * LSScreenWidth;
    mainView.height = MainViewHeight;
    mainView.y = LSScreenHeight - BottomHeight - mainView.height - 60;
    //    mainView.backgroundColor=[UIColor redColor];
    [self.keyView addSubview:mainView];
    self.mainView = mainView;

    //大keyView添加滑动手势
    UISwipeGestureRecognizer* viewSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleKeyViewSwipeGesture:)];
    viewSwipeGesture.delegate = self;
    [self.keyView addGestureRecognizer:viewSwipeGesture];

    //大keyView添加单击手势
    [self.keyView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleKeyViewTapGesture:)]];

    //创建12个按钮
    [self setupButtons];
}
//创建12个按钮

- (void)setupButtons
{
    //创建12个button,及设置数据
    NSArray* arr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"addText" ofType:@"plist"]];
    NSArray* arrPic = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"addPic" ofType:@"plist"]];
    self.myArr = arr;
    for (int i = 0; i < 10; i++) {
        LSAddButton* btn = [[LSAddButton alloc] init];
        [btn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
        UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
        btn.tag = i;
        [btn addGestureRecognizer:longPress];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:arrPic[i]] forState:UIControlStateNormal];

        //        btn.backgroundColor=[UIColor blueColor];
        btn.titleLabel.font = TitleFont;

        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.mainView addSubview:btn];
    }

    CGFloat btnX, btnY, btnW, btnH;
    btnW = ButtonW;
    btnH = ButtonH;
    CGFloat margin = (LSScreenWidth - 3 * ButtonW) / 4.0;

    //设置子控件frame
    for (int i = 0; i < 6; i++) {
        btnX = margin + (ButtonW + margin) * (i % 3);
        btnY = (ButtonH + 30) * (i / 3);
        self.mainView.subviews[i].frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    for (int i = 6; i < 10; i++) {
        int num = i - 6;
        btnX = LSScreenWidth + margin + (ButtonW + margin) * (num % 3);
        btnY = (ButtonH + 30) * (num / 3);
        self.mainView.subviews[i].frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

//12个button长按手势
- (void)handleLongPressGesture:(UILongPressGestureRecognizer*)longPress
{
    UIButton* touchView = (UIButton*)[longPress view];
    CGRect rect = touchView.frame;
    if (longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"handleLongPressGestureBegan");
        self.ogiginalRect = touchView.frame;
        rect.size.width += 20;
        rect.size.height += 10;
        rect.origin.x -= 10;
        rect.origin.y -= 20;
    }
    else if (longPress.state == UIGestureRecognizerStateEnded) {
        NSLog(@"handleLongPressGestureend");
        rect = self.ogiginalRect;
    }
    [UIView animateWithDuration:0.2 animations:^{
        touchView.frame = rect;
    }];
}
//12个button单击手势
- (void)handleTapGesture:(UITapGestureRecognizer*)tap
{
    NSLog(@"handleTapGesture");
    UIView* touchView = [tap view];
    int number = touchView.tag;
    switch (number) {
    case LSButtonTypeMore: {
        [UIView animateWithDuration:0.5 animations:^{
            CGFloat w = [UIScreen mainScreen].bounds.size.width;
            CGRect rect = self.mainView.frame;
            [UIView animateWithDuration:0.5 animations:^{
                self.mainView.frame = CGRectMake(-w, rect.origin.y, rect.size.width, rect.size.height);
            }
                completion:^(BOOL finished){

                }];

        }];
        self.backBtn.hidden = NO;
        CGRect rect = self.backBtn.frame;
        rect.origin.x += rect.size.width;
        self.cancleBtn.frame = rect;
    } break;
    case LSButtonTypeCompose:
        [self openComposeController];

    default:

        break;
    }
}

//控制器view单击手势
- (void)handleKeyViewTapGesture:(UISwipeGestureRecognizer*)gesture
{
    NSLog(@"单击");

    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.mainView.frame;
        CGFloat h = [UIScreen mainScreen].bounds.size.height;
        self.mainView.frame = CGRectMake(rect.origin.x, h, rect.size.width, rect.size.height);
    }
        completion:^(BOOL finished) {
            NSLog(@"%@", self.keyView);
            [self.keyView removeFromSuperview];
        }];
}
//存放12个按钮view滑动手势
- (void)handleKeyViewSwipeGesture:(UISwipeGestureRecognizer*)gesture
{
    LSLog(@"keyView轻扫");
    if (self.mainView.frame.origin.x < 0) {
        CGRect rect = self.mainView.frame;
        [UIView animateWithDuration:0.5 animations:^{

            self.mainView.frame = CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height);

        }
            completion:^(BOOL finished){

            }];
        //隐藏返回按钮
        self.backBtn.hidden = YES;
        self.cancleBtn.frame = CGRectMake(0, 0, self.backBtn.frame.size.width * 2, self.backBtn.frame.size.height);
    }
}
//隐藏返回按钮
- (void)hideBackBtn
{
    //隐藏返回按钮
    self.backBtn.hidden = YES;
    self.cancleBtn.frame = CGRectMake(0, 0, self.backBtn.frame.size.width * 2, self.backBtn.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect = self.mainView.frame;
        self.mainView.frame = CGRectMake(0, rect.origin.y, rect.size.width, rect.size.height);
        //        NSLog(@"轻扫");
    }
        completion:^(BOOL finished){

        }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch
{
    return YES;
}
//取消按钮
- (void)close
{
    [self handleKeyViewTapGesture:nil];
}
#pragma mark - TabBarDelegate
- (void)tabBarClick:(LSTabBar*)tabBar
{
    [self settingMainView];

    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    //    CGFloat mainY=h-BottomHeight-100-MainViewHeight;
    self.mainView.frame = CGRectMake(0, LSScreenHeight, 2 * w, MainViewHeight);
    [UIView animateWithDuration:0.5 animations:^{
        self.mainView.frame = CGRectMake(0, LSScreenHeight - MainViewHeight - BottomHeight - 60, 2 * w, MainViewHeight);

    }];
}

- (void)openComposeController
{
    [self.keyView removeFromSuperview];
    LSComposeController* compose = [[LSComposeController alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UINavigationController*)viewController
{
    UIViewController* vc = [viewController.viewControllers firstObject];
    if ([vc isKindOfClass:[LSHomeController class]]) {

        if (self.lastViewController == self.home) {
            LSHomeController* home = vc;
            [home refresh];
        }
    }

    self.lastViewController = viewController;
    ;
}
@end
