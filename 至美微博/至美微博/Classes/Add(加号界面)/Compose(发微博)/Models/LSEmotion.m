


//
//  LSEmotion.m
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotion.h"
#define  LSEmotionChs @"chs"
#define  LSEmotionCht @"cht"
#define  LSEmotionPng @"png"
#define  LSEmotionCode @"code"
@implementation LSEmotion



-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        _chs=[aDecoder decodeObjectForKey:LSEmotionChs];
        _cht=[aDecoder decodeObjectForKey:LSEmotionCht];
        _png=[aDecoder decodeObjectForKey:LSEmotionPng];
        _code=[aDecoder decodeObjectForKey:LSEmotionCode];
        
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_chs forKey:LSEmotionChs];
    [aCoder encodeObject:_cht forKey:LSEmotionCht];
    [aCoder encodeObject:_png forKey:LSEmotionPng];
    [aCoder encodeObject:_code forKey:LSEmotionCode];
}
-(BOOL)isEqual:(LSEmotion*)object
{
    if (self.code) {
        return [self.code isEqualToString:object.code];
    }else{
        
        return   [self.png isEqualToString:object.png] && [self.chs isEqualToString:object.chs] && [self.cht isEqualToString:object.cht];
    }
}
@end
