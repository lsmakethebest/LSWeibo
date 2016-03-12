//
//  LSEmotionPopView.h
//  至美微博
//
//  Created by song on 15/10/19.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSEmotionView;
@interface LSEmotionPopView : UIView

+(instancetype)popView;
-(void)showFromEmotionView:(LSEmotionView*)emotionView;
-(void)dismiss;
@end
