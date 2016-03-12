




//
//  LSFriendCell.m
//  至美微博
//
//  Created by song on 15/10/31.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSFriendCell.h"
#import "UIImageView+WebCache.h"
#import "LSUser.h"
@interface LSFriendCell ()

@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *introductionLabel;


@end
@implementation LSFriendCell

+(instancetype)friendCellWithTableView:(UITableView *)tableView
{
     static NSString *resuesFriendID=@"friendCell";
    LSFriendCell *cell=[tableView dequeueReusableCellWithIdentifier:resuesFriendID];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuesFriendID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     
        [self setupAllChildView];
    }
    return self
    ;
}
-(void)setupAllChildView
{
    UIImageView *iconImageView=[[UIImageView alloc]init];
    [self.contentView  addSubview:iconImageView];
    self.iconImageView=iconImageView;
    
    UILabel *nameLabel=[[UILabel alloc]init];
    [self.contentView addSubview:nameLabel];
    self.nameLabel=nameLabel;
    
    UILabel *introductionLabel=[[UILabel alloc]init];
    [self.contentView addSubview:introductionLabel];
    self.introductionLabel=introductionLabel;

    
}
-(void)setUser:(LSUser *)user
{
    _user=user;
    [self.iconImageView setImageWithURL:user.profile_image_url placeholderImage:[UIImage imageNamed:@"icon"]];
    self.nameLabel.text=user.name;
    self.introductionLabel.text=user.description;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews
{
    [super    layoutSubviews];
    self.iconImageView.x=LSCellMargin;
    self.iconImageView.y=LSCellMargin;
    self.iconImageView.width=40;
    
}

@end
