


//
//  LSAccountTool.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSAccountTool.h"
#import "LSAccount.h"
#import "LSCDAccount.h"
#import <CoreData/CoreData.h>

static LSAccount *currentAccount;
#define  LSEntityName @"LSCDAccount"
#define LSAccountFileName [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"account.data"]


@interface LSAccountTool ()
@property (nonatomic, strong) NSManagedObjectContext *context;
@end
@implementation LSAccountTool
+(instancetype)accountTool
{
    return [[self alloc]init];
}
-(NSManagedObjectContext *)context
{
    if (_context==nil) {
        NSManagedObjectModel *model=[NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc=[[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        NSURL *url=[ NSURL URLWithString:[NSString stringWithFormat:@"file://%@/Documents/allAccount.data", NSHomeDirectory()]];
        [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:NULL URL:url options:NULL error:NULL];
        _context=[[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _context.persistentStoreCoordinator=psc;
    }
    return _context;
}
-(void)addAccount:(LSAccount *)account
{
    
    
    //先取出来是否有这个用户
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:LSEntityName];
    NSLog(@"%@",account.access_token);
    NSString *pre=[NSString stringWithFormat:@"access_token='%@'",account.access_token];
    request.predicate=[NSPredicate predicateWithFormat:pre];
    NSError *error;
    NSArray *arr=[self.context executeFetchRequest:request error:&error];
    if (!arr) {
        NSLog(@"%@",error.localizedDescription);
    }
    if (arr.count) {//已经存在此用户
        LSCDAccount *cd=arr[0];
        cd.currentAccount=@(1);
        if (![self.context save:&error]) {
            NSLog(@"%@",error.localizedDescription);
        }
        return;
    }
    
    //获取一个NSManagedObject
    LSCDAccount *cdAccount= [NSEntityDescription insertNewObjectForEntityForName:LSEntityName inManagedObjectContext:self.context];
    cdAccount.name=account.name;
    cdAccount.access_token=account.access_token;
    cdAccount.expires_date=account.expires_date;
    cdAccount.expires_in=account.expires_in;
    cdAccount.uid=account.uid;
    cdAccount.remind_in=account.remind_in;
    cdAccount.currentAccount=@(1);
    
    if (![self.context save:&error]) {
        NSLog(@"%@",error.localizedDescription);
    }
    
}
-(NSArray*)accounts
{
    NSMutableArray *accounts=[NSMutableArray array];
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:LSEntityName];
    NSError *error=nil;
    NSArray *arr=[self.context executeFetchRequest:request error:&error];
    if (!arr) {
        NSLog(@"%@",error.localizedDescription);
        return accounts;
    }
    for (LSCDAccount *cdaccount in arr) {
        LSAccount *account=[[LSAccount  alloc]init];
        account.name=cdaccount.name;
        account.profile_url=cdaccount.profile_image_url;
        account.access_token=cdaccount.access_token;
        account.expires_date=cdaccount.expires_date;
        account.expires_in=cdaccount.expires_in;
        account.uid=cdaccount.uid;
        account.remind_in=cdaccount.remind_in;
        account.currentAccount=cdaccount.currentAccount.boolValue;
        NSLog(@"%@",cdaccount.access_token);
        [accounts addObject:account];
    }
    return accounts;
    
}
+(LSAccount*)currentAccount
{
    return currentAccount;
}
+(void)setCurrentAccount:(LSAccount *)newAccount
{
    currentAccount=newAccount;
}
-(void)updateAccount:(LSAccount *)account
{
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:LSEntityName];
    NSLog(@"%@",account.access_token);
    NSString *pre=[NSString stringWithFormat:@"access_token='%@'",account.access_token];
    request.predicate=[NSPredicate predicateWithFormat:pre];
    NSError *error;
    NSArray *arr=[self.context executeFetchRequest:request error:&error];
    if (!arr) {
        NSLog(@"%@",error.localizedDescription);
    }
    for (LSCDAccount *cdaccount in arr) {
#warning skldfjslkdjflsdfjl-------------
        cdaccount.currentAccount=@(account.isCurrentAccount);
        cdaccount.name=account.name;
        cdaccount.profile_image_url=account.profile_url;
        NSLog(@"%@",cdaccount.currentAccount);
    }
    
    NSError *err;
    if (![self.context save:&err]) {
        NSLog(@"%@",error.localizedDescription);
    }
    
}
-(LSAccount *)getSQLCurrentAccount
{
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:LSEntityName];
    NSString *pre=[NSString stringWithFormat:@"currentAccount==1"];
    request.predicate=[NSPredicate predicateWithFormat:pre];
    NSError *error;
    NSArray *arr=[self.context executeFetchRequest:request error:&error];
    if (!arr) {
        NSLog(@"%@",error.localizedDescription);
    }
    LSAccount *account=[[LSAccount alloc]init];
    //    如果没有默认用户则返回空
    if (!arr.count) {
        return nil;
    }
    //     有默认用户
    LSCDAccount *cdaccount=arr[0];
    account.name=cdaccount.name;
    account.profile_url=cdaccount.profile_image_url;
    NSLog(@"%@ %@",cdaccount.profile_image_url,cdaccount.name);
    account.access_token=cdaccount.access_token;
    account.expires_date=cdaccount.expires_date;
    account.expires_in=cdaccount.expires_in;
    account.uid=cdaccount.uid;
    account.remind_in=cdaccount.remind_in;
    account.currentAccount=cdaccount.currentAccount.boolValue;
    NSError *err;
    if (![self.context save:&err]) {
        NSLog(@"%@",error.localizedDescription);
    }
    //    设置静态变量为当前用户
    currentAccount=account;
    return account;
    
}
@end
