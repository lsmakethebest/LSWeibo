

//
//  LSNavigationController.m
//  至美微博
//
//  Created by song on 15/10/10.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSNavigationController.h"

@interface LSNavigationController ()

@end
@implementation LSNavigationController
+(void)initialize
{
    [super initialize];
//    修改UIBarButtonItem主题
    UIBarButtonItem *bar=[UIBarButtonItem appearance];
    NSDictionary *dict=@{NSForegroundColorAttributeName:LSColor(20,20,28)};
    [bar setTitleTextAttributes:dict forState:UIControlStateNormal];

    NSDictionary *dict1=@{NSForegroundColorAttributeName:LSColor(100, 100, 100)};
    [bar setTitleTextAttributes:dict1 forState:UIControlStateDisabled];
//    修改UINavigationBar主题
    UINavigationBar *navbar=[UINavigationBar appearance];
    NSDictionary *dict2=@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.2 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:19]};
    [navbar setTitleTextAttributes:dict2];
    [navbar setTintColor:[UIColor colorWithWhite:0.35 alpha:1.0]];
    
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
self.tabBarController.tabBar.hidden=YES;

}

@end
