//
//  LSCommentFrame.h
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSComment;
@interface LSCommentFrame : NSObject
@property (nonatomic, strong) LSComment *comment;
//头像frame
@property(nonatomic,assign) CGRect iconFrame;
//昵称frame
@property(nonatomic,assign) CGRect nameFrame;
//时间frame
@property(nonatomic,assign) CGRect timeFrame;
//评论内容frame
@property(nonatomic,assign) CGRect textFrame;
//行高
@property(nonatomic,assign) CGFloat cellHeight;
@end
