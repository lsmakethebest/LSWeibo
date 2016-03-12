

//
//  LSEmotionListView.m
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionListView.h"
#import "LSEmotionGridView.h"

@interface LSEmotionListView ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end
@implementation LSEmotionListView



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UIScrollView *scrollView=[[UIScrollView alloc]init];
        scrollView.showsHorizontalScrollIndicator=NO;
        scrollView.showsVerticalScrollIndicator=NO;
        scrollView.pagingEnabled=YES;

        [self addSubview:scrollView];
        scrollView.delegate=self;
        self.scrollView=scrollView;
        
        UIPageControl *pageControl=[[UIPageControl alloc]init];
        pageControl.currentPageIndicatorTintColor=LSRandomColor;
        pageControl.pageIndicatorTintColor=LSRandomColor;
        
        
        [self addSubview:pageControl];
        self.pageControl=pageControl;
        
    }
    return self;
}
-(void)setEmotions:(NSArray *)emotions
{
    _emotions=emotions;
    
    self.scrollView.contentOffset=CGPointZero;
//    总共有多少个表情
    int count=emotions.count;
    int totlaPage=(count+LSEmotionPerMaxCount-1)/LSEmotionPerMaxCount;
//      LSLog(@"totaalPage===%d",totlaPage);
//    设置pageControl的总页数
    self.pageControl.numberOfPages=totlaPage;
    
    int currentPage=self.scrollView.subviews.count;
    self.scrollView.contentSize= CGSizeMake(self.scrollView.width*totlaPage,0);
//    创建一页表情的GridView
    for (int i=0; i<totlaPage; i++) {
        LSEmotionGridView *gridView=nil;
        
        
        if (i>=currentPage) {
            gridView=[[LSEmotionGridView alloc]init];
            [self.scrollView addSubview:gridView];
        }else{
            gridView=self.scrollView.subviews[i];
        }

        int location=i*LSEmotionPerMaxCount;
        int length=LSEmotionPerMaxCount;
        if (location+length>count) {
            length=count-location;
        }
        NSRange range=NSMakeRange(location, length);
        NSArray *gridEmotions=[emotions subarrayWithRange:range];
        gridView.emotions=gridEmotions;
        gridView.hidden=NO;
    }
    for (int i=totlaPage; i<self.scrollView.subviews.count; i++) {
        LSEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.hidden = YES;
    }
    [self setNeedsLayout];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.pageControl.width=self.width;
    self.pageControl.height=30;
    self.pageControl.y=self.height-self.pageControl.height;
    
    self.scrollView.width=self.width;
    self.scrollView.height=self.height-self.pageControl.height;
    
    int count=self.scrollView.subviews.count;
    for (int i=0; i<count; i++) {
        UIView *gridView=self.scrollView. subviews[i];
        gridView.width=self.scrollView.width;
        gridView.height=self.scrollView.height;
        gridView.x=i*gridView.width;
    }
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage= (scrollView.contentOffset.x+scrollView.width/2)/scrollView.width;
}

@end
