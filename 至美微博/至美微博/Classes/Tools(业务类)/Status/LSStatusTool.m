


//
//  LSStatusTool.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSStatusTool.h"
#import "FMDB.h"
#import "LSStatusResult.h"
#import "MJExtension.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
#import "LSHttpTool.h"
#import "LSStatusParam.h"
#define LSStatusPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"status.sqlite"]
static FMDatabaseQueue *queue=nil;



@implementation LSStatusTool
+(void)initialize
{
    queue=[FMDatabaseQueue databaseQueueWithPath:LSStatusPath];
    [queue inDatabase:^(FMDatabase *db) {
        
        if (![db executeUpdate:@"create table if not exists statusTable(id integer primary key autoincrement,idstr  integer,access_token text,status blob)"]){
            NSLog(@"创建表失败%@",db.lastErrorMessage);
        }else {
            NSLog(@"创建表成功");
        }
    }];
    
}
+(void)loadNewStatusWithSinceId:(NSString *)sinceId  maxId:(NSString*)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    LSStatusParam *param=  [[LSStatusParam alloc]init];
    param.access_token=[LSAccountTool currentAccount].access_token;
    if (sinceId) {
        param.since_id=sinceId;
    }if (maxId) {
        param.max_id=maxId;
    }
    NSArray *statuses=[self getSQLStatus:param];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
    }else{
        [ LSHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
            //把微博数据存储到数据库中
            for (NSDictionary *statusDict in responseObject[@"statuses"]) {
                NSData *statusData=[NSKeyedArchiver archivedDataWithRootObject:statusDict];
                [queue inDatabase:^(FMDatabase *db) {
                    [db executeUpdate:@"insert into statusTable(idstr,access_token,status) values(?,?,?)",statusDict[@"idstr"],param.access_token,statusData];
                }] ;
                
            }
            if (success) {
                
                LSStatusResult *result=[LSStatusResult objectWithKeyValues:responseObject];
                success(result.statuses);
            }
        } failure:^(NSError *error) {
            NSLog(@"%@",error.localizedDescription);
            failure(error);
        }];
    }
    
}

+(NSArray*)getSQLStatus:(LSStatusParam*)param
{
    NSMutableArray *statuses =[NSMutableArray array];
    NSLog(@"sinceid==%@  maxid==%@",param.since_id,param.max_id);
    if (param.since_id) {
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs=[db executeQuery:@"select status from statusTable where access_token=? and idstr> ? order by idstr desc limit 20 ",param.access_token, param.since_id ];
            while ([rs next]) {
                
                NSDictionary *statusDict=[NSKeyedUnarchiver unarchiveObjectWithData:[rs objectForColumnName:@"status"]];
                LSStatus *status=[LSStatus objectWithKeyValues:statusDict];
                [statuses addObject:status];
            }
            
        }];
    }else if(param.max_id){
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs=[db executeQuery:@"select status from statusTable where access_token=? and idstr< ? order by idstr desc limit 20 ",param.access_token, param.max_id ];
            while ([rs next]) {
                
                NSDictionary *statusDict=[NSKeyedUnarchiver unarchiveObjectWithData:[rs objectForColumnName:@"status"]];
                LSStatus *status=[LSStatus objectWithKeyValues:statusDict];
                [statuses addObject:status];
            }
            
        }];
        
    }else{
        [queue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs=[db executeQuery:@"select status from statusTable where access_token=? order by idstr desc limit 20 ",param.access_token,param.since_id ];
            while ([rs next]) {
                
                NSDictionary *statusDict=[NSKeyedUnarchiver unarchiveObjectWithData:[rs objectForColumnName:@"status"]];
                LSStatus *status=[LSStatus objectWithKeyValues:statusDict];
                [statuses addObject:status];
            }
            
        }];
        
    }
    
    return statuses;
}


@end
