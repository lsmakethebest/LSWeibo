

//
//  LSSettingController.m
//  至美微博
//
//  Created by song on 15/10/22.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "KVNProgress.h"
#import "LSAccount.h"
#import "LSAccountController.h"
#import "LSAccountTool.h"
#import "LSCommonSettingController.h"
#import "LSExitCell.h"
#import "LSNotificationController.h"
#import "LSOAuthViewController.h"
#import "LSSecurityController.h"
#import "LSSettingArrowItem.h"
#import "LSSettingController.h"
#import "LSSettingItem.h"
#import "LSSettingItemCell.h"
#import "LSSettingItemGroup.h"
#import "LSSettingSwitchItem.h"
#import "NSString+Size.h"
#import "UIImageView+WebCache.h"
@interface LSSettingController ()
@end

@implementation LSSettingController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self group1];
    [self group2];
    [self group3];
}

- (void)group1
{

    LSSettingItemGroup* group1 = [[LSSettingItemGroup alloc] init];
    LSSettingArrowItem* item1 = [LSSettingArrowItem settingItemWithTitle:@"账号管理" subTitle:nil desClass:[LSAccountController class]];
    [group1.items addObject:item1];
    [self.datas addObject:group1];
}
- (void)group2
{
    LSSettingItemGroup* group2 = [[LSSettingItemGroup alloc] init];
    LSSettingArrowItem* item1 = [LSSettingArrowItem settingItemWithTitle:@"通知" subTitle:nil desClass:[LSNotificationController class]];
    LSSettingArrowItem* item2 = [LSSettingArrowItem settingItemWithTitle:@"隐私与安全" subTitle:nil desClass:[LSSecurityController class]];
    LSSettingArrowItem* item3 = [LSSettingArrowItem settingItemWithTitle:@"通用设置" subTitle:nil desClass:[LSCommonSettingController class]];
    [group2.items addObject:item1];
    [group2.items addObject:item2];
    [group2.items addObject:item3];
    [self.datas addObject:group2];
}
- (void)group3
{
    LSSettingItemGroup* group3 = [[LSSettingItemGroup alloc] init];

    NSString* path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    CGFloat maxSize = [path fileSizeWithFilePath];
    __block NSString* subTitle = [NSString stringWithFormat:@"%.1lfM", maxSize];
    subTitle = [subTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];

    LSSettingArrowItem* item1 = [LSSettingArrowItem settingItemWithTitle:@"清理缓存" subTitle:subTitle desClass:nil];
    __weak typeof(item1) itemWeak = item1;
    __weak typeof(self) selfWeak = self;
    item1.option = ^() {
        [KVNProgress showWithStatus:@"正在清除缓存"];
        [[SDImageCache sharedImageCache] clearDisk];
        itemWeak.subTitle = @"0M";
        [selfWeak.tableView reloadData];
        [KVNProgress dismiss];

    };
    LSSettingArrowItem* item2 = [LSSettingArrowItem settingItemWithTitle:@"意见反馈" subTitle:nil desClass:nil];
    LSSettingArrowItem* item3 = [LSSettingArrowItem settingItemWithTitle:@"关于微博" subTitle:nil desClass:nil];
    [group3.items addObject:item1];
    [group3.items addObject:item2];
    [group3.items addObject:item3];
    [self.datas addObject:group3];
}
- (void)clearCaches
{
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.datas.count + 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return 1;
    }
    else {
        LSSettingItemGroup* group = self.datas[section];
        return group.items.count;
    }
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 3) {
        LSExitCell* cell = [LSExitCell exitCell:tableView];
        cell.label.text = @"退出账号";

        return cell;
    }
    else {
        LSSettingItemCell* cell = [LSSettingItemCell settingCellWithTableView:tableView];
        LSSettingItemGroup* group = self.datas[indexPath.section];
        cell.item = group.items[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 3) {
        LSAccount* account = [LSAccountTool currentAccount];
        account.currentAccount = NO;
        [LSAccountTool setCurrentAccount:nil];
        [[LSAccountTool accountTool] updateAccount:account];
        LSKeyWindow.rootViewController = [[LSOAuthViewController alloc] init];
    }
    else {
        LSSettingItemGroup* group = self.datas[indexPath.section];
        LSSettingItem* item = group.items[indexPath.row];
        if (item.option) {
            item.option();
        }
        else if (item.desClass) {

            UIViewController* vc = [[item.desClass alloc] init];
            vc.title = item.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return nil;
    }
    else {
        LSSettingItemGroup* group = self.datas[section];
        return group.headerTitle;
    }
}
- (NSString*)tableView:(UITableView*)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return nil;
    }
    else {
        LSSettingItemGroup* group = self.datas[section];
        return group.footerTitle;
    }
}
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

@end
