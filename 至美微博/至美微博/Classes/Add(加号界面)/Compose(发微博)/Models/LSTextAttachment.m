


//
//  LSTextAttachment.m
//  至美微博
//
//  Created by song on 15/10/23.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSTextAttachment.h"
#import "LSEmotion.h"
@implementation LSTextAttachment
-(void)setEmotion:(LSEmotion *)emotion
{
    _emotion=emotion;
    self.image=[UIImage imageNamed:emotion.png];
}
@end
