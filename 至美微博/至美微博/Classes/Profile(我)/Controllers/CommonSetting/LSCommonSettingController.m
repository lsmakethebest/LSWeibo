



//
//  LSCommonSettingController.m
//  至美微博
//
//  Created by song on 15/10/27.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSCommonSettingController.h"
#import "LSSettingSwitchItem.h"
#import "LSSettingArrowItem.h"
#import "LSSettingItemGroup.h"
@interface LSCommonSettingController ()

@end

@implementation LSCommonSettingController


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
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"阅读模式" subTitle:@"有图模式" desClass:nil];
    LSSettingArrowItem *item2=[LSSettingArrowItem settingItemWithTitle:@"字号大小" subTitle:@"小" desClass:nil];
    LSSettingSwitchItem *item3=[LSSettingSwitchItem settingItemWithTitle:@"显示备注" subTitle:nil desClass:nil];
    [group1.items addObject:item1];
    [group1.items addObject:item2];
    [group1.items addObject:item3];
    [self.datas addObject:group1];
}
-(void)group2
{
    LSSettingItemGroup *group2=[[LSSettingItemGroup alloc]init];
    LSSettingArrowItem *item1=[LSSettingArrowItem settingItemWithTitle:@"图片质量设置" subTitle:nil desClass:nil];
    [group2.items addObject:item1];
    [self.datas addObject:group2];
}

-(void)group3
{
    LSSettingItemGroup *group3=[[LSSettingItemGroup alloc]init];
     LSSettingSwitchItem *item1=[LSSettingSwitchItem settingItemWithTitle:@"声音" subTitle:nil desClass:nil];
    LSSettingArrowItem *item2=[LSSettingArrowItem settingItemWithTitle:@"多语言环境" subTitle:@"跟随系统" desClass:nil];
    [group3.items addObject:item1];
    [group3.items addObject:item2];
    [self.datas addObject:group3];
}

@end
