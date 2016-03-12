


//
//  LSNotificationController.m
//  至美微博
//
//  Created by song on 15/10/27.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSNotificationController.h"
#import "LSSettingItem.h"
#import "LSSettingItemGroup.h"
#import "LSSettingSwitchItem.h"
#import "LSSettingArrowItem.h"
#import "LSSettingCorrectItem.h"
@interface LSNotificationController ()

@end

@implementation LSNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self group1];
    [self group2];
    [self group3];
    [self group4];
}
-(void)group1
{
    LSSettingItemGroup *group1=[[LSSettingItemGroup alloc]init];
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"接受推送通知" subTitle:@"已开启" desClass:nil];
    group1.footerTitle=@"要开启或关闭微博的推送通知,请在IPhone的”设置中“-”通知“中找到“微博进行设置”";
    [group1.items addObject:item1];
    [self.datas addObject:group1];
}

-(void)group2
{
    
    LSSettingItemGroup *group2=[[LSSettingItemGroup alloc]init];
    group2.headerTitle=@"新消息通知";
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"@我的" subTitle:@"关闭" desClass:nil];
    LSSettingArrowItem *item2=[LSSettingArrowItem settingItemWithTitle:@"@评论" subTitle:@"所有人" desClass:nil];
    LSSettingArrowItem *item3=[LSSettingArrowItem settingItemWithTitle:@"赞" subTitle:nil desClass:nil];
    LSSettingSwitchItem *item4=[LSSettingSwitchItem settingItemWithTitle:@"消息" subTitle:nil desClass:nil];
    LSSettingSwitchItem *item5=[LSSettingSwitchItem settingItemWithTitle:@"群通知" subTitle:nil desClass:nil];
    LSSettingArrowItem *item6=[LSSettingArrowItem settingItemWithTitle:@"未关注人消息" subTitle:@"我关注的人" desClass:nil];
    LSSettingArrowItem *item7=[LSSettingArrowItem settingItemWithTitle:@"新粉丝" subTitle:@"关闭" desClass:nil];
    
    [group2.items addObject:item1];
    [group2.items addObject:item2];
    [group2.items addObject:item3];
    [group2.items addObject:item4];
    [group2.items addObject:item5];
    [group2.items addObject:item6];
    [group2.items addObject:item7];
    [self.datas addObject:group2];
    
}
-(void)group3
{
    
    LSSettingItemGroup *group3=[[LSSettingItemGroup alloc]init];
    group3.headerTitle=@"新微博推送通知";
    LSSettingSwitchItem *item1=[LSSettingSwitchItem settingItemWithTitle:@"好友圈微博" subTitle:nil desClass:nil];
    LSSettingArrowItem *item2=[LSSettingArrowItem settingItemWithTitle:@"特别关注微博" subTitle:@"关闭" desClass:nil];
    LSSettingSwitchItem *item3=[LSSettingSwitchItem settingItemWithTitle:@"群微博" subTitle:nil desClass:nil];
    LSSettingSwitchItem *item4=[LSSettingSwitchItem settingItemWithTitle:@"微博热点" subTitle:nil desClass:nil];
    
    [group3.items addObject:item1];
    [group3.items addObject:item2];
    [group3.items addObject:item3];
    [group3.items addObject:item4];
    [self.datas addObject:group3];
    
}
-(void)group4
{
    
    LSSettingItemGroup *group4=[[LSSettingItemGroup alloc]init];
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"免打扰设置" subTitle:nil desClass:nil];
    LSSettingArrowItem *item2=[LSSettingArrowItem settingItemWithTitle:@"获取新消息" subTitle:@"每半分钟" desClass:nil];
    [group4.items addObject:item1];
    [group4.items addObject:item2];
    [self.datas addObject:group4];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }else if(section==2){
        return 0.1;
    }else {
    
        return 20;
    }
}

@end
