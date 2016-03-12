


//
//  LSComposeController.m
//  至美微博
//
//  Created by song on 15/10/11.
//  Copyright © 2015年 ls. All rights reserved.
//

#import "LSBaseSendViewController.h"

@interface LSBaseSendViewController ()
@property (nonatomic, weak) LSComposeToolBar *toolBar;

@property (nonatomic, strong) LSEmotionKeyboard *keyboard;
@property(nonatomic,assign,getter=isChangeKeyboard) BOOL changeKeyboard;
@end
@implementation LSBaseSendViewController

-(UIView *)keyboard
{
    if (_keyboard==nil) {
        _keyboard=[[LSEmotionKeyboard alloc]init];
        _keyboard.width=LSScreenWidth;
        _keyboard.height=216;
        _keyboard.y=LSScreenHeight-_keyboard.height;
    }
    return _keyboard;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //发微博底部显示昵称
    [self setupTitleView];
    
    //加载ToolBar
    [self setupNavBar];
    //加载textview
    [self setupTextView];
    [self setupToolBar];
    [self setupPhotosView];
    //监听键盘隐藏，弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide:) name:UIKeyboardWillHideNotification object:nil];
    
    //    监听表情按键发出的选中表情和删除表情通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedEmotion:) name:LSEmotionSelectedEmotionNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deletedEmotion) name:LSEmotionDeletedEmotionNotification object:nil];
    
    
}
-(void)setupTitleView
{
    //发微博底部显示昵称
    if ([LSAccountTool currentAccount].name) {
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(0, 0, 100, 44);
        label.numberOfLines=0;
        label.textAlignment=NSTextAlignmentCenter;
        NSString *pre=self.topTitle;
        NSString *name=[LSAccountTool currentAccount].name;
        NSString *newName=[NSString stringWithFormat:@"%@\n%@",pre,name];
        NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:newName];
        [attributeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[newName rangeOfString:pre]];
        
        [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[newName rangeOfString:name]];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0.4 alpha:1] range:[newName rangeOfString:name]];
        label.attributedText=attributeString;
        self.navigationItem.titleView=label;
        
    }else{
        self.title=self.title;
    }
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
    
}
//加载PhotosView
-(void)setupPhotosView
{
    LSComposePhotosView *photosView=[[LSComposePhotosView alloc]init];
    [self.textView addSubview:photosView];
    photosView.x=0;
    photosView.y=100;
    photosView.width=self.textView.width;
    photosView.height=self.textView.height;
    NSLog(@"textView.height===%lf",self.textView.height);
    self.photosView=photosView;
}
//加载ToolBar
-(void)setupToolBar
{
    LSComposeToolBar *toolBar=[[LSComposeToolBar alloc]init];
    toolBar.delegate=self;
    toolBar.x=0;
    toolBar.height=44;
    toolBar.width=self.view.width;
    toolBar.y=self.view.height-toolBar.height;
    self.toolBar=toolBar;
    [self.view addSubview:toolBar];
}
//加载textview
-(void)setupTextView
{
    LSEmotionTextView *textView=[[LSEmotionTextView alloc]init];
    textView.frame=self.view.bounds;
    textView.placeholder=self.placeholoder;
    [self.view addSubview:textView];
    self.textView=textView;
    textView.delegate=self;
    textView.alwaysBounceVertical=YES;
    
    
}
//加载导航栏
-(void)setupNavBar
{
    self.title=@"发微博";
    //取消按钮
    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    //关闭按钮
    UIBarButtonItem *send=[[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem= send;
    send.enabled=NO;
   
}
//取消
-(void)cancel
{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled=self.textView.attributedText.length!=0;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [scrollView resignFirstResponder];
}

//键盘显示通知回调方法
-(void)show:(NSNotification*)note
{
    
    NSLog(@"heigth=======%lf",[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.toolBar.transform=CGAffineTransformMakeTranslation(0, -[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height);
    }];
    NSLog(@"%lf",self.toolBar.y);
}
//键盘隐藏通知回调方法
-(void)hide:(NSNotification*)note
{
    if (self.isChangeKeyboard) return;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.toolBar.transform=CGAffineTransformIdentity;
    }];
}
#pragma mark - LSComposeToolBarDelegaete
-(void)composeToolBar:(LSComposeToolBar *)composeToolBar tag:(LSComposeButtonType)tag
{
    switch (tag) {
        case LSComposeButtonTypeMention:
            
            break;
        case LSComposeButtonTypePic:
            [self openAlbum];
            break;
        case LSComposeButtonTypeEmotion:
            [self openEmotion];
            break;
        case LSComposeButtonTypeTrend:
            
            break;
        case LSComposeButtonTypeAdd:
            
            break;
        default:
            break;
    }
}

//打开相册
-(void)openAlbum
{
    
    UIImagePickerController *pic=[[UIImagePickerController alloc]init];
    
    pic.delegate=self;
    pic.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pic animated:YES completion:nil];
    
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    [self.photosView addImageViewWithImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    //    NSLog(@"%@",info);
}
// 打开表情键盘
-(void)openEmotion
{
    
    if (self.textView.inputView) {//当前显示的是自定义键盘,切换为系统键盘
        self.textView.inputView=nil;
        self.toolBar.showEmotionButton=NO;
        
    }else{//当前显示的系统键盘,切换为自定义键盘
        self.toolBar.showEmotionButton=YES;
        self.textView.inputView=self.keyboard;
        
    }
    self.changeKeyboard=YES;//正在改变键盘
    [self.textView resignFirstResponder];
    self.changeKeyboard=NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textView becomeFirstResponder];
    });
    
    
}
-(void)selectedEmotion:(NSNotification*)note
{
    LSEmotion *emotion=note.userInfo[LSSelectedEmotion];
    [self addEmotion:emotion];
    NSLog(@"%@",emotion.chs);
    
}

-(void)setPlaceholoder:(NSString *)placeholoder
{
    _placeholoder=[placeholoder copy];
    self.textView.placeholder=placeholoder;
}
//添加表情
-(void)addEmotion:(LSEmotion*)emotion
{
    
    [self.textView addEmotion:emotion];
    [self textViewDidChange:self.textView];
    
}
//删除表情
-(void)deletedEmotion
{
    [self.textView deleteBackward];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)send
{}
@end
