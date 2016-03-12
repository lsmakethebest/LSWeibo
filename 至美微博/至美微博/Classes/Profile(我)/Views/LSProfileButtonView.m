


//
//  LSProfileButtonView.m
//  至美微博
//
//  Created by song on 15/10/27.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSProfileButtonView.h"
#import "LSUserTool.h"
@interface LSProfileButtonView ()

@property (weak, nonatomic) IBOutlet UILabel *statusCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *flowersCountLabel;

@end
@implementation LSProfileButtonView
+(instancetype)profileButtonView
{
    LSProfileButtonView *profileBtnView=[[[NSBundle mainBundle]loadNibNamed:@"LSProfileButtom" owner:nil options:nil]lastObject];
    profileBtnView.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    [profileBtnView setHighlightedImage:[UIImage imageWithStretchableName:@"timeline_retweet_background_highlighted"]];
    return profileBtnView;
}
+(CGFloat)height
{
    return 50;
}
-(void)awakeFromNib
{
    
    /*
     {
     "followers_count" = 7;
     "friends_count" = 44;
     id = 5059145929;
     "pagefriends_count" = 0;
     "private_friends_count" = 0;
     "statuses_count" = 16;
     }
     */
    [LSUserTool getWioboLikeFlowerCountWith:nil success:^(NSDictionary *resultDict) {
        NSLog(@"%@",resultDict[@"statuses_count"]);
        self.statusCountLabel.text= [NSString stringWithFormat:@"%@",resultDict[@"statuses_count"]];
        self.likeAccountLabel.text=[NSString stringWithFormat:@"%@",resultDict[@"friends_count"]];
        self.flowersCountLabel.text=[NSString stringWithFormat:@"%@",resultDict[@"followers_count"]];
    } failure:^(NSError *error) {
        
    }];
}
@end
