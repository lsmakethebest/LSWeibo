




//
//  LSMessageController.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSMessageController.h"
#import "LSUserTool.h"
#import "LSLikeListResult.h"
#import "LSFriendCell.h"
#import "LSMessageCell.h"
#import "UIImageView+WebCache.h"
@interface LSMessageController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
/**
 *消息tableview
 */
@property (nonatomic, weak) UITableView *messageTableView;
/**
 *好友tableview
 */
@property (nonatomic, weak) UITableView *friendTableView;

/**
 *好友列表数组
 */
@property (nonatomic, strong) NSMutableArray *friends;
/**
 *消息列表数组
 */
//UISegmentedControl点击事件
- (IBAction)segmentClick:(UISegmentedControl*)sender;
@end

@implementation LSMessageController

-(NSMutableArray *)friends
{
    if (_friends==nil) {
        _friends=[NSMutableArray array];
        
    }
    return _friends;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消息";
    //消息tableview
    UITableView *messageTableView=[[UITableView alloc]init];
//    messageTableView.backgroundColor=[UIColor redColor];
    messageTableView.frame=self.view.bounds;
    messageTableView.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);
    
    messageTableView.dataSource=self;
    messageTableView.delegate=self;
    [self.view addSubview:messageTableView];
    self.messageTableView=messageTableView;
    
    //好友tableview
    UITableView *friendTableView=[[UITableView alloc]init];
    friendTableView.frame=self.view.bounds;
    friendTableView.contentInset=UIEdgeInsetsMake(64, 0, 49, 0);
    friendTableView.dataSource=self;
    friendTableView.delegate=self;
    friendTableView.hidden=YES;
    [self.view addSubview:friendTableView];
    self.friendTableView=friendTableView;

    NSLog(@"%@",self.navigationController.tabBarController.tabBar);
    [LSUserTool getLikeListSuccess:^(LSLikeListResult *result) {
        NSLog(@"number====%@",result.total_number);
        [self.friends addObjectsFromArray:result.users];
        [self.friendTableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}



- (IBAction)segmentClick:(UISegmentedControl*)sender {
    NSInteger  index= sender.selectedSegmentIndex;
    if (index==0) {
        self.messageTableView.hidden=NO;
        self.friendTableView.hidden=YES;
    }else{
        self.messageTableView.hidden=YES;
        self.friendTableView.hidden=NO;
        
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.messageTableView) {
        
    }else if (tableView==self.friendTableView){
        return self.friends.count;
    }
    return 0;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.messageTableView) {
        
    }else if (tableView==self.friendTableView){
        
        
        //        LSFriendCell *cell=[LSFriendCell friendCellWithTableView:tableView];
        LSUser *user=self.friends[indexPath.row];
        //        cell.user=user;
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        [cell.imageView setImageWithURL:user.profile_image_url placeholderImage:[UIImage imageNamed:@"icon"]];
        cell.textLabel.text=user.name;
        cell.imageView.layer.cornerRadius=22;
        cell.imageView.clipsToBounds=YES;
        cell.detailTextLabel.text=user.myDdescription;
        return cell;
    }
    return nil;
}


@end
