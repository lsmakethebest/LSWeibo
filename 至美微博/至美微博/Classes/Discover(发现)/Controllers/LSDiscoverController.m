



//
//  LSDiscoverController.m
//  至美微博
//
//  Created by song on 15/10/9.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSDiscoverController.h"
#import "LSSearchBar.h"
@interface LSDiscoverController ()

@end

@implementation LSDiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];

      self.title=@"发现";
    LSSearchBar *seachbar=[[LSSearchBar alloc]init];
    seachbar.placeholder=@"sdkjfjhkdjh";
    seachbar.frame=CGRectMake(0, 0, LSScreenHeight, 30);
    self.navigationItem.titleView=seachbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}


@end
