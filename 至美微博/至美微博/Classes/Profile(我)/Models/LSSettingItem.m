


//
//  LSSettingItem.m
//  至美微博
//
//  Created by song on 15/10/21.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSettingItem.h"

@implementation LSSettingItem
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle option:(Block)option
{
    return [[self alloc]initWithSettingItemWithIcon:nil title:title subTitle:subTitle desClass:nil option:option];
}
+(instancetype)settingItemWithTitle:(NSString*)title subTitle:(NSString*)subTitle desClass:(Class)desClass
{
    return [[self alloc]initWithSettingItemWithIcon:nil title:title subTitle:subTitle desClass:desClass option:nil];
}
+(instancetype)settingItemWithIcon:(NSURL*)icon title:(NSString*)title subTitle:(NSString*)subTitle option:(Block)option
{
    return [[self alloc]initWithSettingItemWithIcon:icon title:title subTitle:subTitle desClass:nil option:option];
}
+(instancetype)settingItemWithIcon:(NSURL*)icon title:(NSString*)title subTitle:(NSString*)subTitle desClass:(Class)desClass
{
    return [[self alloc]initWithSettingItemWithIcon:icon title:title subTitle:subTitle desClass:desClass option:nil];
}
-(instancetype)initWithSettingItemWithIcon:(NSURL*)icon title:(NSString*)title subTitle:(NSString*)subTitle desClass:(Class)desClass option:(Block)option
{
    if (self=[super init]) {
        self.icon=icon;
        self.title=title;
        self.subTitle=subTitle;
        self.option=option;
        self.desClass=desClass;
    }
    return self;
}
@end
