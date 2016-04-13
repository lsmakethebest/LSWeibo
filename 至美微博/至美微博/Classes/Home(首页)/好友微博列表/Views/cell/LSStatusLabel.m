

//
//  LSStatusLabel.m
//  至美微博
//
//  Created by song on 15/10/25.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSStatusLabel.h"
#import "LSLink.h"
@interface LSStatusLabel ()
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) NSMutableArray *links;
@property (nonatomic, strong) LSLink *link;
@end
@implementation LSStatusLabel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        UITextView *textView=[[UITextView alloc]init];
        textView.editable=NO;
        textView.textContainerInset =UIEdgeInsetsMake(0, -5, 0, -5);
        textView.textAlignment=NSTextAlignmentLeft;
        textView.scrollEnabled=NO;
        textView.userInteractionEnabled=NO;
        textView.backgroundColor=[UIColor clearColor];
        [self addSubview:textView];
//                textView.backgroundColor=[UIColor redColor];
        self.textView=textView;
    }
    return self;
}
-(NSMutableArray *)links
{
    if (!_links) {
        _links=[NSMutableArray array];
        //遍历富文本
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
            NSString *linkText=attrs[LSHighLink];
            if (linkText==nil) return ;
            //创建一个链接
            LSLink *link=[[LSLink alloc]init];
            link.range=range;
            link.text=linkText;
            //设置选中字符的范围
            self.textView .selectedRange=range;
            
            NSMutableArray *rects=[NSMutableArray array];
            //算出选中字符的矩形框
            NSArray *selectRects=   [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *rect in selectRects) {
                if (rect.rect.size.width==0||rect.rect.size.height==0)continue;
                [rects addObject:rect];
            }
            link.rects=rects;
            [_links addObject:link];
        }];
        self.textView.selectedRange=NSMakeRange(0, 0);
        
    }
    return _links;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame=self.bounds;
    //    NSLog(@"%@",NSStringFromUIEdgeInsets(self.textView.textContainerInset));
//    self.textView.width=self.width+10;
    
}
-(void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText=attributedText;
    self.textView.attributedText=nil;
    self.textView.attributedText=attributedText;
//      NSLog(@"text.attributedText===%@",self.textView.attributedText.string);
    self.links=nil;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:touch.view];
    //得到被点击点的连接
    LSLink *link=[self touchLickWithPoint:point];
    //    显示选中view
    [self showLinkBackgroud:link];
    self.link=link;
}
-(void)showLinkBackgroud:(LSLink*)link
{
    for (UITextSelectionRect *selectedRect in link.rects) {
        UIView *bg=[[UIView alloc]init];
        bg.frame=selectedRect.rect;
        bg.tag=8888;
        bg.layer.cornerRadius=4;
        bg.backgroundColor=[UIColor colorWithRed:0 green:100/255.0 blue:100/255.0 alpha:0.2];
        [self addSubview:bg];
    }
}
/**
 返回当前view所在的控制器
 */
- (UIViewController*) viewController
{
    for (UIResponder *res=self.nextResponder;res!=nil ;res=res.nextResponder) {
        if ([res isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)res;
        }
    }
    return nil;
}
-(LSLink*)touchLickWithPoint:(CGPoint)point
{
    __block  LSLink *link=nil;
    [self.links enumerateObjectsUsingBlock:^(LSLink * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (UITextSelectionRect *selectRect in obj.rects) {
            if (CGRectContainsPoint(selectRect.rect, point)) {
                link=obj;
                break;
            }
        }
    }];
    return  link;
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:touch.view];
    //得到被点击点的连接
    LSLink *link=[self touchLickWithPoint:point];
    //    显示选中view
    if (self.link!=link&&link!=nil) {

        [self showLinkBackgroud:link];
    }else if (self.link!=link){
        [self removeAllBgView];
    }
    self.link=link;
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
    [self removeAllBgView];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    LSLink *link=[self touchLickWithPoint:point];
    if (link) {
            [self touchesCancelled:touches withEvent:event];
        UIAlertController *alert=    [UIAlertController alertControllerWithTitle:@"提示" message:link.text preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [[self viewController] presentViewController:alert animated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:LSSelectedLink object:nil userInfo:@{LSSelectedLinkKey:link.text}];
        return;
    }
    [self touchesCancelled:touches withEvent:event];
}
-(void)removeAllBgView
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *view in self.subviews) {
            if (view.tag==8888) {
                [view removeFromSuperview];
            }
        }
    });
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    LSLink *link= [self touchLickWithPoint:point];
    if (link) {
        return self;
    }
    else{
        return nil;
    }
}


@end
