



//
//  LSExitCell.m
//  至美微博
//
//  Created by song on 15/10/22.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSExitCell.h"


@interface LSExitCell ()
@end
@implementation LSExitCell

+(instancetype)exitCell:(UITableView *)tableView
{
    LSExitCell *cell=[tableView dequeueReusableCellWithIdentifier:@"exitCell"];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"exitCell"];
    }
    return  cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        UILabel *label=[[UILabel alloc]init];
        label.textColor=[UIColor redColor];
        label.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        self.label =label;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.label.width=self.contentView.width;
    self.label.height=self.contentView.height;
}
@end
