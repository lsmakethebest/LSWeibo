


//
//  LSBaseParam.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSBaseParam.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
@implementation LSBaseParam
+(instancetype)param
{
    LSBaseParam *param=[[self alloc]init];
    param.access_token=[LSAccountTool currentAccount].access_token;
    return param;
}
@end
