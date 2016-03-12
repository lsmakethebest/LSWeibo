



//
//  LSCommentResult.m
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSCommentResult.h"
#import "MJExtension.h"
#import "LSComment.h"
@interface LSCommentResult ()<MJKeyValue>

@end

@implementation LSCommentResult
+(NSDictionary *)objectClassInArray
{
    return @{@"comments":[LSComment class]};
}
@end
