//
//  LSProfileHeaderCell.m
//  至美微博
//
//  Created by song on 15/10/27.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSProfileHeaderCell.h"
#import "LSAccountTool.h"
#import "LSAccount.h"
#import "UIImageView+WebCache.h"
#import "LSUser.h"
@interface LSProfileHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@end
@implementation LSProfileHeaderCell

+(instancetype)profileHeaderCellWithTableView:(UITableView *)tableView
{
    static NSString *reuseID=@"cell";
    LSProfileHeaderCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"LSProfileHeaderView" owner:nil options:nil]lastObject];
        UIView *view=[[UIView alloc]init];
        view.height=44;
        view.backgroundColor=[UIColor clearColor];
        cell.selectedBackgroundView=view;
    }
    return cell;
}
- (void)awakeFromNib {
    NSString *profile_imageUrl=[LSAccountTool currentAccount].profile_url;
    [self.iconImageView setImageWithURL:[NSURL URLWithString:profile_imageUrl ] placeholderImage:[UIImage imageNamed:@"icon"] ];
    NSString *name=[LSAccountTool currentAccount].name;
    self.nickLabel.text=name;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(CGFloat)cellHeight
{
    return 80;
}

@end
