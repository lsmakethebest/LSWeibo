


//
//  LSPhoto.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSPhoto.h"

@implementation LSPhoto
-(void)setThumbnail_pic:(NSURL *)thumbnail_pic
{
    _thumbnail_pic=thumbnail_pic;
    NSString *str=[thumbnail_pic.absoluteString stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    _bmiddle_pic=[NSURL URLWithString:str];
}
@end
