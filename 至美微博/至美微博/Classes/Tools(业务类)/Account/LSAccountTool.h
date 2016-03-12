//
//  LSAccountTool.h
//  至美微博
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LSAccount;


@interface LSAccountTool : NSObject

+(instancetype)accountTool;

//保存 一个新用户
-(void)addAccount:(LSAccount*)account;

//获取所有用户
-(NSArray*)accounts;

//获取当前用户
+(LSAccount*)currentAccount;

//设置当前用户
+(void)setCurrentAccount:(LSAccount *)account;

//更新用户信息
-(void)updateAccount:(LSAccount*)account;
-(LSAccount*)getSQLCurrentAccount;
@end
