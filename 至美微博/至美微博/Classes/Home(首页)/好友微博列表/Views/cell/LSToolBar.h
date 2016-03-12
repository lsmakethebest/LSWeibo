//
//  LSToolBar.h
//  至美微博
//
//  Created by song on 15/10/10.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    LSToolBarButtonTypeRepost,
    LSToolBarButtonTypeComment,
    LSToolBarButtonTypeUnlike
}LSToolBarButtonType;
@class LSStatusFrame,LSToolBar;
@protocol LSToolBarDelegate <NSObject>

-(void)toolBar:(LSToolBar*)toolBar buttonType:(LSToolBarButtonType)type;

@end
@interface LSToolBar : UIImageView
@property (nonatomic, strong) LSStatusFrame *statusFrame;
@property (nonatomic, weak) id<LSToolBarDelegate> delegate;
@end
