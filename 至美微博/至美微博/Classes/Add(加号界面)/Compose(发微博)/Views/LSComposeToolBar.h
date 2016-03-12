//
//  LSComposeToolBar.h
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSComposeToolBar;

typedef enum
{
    LSComposeButtonTypePic,
    LSComposeButtonTypeMention,
    LSComposeButtonTypeTrend,
    LSComposeButtonTypeEmotion,
    LSComposeButtonTypeAdd
    
}LSComposeButtonType;
@protocol LSComposeToolBarDelegaete <NSObject>

-(void)composeToolBar:(LSComposeToolBar*)composeToolBar tag:(LSComposeButtonType)tag;

@end
@interface LSComposeToolBar : UIView
@property (nonatomic, weak) id<LSComposeToolBarDelegaete> delegate;
@property(nonatomic,assign,getter=isShowEmotionButton) BOOL showEmotionButton;

@end
