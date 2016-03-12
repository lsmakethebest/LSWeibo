



//
//  LSMessageCell.m
//  至美微博
//
//  Created by song on 15/10/31.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSMessageCell.h"

@interface LSMessageCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *numberLabel;

@end
@implementation LSMessageCell
+(instancetype)meassageCellWithTableView:(UITableView *)tableView
{

    static NSString *reusedID=@"messageCell";
    LSMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:reusedID];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupAllChildView];
    }
    return self;
}
-(void)setupAllChildView
{
    UIImageView *iconImageView=[[UIImageView alloc]init];
    [self.contentView  addSubview:iconImageView];
    self.iconImageView=iconImageView;
    
    UILabel *nameLabel=[[UILabel alloc]init];
    [self.contentView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    
    UILabel *contentLabel=[[UILabel alloc]init];
    [self.contentView addSubview:contentLabel];
    self.contentLabel=contentLabel;
    
    
    UILabel *timeLabel=[[UILabel alloc]init];
    [self.contentView addSubview:timeLabel];
    self.timeLabel=timeLabel;

    
    UILabel *numberLabel=[[UILabel alloc]init];
    [self.contentView addSubview:numberLabel];
    self.numberLabel=numberLabel;
    
}
- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight
{
    return 50.f;
}
@end
