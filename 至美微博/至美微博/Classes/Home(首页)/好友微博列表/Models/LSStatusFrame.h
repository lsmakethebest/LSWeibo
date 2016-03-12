//
//  LSAccountFrame.h
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSStatus.h"
@class LSAccount;
@interface LSStatusFrame : NSObject


/**
 *  微博数据
 */
@property (nonatomic, strong) LSStatus *status;

// 原创微博frame
@property (nonatomic, assign) CGRect originalViewFrame;

/**   ******原创微博子控件frame**** */
// 头像Frame
@property (nonatomic, assign) CGRect originalIconFrame;

// 昵称Frame
@property (nonatomic, assign) CGRect originalNameFrame;

// vipFrame
@property (nonatomic, assign) CGRect originalVipFrame;

// 时间Frame
@property (nonatomic, assign) CGRect originalTimeFrame;

// 来源Frame
@property (nonatomic, assign) CGRect originalSourceFrame;

// 正文Frame
@property (nonatomic, assign) CGRect originalTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect originalPhotosFrame;



// 转发微博frame
@property (nonatomic, assign) CGRect retweetViewFrame;

/**   ******转发微博子控件frame**** */
// 昵称和正文Frame
@property (nonatomic, assign) CGRect retweetNameAndTextFrame;

// 配图Frame
@property (nonatomic, assign) CGRect retweetPhotosFrame;
/**转发微博toolbar frame**/
//转发按钮
@property (nonatomic, assign) CGRect repostFrame;
//评论按钮
@property (nonatomic, assign) CGRect commentFrame;
//赞按钮
@property (nonatomic, assign) CGRect unlikeFrame;
//转发toolbarframe
@property (nonatomic, assign) CGRect retweetToolbarFrame;


/**   工具条frame**** */

@property (nonatomic, assign) CGRect toolBarFrame;



// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
