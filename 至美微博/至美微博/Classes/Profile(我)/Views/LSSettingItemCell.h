//
//  LSSettingItemCell.h
//  至美微博
//
//  Created by song on 15/10/21.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSSettingSwitchItem.h"
#import "LSSettingArrowItem.h"
@interface LSSettingItemCell : UITableViewCell
@property (nonatomic, strong) LSSettingItem *item;
+(instancetype)settingCellWithTableView:(UITableView*)tableView;
@end
