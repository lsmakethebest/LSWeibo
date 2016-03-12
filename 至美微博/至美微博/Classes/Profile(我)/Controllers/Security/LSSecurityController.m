






//
//  LSSecurityController.m
//  至美微博
//
//  Created by song on 15/10/27.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSecurityController.h"
#import "LSSettingArrowItem.h"
#import "LSSettingItemGroup.h"

@interface LSSecurityController ()

@end

@implementation LSSecurityController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self group1];
    [self group2];
    [self group3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)group1
{
    LSSettingItemGroup *group1=[[LSSettingItemGroup alloc]init];
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"隐私设置" subTitle:nil desClass:nil];
    LSSettingArrowItem *item2=[LSSettingArrowItem settingItemWithTitle:@"账号安全" subTitle:nil desClass:nil];
    
    [group1.items addObject:item1];
    [group1.items addObject:item2];
    [self.datas addObject:group1];
}
-(void)group2
{
    LSSettingItemGroup *group2=[[LSSettingItemGroup alloc]init];
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"已屏蔽消息的人" subTitle:nil desClass:nil];
    LSSettingArrowItem *item2=[LSSettingArrowItem settingItemWithTitle:@"已屏蔽微博的人" subTitle:nil desClass:nil];
    [group2.items addObject:item1];
    [group2.items addObject:item2];
    [self.datas addObject:group2];
}

-(void)group3
{ LSSettingItemGroup *group3=[[LSSettingItemGroup alloc]init];
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"黑名单" subTitle:nil desClass:nil];
    [group3.items addObject:item1];
    [self.datas addObject:group3];
}
@end
