

//
//  LSEmotionKeyboard.m
//  至美微博
//
//  Created by song on 15/10/18.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSEmotionKeyboard.h"
#import "LSEmotionToolBar.h"
#import "LSEmotionListView.h"
#import "MJExtension.h"
#import "LSEmotionTool.h"
#import "LSEmotion.h"
#define LSEmotionTooBarHeight 35
@interface LSEmotionKeyboard ()<LSEmotionToolBarDelegate>
@property (nonatomic, weak) LSEmotionListView *listView;
@property (nonatomic, weak) LSEmotionToolBar *toolBar;


@end
@implementation LSEmotionKeyboard


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor lightTextColor];
        LSEmotionListView *listView=[[LSEmotionListView alloc]init];
        [self addSubview:listView];
        self.listView=listView;
        
        LSEmotionToolBar *toolBar=[[LSEmotionToolBar alloc]init];
        toolBar.delegate=self;
        [self addSubview:toolBar];
        self.toolBar=toolBar;
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //    toolbar 的frame
    self.toolBar.width=LSScreenWidth;
    self.toolBar.height=LSEmotionTooBarHeight;
    self.toolBar.y=self.height-self.toolBar.height;
    //    listview的frame
    self.listView.width=LSScreenWidth;
    self.listView.height=self.height-LSEmotionTooBarHeight;
    
}
-(void)emotionToolBar:(LSEmotionToolBar *)toolBar buttonType:(LSEmotionToolBarButtonType)type
{
    switch (type) {
        case LSEmotionToolBarButtonTypeRecent:
            self.listView.emotions=[LSEmotionTool recentEmotions];
            break;
        case LSEmotionToolBarButtonTypeDefault:
            self.listView.emotions=[LSEmotionTool defaultEmotions ];
            break;
        case LSEmotionToolBarButtonTypeEmoji:
            self.listView.emotions=[LSEmotionTool emojiEmotions ];
            break;
        case LSEmotionToolBarButtonTypeLxh:
            self.listView.emotions=[LSEmotionTool lxhEmotions ];

            break;
        default:
            break;
    }
    
}

@end
