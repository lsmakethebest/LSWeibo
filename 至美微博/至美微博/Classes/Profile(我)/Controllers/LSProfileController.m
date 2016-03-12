


//
//  LSProfileController.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSProfileController.h"
#import "LSSettingController.h"
#import "LSProfileHeaderCell.h"
#import "LSProfileButtonView.h"

@interface LSProfileController ()

@end

@implementation LSProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我";
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(gotoSetting)];
    self.navigationItem.rightBarButtonItem = right;
    self.view.backgroundColor=LSGlobalColor;
  
}
-(void)gotoSetting
{
    LSSettingController *vc=[[LSSettingController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSProfileHeaderCell *cell=[LSProfileHeaderCell profileHeaderCellWithTableView:tableView];
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.tabBarController.tabBar.hidden=NO;
    [super viewWillAppear:animated];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return [LSProfileHeaderCell cellHeight];
    }else {
    return 44;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0) {
        LSProfileButtonView *view=[LSProfileButtonView profileButtonView];

        view.width=LSScreenWidth;
        view.height=84;
        NSLog(@"%@",view);
        return view;
    }else{
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [LSProfileButtonView height];
}
//-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @"a";
//}
@end
