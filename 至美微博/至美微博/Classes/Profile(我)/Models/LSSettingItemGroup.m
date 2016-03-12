





//
//  LSSettingGroupItem.m
//  至美微博
//
//  Created by song on 15/10/21.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSettingItemGroup.H"

@implementation LSSettingItemGroup
-(NSMutableArray *)items
{
    if (_items==nil) {
        _items=[NSMutableArray array];
    }
    return _items;
}
@end
