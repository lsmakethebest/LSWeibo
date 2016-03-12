



//
//  LSRepostResult.m
//  至美微博
//
//  Created by song on 15/10/27.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSRepostResult.h"
#import "MJExtension.h"
#import "LSComment.h"
@implementation LSRepostResult
+(NSDictionary *)objectClassInArray
{
    return @{@"reposts":[LSComment class]};
}
@end
