
//
//  LSNewFeatureCell.m
//  至美微博
//
//  Created by ls on 15/10/4.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSNewFeatureCell.h"
#import "LSChooseRootController.h"
@interface LSNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UIButton *shareButton;
@property (nonatomic, weak) UIButton *startButton;
@end
@implementation LSNewFeatureCell

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        
        _imageView = imageV;
        
        // 注意:一定要加载contentView
        [self.contentView addSubview:imageV];
        
    }
    return _imageView;
}

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        btn.adjustsImageWhenHighlighted=NO;
        [self.contentView addSubview:btn];
        
        _shareButton = btn;
        
    }
    return _shareButton;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:startBtn];
        _startButton = startBtn;
        
    }
    return _startButton;
}
-(void)setImage:(UIImage *)image
{
    _image=image;
    self.imageView.image=image;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.backgroundColor=[UIColor redColor];
    
    self.imageView.frame=self.bounds;
    // 分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}
// 判断当前cell是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.item == count - 1) { // 最后一页,显示分享和开始按钮
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
        
        
    }else{ // 非最后一页，隐藏分享和开始按钮
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}
-(void)start
{
    //进入tabbarcontroller

    [LSChooseRootController chooseRootController:LSKeyWindow];
    
}
-(void)share
{
    self.shareButton.selected=!self.shareButton.selected;
    
}
@end
