




//
//  LSDetailsController.m
//  至美微博
//
//  Created by song on 15/10/10.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSDetailsController.h"
#import "LSSendCommentViewController.h"
#import "LSStatusDetailsFrame.h"
#import "LSStatus.h"
#import "LSCommentTool.h"
#import "LSComment.h"
#import "LSCommentFrame.h"
#import "LSCommentCell.h"
#import "LSSectionView.h"
#import "LSRepostTool.h"
#import "LSToolBar.h"
#import "LSStatusFrame.h"
#import "LSStatusCell.h"
#import "LSRepostStatusController.h"
#import "LSUser.h"
#import "MJRefresh.h"
@interface LSDetailsController ()<LSSectionViewDelegate,LSToolBarDelegate,UITableViewDataSource,UITableViewDelegate>
//转发数组
@property (nonatomic, strong) NSMutableArray *reposts;
//评论数组
@property (nonatomic, strong) NSMutableArray *comments;
//赞数组
@property (nonatomic, strong) NSMutableArray *unlikes;
//footerView提示没有评论
@property (nonatomic, strong) UILabel *footerView;
//组view显示3个按钮来切换不同cell列表
@property (nonatomic, strong) LSSectionView  *sectionView;
@property (nonatomic, weak) UITableView *myTableView;


//toolbar
@property (nonatomic, weak) LSToolBar *toolBar;
@end
@implementation LSDetailsController

//懒加载sectionView
-(UIView *)sectionView
{
    if (!_sectionView) {
        _sectionView=[[LSSectionView alloc]initWithFrame:CGRectMake(0, 0, LSScreenWidth, 35)];
        _sectionView.status=self.statusFrame.status;
        _sectionView.delegate=self;
    }
    return _sectionView;
}
//懒加载footerView
-(UILabel *)footerView
{
    if (!_footerView) {
        _footerView=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, LSScreenWidth, 100)];
        _footerView.text=@"没有评论哦...";
        _footerView.backgroundColor=[UIColor whiteColor];
        _footerView.textColor=[UIColor colorWithWhite:0.5 alpha:0.5];
        _footerView.textAlignment=NSTextAlignmentCenter;
    }
    return _footerView;
}
-(NSMutableArray *)comments
{
    if (!_comments) {
        
        _comments=[NSMutableArray array];
    }
    return _comments;
}
-(NSMutableArray *)reposts
{
    if (!_reposts) {
        
        _reposts=[NSMutableArray array];
    }
    return _reposts;
}
-(NSMutableArray *)unlikes
{
    if (!_unlikes) {
        
        _unlikes=[NSMutableArray array];
    }
    return _unlikes;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    [self.view addSubview:tableView];
    self.myTableView=tableView;
    tableView.width=self.view.width;
    self.myTableView.height=self.view.height-44;
//    self.myTableView.backgroundColor=[UIColor clearColor];
//    self.view.backgroundColor=[UIColor redColor];
    self.myTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.title=@"微博正文";
//    self.myTableView.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1.0];
    self.view.backgroundColor=[UIColor colorWithWhite:0.9 alpha:1.0];
    
    
    //头部视图
    LSStatusCell *headerView=[LSStatusCell statusCellWithTableView:self.myTableView];
    headerView.statusFrame=self.statusFrame;
    headerView.height=self.statusFrame.cellHeight;
    self.myTableView.tableHeaderView=headerView;
    
    //网导航控制器view添加底部toolBar
    [self setupToolBar];
    
    //添加头部刷新控件
    [self.myTableView addHeaderWithTarget:self action:@selector(loadNewData)];
    
    //添加尾部刷新控件
    [self.myTableView addFooterWithTarget:self action:@selector(loadMoreData)];
    
    
    
}
-(void)loadMoreData
{
    switch (self.sectionView.selectdButtonType) {
        case LSButttonTypeComment:
            [self loadMoreCommnet];
            break;
            
        case LSButttonTypeRepost:
            [self loadRepost];
            [self.myTableView footerEndRefreshing];
            break;
        case LSButttonTypeUnlike:
            [self.myTableView footerEndRefreshing];
            break;
        default:
            break;
    }

    
}
-(void)loadMoreCommnet
{
    LSCommentFrame *frame= [self.comments lastObject];
    long long max=frame.comment.idstr.longLongValue-1;
    NSString *maxId=[NSString stringWithFormat:@"%lld",max];
    
    [LSCommentTool loadMoreCommentWithId:_statusFrame.status.idstr maxId:maxId success:^(LSCommentResult *result) {
        //存放所有frame模型的数组
        NSMutableArray *arrF=[NSMutableArray array];
        for (LSComment *comment in result.comments) {
            LSCommentFrame *commentFrame=[[LSCommentFrame alloc]init];
            commentFrame.comment=comment;
            [arrF addObject:commentFrame];
        }
        [self.comments addObjectsFromArray:arrF];
        self.statusFrame.status.comments_count=result.total_number.intValue;
        self.sectionView.status=self.statusFrame.status;
        [self.myTableView reloadData];
        [self.myTableView footerEndRefreshing];
        NSLog(@"获取更多评论成功");
    } failure:^(NSError *error) {
        NSLog(@"获取更多评论失败");
                [self.myTableView footerEndRefreshing];
        
    }];
    
}

