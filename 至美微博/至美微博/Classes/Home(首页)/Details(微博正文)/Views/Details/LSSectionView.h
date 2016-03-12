//
//  LSSectionView.h
//  至美微博
//
//  Created by song on 15/10/13.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
//组头视图上的三个按钮
typedef enum
{
    LSButttonTypeRepost,
    LSButttonTypeComment,
    LSButttonTypeUnlike
    
}LSButttonType;

@class LSSectionView,LSStatus;

@protocol LSSectionViewDelegate <NSObject>

-(void)sectionView:(LSSectionView*)sectionView buttonType:(LSButttonType)type;

@end
@interface LSSectionView : UIImageView

@property (nonatomic, strong) LSStatus *status;
@property (nonatomic, weak) id<LSSectionViewDelegate> delegate;


@property(nonatomic,assign) LSButttonType selectdButtonType;
@end
