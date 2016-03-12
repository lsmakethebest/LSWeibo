//
//  LSStatusDetailsFrame.h
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSStatus;
@interface LSStatusDetailsFrame : NSObject

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

// 底部转发按钮frame
@property (nonatomic, assign) CGRect retweetFrame;
// 底部评论按钮frame
@property (nonatomic, assign) CGRect commentFrame;
// 底部赞按钮frame
@property (nonatomic, assign) CGRect unlikeFrame;



// 的高度
@property (nonatomic, assign) CGFloat headerViewHeight;
@end
