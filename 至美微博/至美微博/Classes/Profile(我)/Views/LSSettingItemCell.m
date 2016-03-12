

//
//  LSSettingItemCell.m
//  至美微博
//
//  Created by song on 15/10/21.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSSettingItemCell.h"
#import "UIImageView+WebCache.h"
#import "LSSettingCorrectItem.h"
@interface LSSettingItemCell ()
@property (nonatomic, strong) UISwitch *switchAccessory;
@property (nonatomic, strong) UIImageView *correctView;
@end

@implementation LSSettingItemCell
-(UISwitch *)switchAccessory
{
    if (_switchAccessory==nil) {
        _switchAccessory=[[UISwitch alloc]init];
    }
    return _switchAccessory;
}
-(UIImageView *)correctView
{
    if (_correctView==nil) {
        _correctView=[[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _correctView;
}
+(instancetype)settingCellWithTableView:(UITableView*)tableView
{
    static NSString *reuseID=@"settingCell";
    LSSettingItemCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
        cell.imageView.layer.cornerRadius=27;
        
    }                                                                                         
    return cell;
}
-(void)setItem:(LSSettingItem *)item
{
    _item=item;
    self.textLabel.text=item.title;
    self.detailTextLabel.text=item.subTitle;
    if (item.icon) {
        [self.imageView setImageWithURL:item.icon placeholderImage:[UIImage imageNamed:@"icon"]];
    }
    if ([item isKindOfClass:[LSSettingSwitchItem class]]) {
        self.accessoryView=self.switchAccessory;
    }else if([item isKindOfClass:[LSSettingArrowItem class]]){
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    else if([item isKindOfClass:[LSSettingCorrectItem class]]){
        self.accessoryView=self.correctView;
    }else{
        self.accessoryView=nil;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setSeparatorInset:UIEdgeInsetsMake(0, -100, 0, 0)];
    self.detailTextLabel.x+=10;
//    CAShapeLayer *layer=[CAShapeLayer layer];
//    CGMutablePathRef path=CGPathCreateMutable();
//
//
//    CGPathAddArc(path, NULL, 22, 22, 22, 0,2*M_PI, 0);
//    layer.path=path;
//    self.imageView.layer.mask=layer;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(11 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"size========%@",NSStringFromCGRect(self.frame));
//    });
//    
}
@end
