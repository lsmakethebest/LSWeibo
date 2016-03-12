



//
//  LSStatusResult.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSStatusResult.h"
#import "LSStatus.h"
@implementation LSStatusResult
+(NSDictionary *)objectClassInArray
{
    return @{@"statuses":[LSStatus class]};
}
@end
