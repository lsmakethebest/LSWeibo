//
//  LSTabBar.h
//  新浪微博
//
//  Created by song on 15/9/19.
//  Copyright © 2015年 song. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSTabBar;
@protocol LSTabBarDelegate <NSObject>

-(void)tabBarClick:(LSTabBar*)tabBar;

@end
@interface LSTabBar : UITabBar
@property (nonatomic, weak) id<LSTabBarDelegate> myDelegate;
@end
