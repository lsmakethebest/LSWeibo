//
//  LSStatusResult.h
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface LSStatusResult : NSObject<MJKeyValue>
@property (nonatomic, strong) NSArray *statuses;
@end
