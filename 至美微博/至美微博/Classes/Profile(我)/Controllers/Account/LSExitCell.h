//
//  LSExitCell.h
//  至美微博
//
//  Created by song on 15/10/22.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSExitCell : UITableViewCell
+(instancetype)exitCell:(UITableView*)tableView;
@property (nonatomic, weak) UILabel *label;
@end
