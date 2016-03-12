//
//  LSLink.h
//  至美微博
//
//  Created by song on 15/10/25.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSLink : NSObject
@property (nonatomic, assign) NSRange range;
@property (nonatomic, copy) NSString *text;
/**
 *对应的矩形框数组
 */
@property (nonatomic, strong) NSArray *rects;
@end
