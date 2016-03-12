//
//  LSComment.h
//  至美微博
//
//  Created by song on 15/10/12.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSUser;
@interface LSComment : NSObject
//创建时间
@property (nonatomic, copy) NSString *created_at;
//字符串型微博id
@property (nonatomic, copy) NSString *idstr;
//评论内容
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSAttributedString *attributedText;
//用户信息
@property (nonatomic, strong) LSUser *user;
@end
