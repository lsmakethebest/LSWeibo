//
//  LSCommentCell.h
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSCommentFrame;
@interface LSCommentCell : UITableViewCell
@property (nonatomic, strong) LSCommentFrame *commentFrame;
+(instancetype)commentCellWithTableView:(UITableView*)tableView;
@end
