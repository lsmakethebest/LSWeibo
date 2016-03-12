//
//  LSFriendCell.h
//  至美微博
//
//  Created by song on 15/10/31.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSUser;
@interface LSFriendCell : UITableViewCell
+(instancetype)friendCellWithTableView:(UITableView*)tableView;
@property (nonatomic, strong) LSUser *user;
@end