-(void)loadNewData
{
    switch (self.sectionView.selectdButtonType) {
        case LSButttonTypeComment:
            [self loadComment];
            break;
            
        case LSButttonTypeRepost:
            [self loadRepost];
            break;
        case LSButttonTypeUnlike:
            break;
        default:
            break;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    switch (self.sectionView.selectdButtonType) {
        case LSButttonTypeRepost:
            return self.reposts.count;
            break;
            case LSButttonTypeComment:
            return self.comments.count;
            case LSButttonTypeUnlike:
            return self.unlikes.count;
        default:
            break;
    }
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (self.sectionView.selectdButtonType) {
        case LSButttonTypeRepost:
        {
            LSCommentCell *cell=[LSCommentCell commentCellWithTableView:tableView];
            LSCommentFrame *commentFrame=self.reposts[indexPath.row];
            cell.commentFrame=commentFrame;
            return cell;
            
        }
            break;
            
        case LSButttonTypeComment:
        {
            LSCommentCell *cell=[LSCommentCell commentCellWithTableView:tableView];
            LSCommentFrame *commentFrame=self.comments[indexPath.row];
            cell.commentFrame=commentFrame;
            return cell;
            
        }
            break;
        case LSButttonTypeUnlike:
        {
            
            UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"unlike"];
            cell.textLabel.text=self.unlikes[indexPath.row];
            return cell;
            
        }
            break;
        default:
            break;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.sectionView.selectdButtonType) {
        case LSButttonTypeRepost:
        {
            LSCommentFrame *commentFrame=self.reposts[indexPath.row];
            
            return commentFrame.cellHeight;
        }
            break;
        case LSButttonTypeComment:
        {
            LSCommentFrame *commentFrame=self.comments[indexPath.row];
            
            return commentFrame.cellHeight;
        }
            break;
        case LSButttonTypeUnlike:
        {
            return 44;
        }
            break;
            
        default:
            break;
    }
    return 0;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return self.sectionView;
    }else{
        return nil;
    }
}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"ghjhjk";
//}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
#pragma mark - LSSectionViewDelegate
-(void)sectionView:(LSSectionView *)sectionView buttonType:(LSButttonType)type
{
    [self.myTableView reloadData];
    switch (type) {
        case LSButttonTypeRepost:
//            self.footerView.text=@"还没有人转发哦...";
            [self loadRepost];
            break;
            
        case LSButttonTypeComment:
            [self loadComment];
//            self.footerView.text=@"还没有人评论哦...";
            break;
        case LSButttonTypeUnlike:
            [self loadUnlike];
//            self.footerView.text=@"还没有人赞哦...";
            break;
        default:
            break;
    }
    
}

//获取评论
-(void)loadComment
{
    LSCommentFrame *frame= [self.comments firstObject];
    NSString *since_id=frame.comment.idstr;
    [LSCommentTool loadNewCommentWithId:_statusFrame.status.idstr sinceId:since_id success:^(LSCommentResult *result) {
        
        //存放所有frame模型的数组
        NSMutableArray *arrF=[NSMutableArray array];
        for (LSComment *comment in result.comments) {
            LSCommentFrame *commentFrame=[[LSCommentFrame alloc]init];
            commentFrame.comment=comment;
            [arrF addObject:commentFrame];
        }
        NSRange range=NSMakeRange(0, arrF.count);
        [self.comments insertObjects:arrF atIndexes: [NSIndexSet indexSetWithIndexesInRange:range]];
        self.statusFrame.status.comments_count=result.total_number.intValue;
        self.sectionView.status=self.statusFrame.status;
        [self.myTableView reloadData];
        [self.myTableView headerEndRefreshing];
        NSLog(@"获取评论成功");
    } failure:^(NSError *error) {
        NSLog(@"获取评论失败");
        
    }];
    
}

//获取转发
-(void)loadRepost
{
    [LSRepostTool loadNewRepostWithId:self.statusFrame.status.idstr sinceId:nil success:^(LSRepostResult *result) {
        NSLog(@"totalnumber==%@",result.total_number);
        NSLog(@"获取转发成功");
    } failure:^(NSError *error) {
        NSLog(@"获取转发失败");
    }];
    

}
//获取赞
-(void)loadUnlike
{
    
}
-(void)setupToolBar
{
    CGFloat h=44;
    LSToolBar *toolBar=[[LSToolBar alloc]initWithFrame:CGRectMake(0,  LSScreenHeight-h+2, LSScreenWidth, h)];
    toolBar.delegate=self;
    [self.view addSubview:toolBar];
    self.toolBar=toolBar;
}
-(void)toolBar:(LSToolBar *)toolBar buttonType:(LSToolBarButtonType)type
{
    switch (type) {
        case LSToolBarButtonTypeComment:
            [self sendComment];
            break;
            case LSToolBarButtonTypeRepost:
            [self repostStatus];
            break;
            case LSToolBarButtonTypeUnlike:
            [self sendLike];
            break;
        default:
            break;
    }
}
-(void)sendComment
{
    LSSendCommentViewController *vc=[[LSSendCommentViewController alloc]init];
    vc.statusId=self.statusFrame.status.idstr;
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)repostStatus
{
    LSRepostStatusController *vc=[[LSRepostStatusController alloc]init];
    vc.statusId=self.statusFrame.status.idstr;
    if (self.statusFrame.status.retweeted_status) {
        vc.defaultText= [NSString stringWithFormat:@"//@%@:%@",self.statusFrame.status.user.name,self.statusFrame.status.text];
    }
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    
}
-(void)sendLike
{
    
}
@end
