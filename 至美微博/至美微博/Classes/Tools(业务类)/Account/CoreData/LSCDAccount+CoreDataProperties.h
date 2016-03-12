//
//  LSCDAccount+CoreDataProperties.h
//  至美微博
//
//  Created by song on 15/10/28.
//  Copyright © 2015年 ls. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "LSCDAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSCDAccount (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *access_token;
@property (nullable, nonatomic, retain) NSNumber *currentAccount;
@property (nullable, nonatomic, retain) NSDate *expires_date;
@property (nullable, nonatomic, retain) NSString *expires_in;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *remind_in;
@property (nullable, nonatomic, retain) NSString *uid;
@property (nullable, nonatomic, retain) NSString *profile_image_url;

@end

NS_ASSUME_NONNULL_END
