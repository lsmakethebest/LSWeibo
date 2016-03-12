



//
//  LSStatusCell.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSStatusCell.h"
#import "LSOriginalView.h"
#import "LSRetweetView.h"
#import "LSPhotos.h"
#import "LSPhoto.h"
#import "LSStatus.h"
#import "LSStatusFrame.h"
#import "LSToolBar.h"
@interface LSStatusCell ()<LSToolBarDelegate>
@property (nonatomic, weak) LSOriginalView *originalView;
@property (nonatomic, weak) LSRetweetView *retweetView;

@property (nonatomic, strong) UIView *cover;

@end
@implementation LSStatusCell

-(UIView *)cover
{
    if (_cover==nil) {
        _cover=[[UIView alloc]initWithFrame:CGRectMake(0, LSCellMargin, self.width, self.height-LSCellMargin)];
        _cover.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
        _cover.backgroundColor=[UIColor redColor];
        _cover.alpha=0.5;
    }
    return _cover;
}
+(instancetype)statusCellWithTableView:(UITableView *)tableView
{
    static NSString *identifier=@"cell";
    LSStatusCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor=[UIColor colorWithWhite:0.8 alpha:0.6];
        self.selectionStyle=UITableViewCellSelectionStyleDefault;
        [self setupAllChildView];
    }
    return self;
}
-(void)setupAllChildView
{
    //添加原创微博视图
    LSOriginalView *originalView=[[LSOriginalView alloc]init];
    [self.contentView addSubview:originalView];
    self.originalView=originalView;
    
    //添加转发微博视图
    LSRetweetView *retweetView=[[LSRetweetView alloc]init];
    [self.contentView addSubview: retweetView];
    self.retweetView=retweetView;
    LSToolBar *toolBar=[[LSToolBar alloc]init];
    [self addSubview:toolBar];
    self.toolBar=toolBar;
    self.toolBar.delegate=self;
    
}
-(void)setStatusFrame:(LSStatusFrame *)statusFrame
{
    _statusFrame=statusFrame;
    [self setupFrame];
    
}
-(void)setupFrame
{
    self.originalView.frame=_statusFrame.originalViewFrame;
    self.originalView.statusFrame=_statusFrame;
    self.retweetView.frame=_statusFrame.retweetViewFrame;
    self.retweetView.statusFrame=_statusFrame;
    self.toolBar.frame=_statusFrame.toolBarFrame;
    self.toolBar.statusFrame=_statusFrame;
}


-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        if (!self.isOriginal) {
            self.originalView.highlighted=NO;
            self.toolBar.highlighted=NO;
        }
    }
    
}
-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        if (!self.isOriginal) {
            self.originalView.highlighted=NO;
            self.toolBar.highlighted=NO;
        }
    }
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
//    NSLog(@"%@", NSStringFromCGPoint( [touch locationInView:self]));

    if (CGRectContainsPoint(self.originalView.frame, [touch locationInView:self])) {
//        NSLog(@"CGRectContainsPoint");
        self.original=YES;
    }else
    {
        self.original=NO;
    }
    [super touchesBegan:touches withEvent:event];
}
-(void)toolBar:(LSToolBar *)toolBar buttonType:(LSToolBarButtonType)type
{
    if ([self.delegate respondsToSelector:@selector(statusCell:buttonType:status:)]) {
        [self.delegate statusCell:self buttonType:type status:self.statusFrame.status];
    }
}
@end
