//
//  LSTextAttachment.h
//  至美微博
//
//  Created by song on 15/10/23.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSEmotion;
@interface LSTextAttachment : NSTextAttachment
@property (nonatomic, strong) LSEmotion *emotion;
@end
