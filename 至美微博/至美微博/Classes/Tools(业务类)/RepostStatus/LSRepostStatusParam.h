//
//  LSRepostStatusParam.h
//  至美微博
//
//  Created by song on 15/10/29.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSBaseParam.h"

@interface LSRepostStatusParam : LSBaseParam
/**
 *要转发的微博ID
 */
@property (nonatomic, copy) NSString *id;
/**
 *转发的微博文本内容
 */
@property (nonatomic, copy) NSString *status;

@end
