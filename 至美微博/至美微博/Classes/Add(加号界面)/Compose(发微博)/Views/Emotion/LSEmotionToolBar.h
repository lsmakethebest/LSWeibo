//
//  LSEmotionToolBar.h
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    LSEmotionToolBarButtonTypeDefault,
    LSEmotionToolBarButtonTypeRecent,
    LSEmotionToolBarButtonTypeEmoji,
    LSEmotionToolBarButtonTypeLxh
}LSEmotionToolBarButtonType;
@class LSEmotionToolBar;
@protocol LSEmotionToolBarDelegate <NSObject>

-(void)emotionToolBar:(LSEmotionToolBar*)toolBar buttonType:(LSEmotionToolBarButtonType)type;

@end
@interface LSEmotionToolBar : UIView
@property (nonatomic, weak) id<LSEmotionToolBarDelegate> delegate;
@end
