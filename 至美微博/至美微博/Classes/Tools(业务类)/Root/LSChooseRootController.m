//
//  LSChooseRootController.m
//  至美微博
//
//  Created by ls on 15/10/4.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSChooseRootController.h"
#import "LSNewFeatureController.h"
#import <UIKit/UIKit.h>
#import "LSTarBarController.h"
#define LSVersionKey @"CFBundleVersion"
@implementation LSChooseRootController
+(void)chooseRootController:(UIWindow *)window
{
    
    
    NSString *currentVersion=[NSBundle mainBundle].infoDictionary[LSVersionKey];
    NSString *oldVersion=[[NSUserDefaults standardUserDefaults] objectForKey:LSVersionKey];
    if ([currentVersion isEqualToString:oldVersion]) {
        //打开主界面
        window.rootViewController=[[LSTarBarController alloc]init];
        
    }
    else
    {
        //打开新特性界面
        [[NSUserDefaults standardUserDefaults ] setObject:currentVersion forKey:LSVersionKey];
        LSNewFeatureController *newfeature=[[LSNewFeatureController alloc]init];
        window.rootViewController=newfeature;
        
    }
    
    
}
@end
