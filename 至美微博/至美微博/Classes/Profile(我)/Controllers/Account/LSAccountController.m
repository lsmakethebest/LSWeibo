

//
//  LSAccountController.m
//  至美微博
//
//  Created by song on 15/10/22.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSAccountController.h"
#import "LSSettingArrowItem.h"
#import "LSSettingItemGroup.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
#import "LSUserTool.h"
#import "LSUser.h"
@interface LSAccountController ()

@end

@implementation LSAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LSSettingItemGroup *group=[[LSSettingItemGroup alloc]init];
    LSSettingArrowItem *item=[LSSettingArrowItem settingItemWithIcon:nil  title:@"添加账号" subTitle:nil option:^{
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [group.items addObject:item];
    [self.datas addObject:group];
    //获取数据库所有用户信息
    NSArray *accounts=[[LSAccountTool accountTool] accounts];
    if (accounts.count) {
        NSLog(@"用户总数为%lu",(unsigned long)accounts.count);
        [accounts enumerateObjectsUsingBlock:^(LSAccount * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *name=obj.name;
            if (!obj.name) {//获取用户信息
                [LSUserTool userInfoWithAccessToken: obj.access_token success:^(LSUser *user) {
                    obj.name=user.name;
                    LSSettingArrowItem *item=[LSSettingArrowItem settingItemWithIcon:user.profile_image_url title:name subTitle:nil option:^{
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }];
                    [group.items insertObject:item atIndex:0];
                    [self.tableView reloadData];
                    
                } failure:^(NSError *error) {
                    
                }];
            }
            
        }];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

@end
