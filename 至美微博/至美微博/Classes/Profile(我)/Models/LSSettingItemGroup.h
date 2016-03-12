//
//  LSSettingGroupItem.h
//  至美微博
//
//  Created by song on 15/10/21.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSSettingItemGroup : NSObject
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, strong) NSMutableArray *items;
@end
