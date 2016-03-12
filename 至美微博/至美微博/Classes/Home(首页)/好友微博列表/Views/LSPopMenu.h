//
//  LSPopMenu.h
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSPopMenu : UIImageView
@property (nonatomic, weak) UIView *conntentView;
+(instancetype)showInRect:(CGRect)rect;
+(void)hide;
@end
