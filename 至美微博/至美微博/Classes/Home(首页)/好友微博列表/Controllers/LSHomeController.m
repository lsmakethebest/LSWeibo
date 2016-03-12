//
//  LSHomeController.m
//  新浪微博
//
//  Created by song on 15/9/18.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSHomeController.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
#import "AFNetworking.h"
#import "LSStatus.h"
#import "LSUser.h"
#import "LSPhoto.h"
#import "LSTitleButton.h"
#import "LSCover.h"
#import "LSPopMenu.h"
#import "LSContentController.h"
#import "MJRefresh.h"
#import "LSHttpTool.h"
#import "LSUserTool.h"
#import "LSStatusTool.h"
#import "LSStatusFrame.h"
#import "LSStatusCell.h"
#import "LSTarBarController.h"
#import "LSDetailsController.h"
#import "LSStatusDetailsFrame.h"
#import "LSToolBar.h"
#import "LSUserTool.h"
#import "LSSendCommentViewController.h"
#import "LSRepostStatusController.h"
@interface LSHomeController ()<LSCoverDelegate,LSStatusCellDelegate>

@property (nonatomic, weak) LSTitleButton *titleButton;
@property (nonatomic, strong) NSMutableArray *statuses;

@property (nonatomic, strong) LSContentController *contentController;
@end

@implementation LSHomeController
-(LSContentController *)contentController
{
    if (_contentController==nil) {
        _contentController=[[LSContentController alloc]init];
    }
    return _contentController;
}
-(NSMutableArray *)statuses
{
    if (_statuses==nil) {
        _statuses=[NSMutableArray array];
    }
    return _statuses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //监听选中链接通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedLink:) name:LSSelectedLink object:nil];

    
    //取消分割线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //    self.tableView.backgroundColor=[UIColor lightGrayColor];
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatuses)];
    //    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    [self setupNavigationBar];
    //监控网络状态
    [self startMonitor];
}
-(void)selectedLink:(NSNotification*)note
{
    NSLog(@"%@",note.userInfo[LSSelectedLinkKey]);
}
//监控网络状态
-(void)startMonitor
{
    AFNetworkReachabilityManager *manger= [AFNetworkReachabilityManager sharedManager];
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"AFNetworkReachabilityStatusNotReachable");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachabilityStatusReachableViaWWAN");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"AFNetworkReachabilityStatusUnknown");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"AFNetworkReachabilityStatusReachableViaWiFi");
                break;
                
                
            default:
                break;
        }
    }];
    
    [manger startMonitoring];
    
    
}
//加载导航栏
-(void)setupNavigationBar
{
    LSTitleButton *titleButton= [[LSTitleButton alloc]init];
    titleButton.frame=CGRectMake(0, 0, 10, 40);;
    self.navigationItem.titleView=titleButton;
    [titleButton setTitle:[LSAccountTool currentAccount].name?[LSAccountTool currentAccount].name:@"首页" forState:UIControlStateNormal];
    
    [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.titleButton=titleButton;
#pragma mark  - warning
    //判断是否获取过用户信息
    if ([LSAccountTool currentAccount].name==nil) {
        
        [LSUserTool userInfoWithAccessToken:[LSAccountTool currentAccount].access_token success:^(LSUser *user) {
            [titleButton setTitle:user.name forState:UIControlStateNormal];
            LSAccount *account= [LSAccountTool currentAccount];
            account.name=user.name;
            account.profile_url=user.profile_image_url.absoluteString;
            [[LSAccountTool accountTool] updateAccount:account];
        } failure:^(NSError *error) {
            NSLog(@"获取user失败%@",error);
        }];
    }
    
}
//导航栏中间按钮点击事件
-(void)titleButtonClick:(LSTitleButton*)button
{
    button.selected=YES;
    LSCover *cover=[LSCover show];
    cover.delegate=self;
    
    CGFloat popMenuX,popMenuY,popMenuW,popMenuH;
    popMenuW=200;
    popMenuY=55;
    popMenuH=205;
    popMenuX=(self.tableView.width-popMenuW)*0.5;
    LSPopMenu *popMenu= [LSPopMenu showInRect:CGRectMake(popMenuX,popMenuY,popMenuW,popMenuH)];
    popMenu.conntentView=self.contentController.view;
    //
    
}
//加载新的微博数据
-(void)loadNewStatuses
{
    
    LSStatusFrame *tempStatusFrame=[self.statuses firstObject];
    LSStatus *tempStatus=tempStatusFrame.status;
    //    NSLog(@"idstr====%@",tempStatus.idstr);
    [LSStatusTool loadNewStatusWithSinceId:tempStatus.idstr maxId:nil success:^(NSArray *statuses) {
        
        NSMutableArray *statusF=[NSMutableArray array];
        for (LSStatus* status in statuses) {
            LSStatusFrame *statusFrame=[[LSStatusFrame alloc]init];
            statusFrame.status=status;
            [statusF addObject:statusFrame];
        }
        
        [self.statuses insertObjects:statusF atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,statusF.count) ]];
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
        [self showNumber:statusF.count];
//        NSLog(@"statusFCOUNT==%d",statusF.count);
        
    } failure:^(NSError *error) {
        [self.tableView headerEndRefreshing];
        NSLog(@"加载新数据失败%@",error);
    }];
    
}
//提示更新了多少条新数据
-(void)showNumber:(NSInteger)count
{
    
    if (count==0) return;
    
    CGFloat x,y,w,h;
    w=self.view.width;
    h=33;
    x=0;
    y= CGRectGetMaxY (self.navigationController.navigationBar.frame)-h;
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(x,y, w, h)];
    label.textAlignment=NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont systemFontOfSize:12];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    label.text=[NSString stringWithFormat:@"加载了%d条新数据",count];
    label.backgroundColor=[UIColor colorWithPatternImage:[UIImage  imageNamed:@"timeline_new_status_background"]];
    //显示动画
    CGFloat duration=1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform=CGAffineTransformMakeTranslation(0, h);
    }];
    
    [UIView animateKeyframesWithDuration:duration delay:2 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        label.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}
