




//
//  LSUser.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSUser.h"

@implementation LSUser
-(void)setMbtype:(int)mbtype
{
    _mbtype=mbtype;
    _vip=mbtype>2;
}

-(void)setDescription:(NSString *)description
{


    _myDdescription=description;
}
@end
