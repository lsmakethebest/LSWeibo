//
//  LSSettingItem.h
//  至美微博
//
//  Created by song on 15/10/21.
//  Copyright © 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Block)();
@interface LSSettingItem : NSObject
@property (nonatomic, copy) NSURL *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property(nonatomic,copy) Block option;
@property(nonatomic,assign) Class desClass;
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle option:(Block)option;
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle desClass:(Class)desClass;
+(instancetype)settingItemWithIcon:(NSURL*)icon title:(NSString*)title subTitle:(NSString*)subTitle option:(Block)option;
+(instancetype)settingItemWithIcon:(NSURL*)icon title:(NSString*)title subTitle:(NSString*)subTitle desClass:(Class)desClass;
@end
