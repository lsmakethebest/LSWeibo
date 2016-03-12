







//
//  LSAccount.m
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//
#import <objc/runtime.h>
#import "LSAccount.h"
#define LSAccountTokenKey @"token"
#define LSUidKey @"uid"
#define LSExpires_inKey @"expires"
#define LSExpires_dateKey @"date"
#define LSNameKey @"name"

@implementation LSAccount
+(instancetype)accountWithDict:(NSDictionary *)dict
{
    LSAccount *account=[[self alloc]init];
    [account setValuesForKeysWithDictionary:dict];
    return account;
}
-(void)setExpires_in:(NSString *)expires_in
{
    
    _expires_in=expires_in;
    _expires_date=[NSDate dateWithTimeIntervalSinceNow:[_expires_in longLongValue]];
}
//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self=[super init]) {
//        _access_token=[aDecoder decodeObjectForKey:LSAccountTokenKey];
//        _uid=[aDecoder decodeObjectForKey:LSUidKey];
//        _expires_in=[aDecoder decodeObjectForKey:LSExpires_inKey];
//        _name=[aDecoder decodeObjectForKey: LSNameKey];
//        _expires_date=[aDecoder decodeObjectForKey:LSExpires_dateKey];
//        
//    }
//    return self;
//}
//-(void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_access_token forKey:LSAccountTokenKey];
//    [aCoder encodeObject:_uid  forKey:LSUidKey];
//    [aCoder encodeObject:_expires_in forKey:LSExpires_inKey];
//    [aCoder encodeObject:_name forKey:LSNameKey];
//    [aCoder encodeObject:_expires_date forKey:LSExpires_dateKey];
//    
//}

@end
