








//
//  LSBaseTableViewController.m
//  至美微博
//
//  Created by song on 15/10/21.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSBaseTableViewController.h"
#import "LSSettingItemGroup.h"
#import "LSSettingItemCell.h"


@interface LSBaseTableViewController ()

@end

@implementation LSBaseTableViewController
-(NSMutableArray *)datas
{
    if (_datas==nil) {
        _datas=[NSMutableArray array];
    }
    return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(instancetype)init
{
    
    return self=[super initWithStyle:UITableViewStyleGrouped];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LSSettingItemGroup *group=self.datas[section];
    return group.items.count;

}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSSettingItemCell *cell=[LSSettingItemCell settingCellWithTableView:tableView];
    LSSettingItemGroup *group=self.datas[indexPath.section];
    cell.item=group.items[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSSettingItemGroup *group=self.datas[indexPath.section];
    LSSettingItem *item= group.items[indexPath.row];
    if (item.option) {
        item.option();
    }else if (item.desClass){
    
        UIViewController *vc=[[item.desClass alloc]init];
        vc.title=item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    LSSettingItemGroup *group=self.datas[section];
    return group.headerTitle;
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    LSSettingItemGroup *group=self.datas[section];
    return group.footerTitle;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
@end
