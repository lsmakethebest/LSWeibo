//
//  LSCover.h
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSCover;
@protocol LSCoverDelegate <NSObject>

-(void)coverClick:(LSCover*)cover;
@end
@interface LSCover : UIView
@property (nonatomic, assign) BOOL dimBackground;
@property (nonatomic, weak) id<LSCoverDelegate> delegate;
+(instancetype)show;
@end