//加载更多旧数据
-(void)loadMoreStatus
{
    NSString *maxId=nil;
    if (self.statuses.count) {
        LSStatusFrame *tempStatusFrame=[self.statuses lastObject];
        LSStatus *tempStatus=tempStatusFrame.status;
        long long maxID=[tempStatus.idstr longLongValue] -1;
        maxId=[NSString stringWithFormat:@"%lld",maxID];
    }
    [LSStatusTool loadNewStatusWithSinceId:nil maxId:maxId success:^(NSArray *statuses) {
        NSMutableArray *statusF=[NSMutableArray array];
        for (LSStatus* status in statuses) {
            LSStatusFrame *statusFrame=[[LSStatusFrame alloc]init];
            statusFrame.status=status;
            [statusF addObject:statusFrame];
        }
        [self.statuses addObjectsFromArray:statusF];
        if (statusF.count) {
            [UIApplication sharedApplication].applicationIconBadgeNumber=[UIApplication sharedApplication].applicationIconBadgeNumber-[self.navigationController.tabBarItem.badgeValue intValue];
            self.navigationController.tabBarItem.badgeValue=  nil;
        }
        [self.tableView reloadData];
        [self.tableView footerEndRefreshing];
    } failure:^(NSError *error) {
        [self.tableView footerEndRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.statuses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[LSStatusCell statusCellWithTableView:tableView];
        
        UIView *view_bg = [[UIView alloc]initWithFrame:cell.frame];
        
        view_bg.backgroundColor = [UIColor clearColor];
        //        [cell bringSubviewToFront:cell.backgroundView];
        
        cell.selectedBackgroundView = view_bg;
        cell.delegate=self;
    }
    LSStatusFrame *statusFrame=self.statuses[indexPath.section];
    cell.statusFrame=statusFrame;
    return cell;
}

#pragma mark - LSCoverDelegate
-(void)coverClick:(LSCover *)cover
{
    self.titleButton.selected=NO;
    [LSPopMenu hide];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSStatusFrame *statusFrame=self.statuses[indexPath.section];
    return statusFrame.cellHeight;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController .tabBarController.tabBar.hidden=NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSStatusCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
      LSStatusFrame *statusFrame=self.statuses[indexPath.section];
    if ( cell.isOriginal) {
        
        NSLog(@"row======%ld",(long)indexPath.row);
        LSDetailsController *detailsVC=[[LSDetailsController alloc]init];
        statusFrame.status.detail=YES;
        LSStatusFrame *statusF=[[LSStatusFrame alloc]init];
        statusF.status=statusFrame.status;
        detailsVC.statusFrame=statusF;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }else
    {
        LSDetailsController *detailsVC=[[LSDetailsController alloc]init];
        statusFrame.status.retweeted_status. detail=YES;
        LSStatusFrame *statusF=[[LSStatusFrame alloc]init];
        statusF.status=statusFrame.status.retweeted_status;
        detailsVC.statusFrame=statusF;
        
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
    
}
-(void)statusCell:(LSStatusCell *)statusCell buttonType:(LSToolBarButtonType)type status:(LSStatus *)status
{
    switch (type) {
        case LSToolBarButtonTypeRepost:
            [self repostStatus:status];
            NSLog(@"toolbar转发");
            break;
        case LSToolBarButtonTypeComment:
            [self openComment:status];
            NSLog(@"toolbar评论");
            
            break;
        case LSToolBarButtonTypeUnlike:
            NSLog(@"toolbar赞");
            break;
        default:
            break;
    }
    
}
//转发微博
-(void)repostStatus:(LSStatus*)status
{
    LSRepostStatusController *vc=[[LSRepostStatusController alloc]init];
    vc.statusId=status.idstr;
    
    if (status.retweeted_status) {
        vc.defaultText= [NSString stringWithFormat:@"//@%@:%@",status.user.name,status.text];
    }
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}
-(void)openComment:(LSStatus*)status
{
    
    if (status.comments_count) {//评论人数不为0,进入详情界面
        
        LSDetailsController *detailsVC=[[LSDetailsController alloc]init];
        LSStatusFrame *statusF=[[LSStatusFrame alloc]init];
        status.detail=YES;
        statusF.status=status;
        detailsVC.statusFrame=statusF;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }else{//没有人评论，进入发表评论界面
        LSSendCommentViewController *vc=[[LSSendCommentViewController alloc]init];
        vc.statusId=status.idstr;
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}
-(void)refresh
{
    [self .tableView headerBeginRefreshing];
    [self loadMoreStatus];
    //    if (self.statuses.count) {
    //
    //        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    //    }
    //    if (self.navigationController.tabBarItem.badgeValue) {
    //
    //        [self .tableView headerBeginRefreshing];
    //        [self loadMoreStatus];
    //    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7;
}
-(instancetype)init
{
    if (self=[super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section>=self.statuses.count-2) {
        [self.tableView footerBeginRefreshing];
       
    }

}
@end
