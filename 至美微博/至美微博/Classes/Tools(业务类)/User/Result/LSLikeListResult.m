



//
//  LSLikeListResult.m
//  至美微博
//
//  Created by song on 15/10/31.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSLikeListResult.h"
#import "MJExtension.h"
#import "LSUser.h"
@implementation LSLikeListResult

+(NSDictionary*)objectClassInArray
{
    return @{@"users":[LSUser class]};
}
@end
