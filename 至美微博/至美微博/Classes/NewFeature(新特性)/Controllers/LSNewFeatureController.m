

//
//  LSNewFeatureController.m
//  至美微博
//
//  Created by ls on 15/10/4.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSNewFeatureController.h"
#import "LSNewFeatureCell.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface LSNewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
/*
 存放图片的数组
 */
@property (nonatomic, strong) NSMutableArray *images;
@end

@implementation LSNewFeatureController

static NSString * const reuseIdentifier = @"newFeature";

//图片数组懒加载
-(NSMutableArray *)images
{
    if (!_images) {
        _images=[NSMutableArray array];
        // 拼接图片名称
        for (int i=0; i<4; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
            [_images addObject: imageName];
        }
    }
    return _images;
}
-(instancetype)init
{
    //配置collectionView的布局
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.itemSize=[UIScreen mainScreen].bounds.size;
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing=0;
    return [super initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加pageControl

    CGFloat w=self.images.count*20;
    UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((ScreenWidth-w)/2, ScreenHeight-30,w , 20)];

    pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    pageControl.pageIndicatorTintColor=[UIColor blueColor];
    [self.view addSubview:pageControl];
    self.pageControl=pageControl;
    pageControl.numberOfPages=self.images.count;
    
    //设置collectionView
    self.collectionView.backgroundColor=[UIColor whiteColor];
    [self.collectionView registerClass:[LSNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.bounces=YES;
    self.collectionView.pagingEnabled=YES;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark <UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LSNewFeatureCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.image = [UIImage imageNamed: self.images[indexPath.item]];
    [cell setIndexPath:indexPath count:self.images.count];
    return cell;
}
//监听滚动代理设置pageControl
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat x=  self.collectionView.contentOffset.x;
    self.pageControl.currentPage=(x+ScreenWidth/2)/ScreenWidth;
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
