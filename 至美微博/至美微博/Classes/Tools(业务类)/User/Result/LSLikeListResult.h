//
//  LSLikeListResult.h
//  至美微博
//
//  Created by song on 15/10/31.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLikeListResult : NSObject
@property (nonatomic, copy) NSString *total_number;
@property (nonatomic, strong) NSArray *users;
@end
