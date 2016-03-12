//
//  LSStatusCell.h
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSToolBar.h"
@class LSStatusFrame,LSToolBar,LSStatusCell,LSStatus;
@protocol LSStatusCellDelegate <NSObject>

-(void)statusCell:(LSStatusCell*)statusCell buttonType:(LSToolBarButtonType)type status:(LSStatus*)status;

@end
@interface LSStatusCell : UITableViewCell

@property (nonatomic, strong) LSStatusFrame *statusFrame;
+(instancetype)statusCellWithTableView:(UITableView*)tableView;

//判断点击的是哪个view(原创微博view，转发微博view)
@property(nonatomic,assign,getter=isOriginal) BOOL original;
@property (nonatomic, weak) LSToolBar *toolBar;



@property (nonatomic, weak) id <LSStatusCellDelegate> delegate;
@end
