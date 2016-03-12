







//
//  LSOAuthViewController.m
//  JJFJ
//
//  Created by song on 15/10/8.
//  Copyright © 2015年 song. All rights reserved.
//

#import "LSOAuthViewController.h"
#import "LSAccount.h"
#import "LSAccountTool.h"
#import "AFNetworking.h"
#import "KVNProgress.h"
#import "MJExtension.h"
#import "LSChooseRootController.h"
#import "MBProgressHUD+MJ.h"
#import "LSHttpTool.h"
#import "AFNetworking.h"
#define LSBaseUrl @"https://api.weibo.com/oauth2/authorize"
#define LSClient_id @"2728137006"
#define LSRedirect_uri @"http://sns.whalecloud.com/sina2/callback"
#define LSClient_Secret @"0bdc33007cd19f9f2a8e8243aa513b3a"
@interface LSOAuthViewController ()<UIWebViewDelegate>
@property (nonatomic, assign) int *number;
@end

@implementation LSOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate=self;
    // 拼接URL字符串
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",LSBaseUrl,LSClient_id,LSRedirect_uri];
//    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:0 timeoutInterval:20];
    [webView loadRequest:request];
    
}
#pragma mark - UIWebViewDelegate'
-(void)webViewDidStartLoad:(UIWebView *)webView
{
//    [KVNProgress showWithStatus:@"正在加载中"];
//    [MBProgressHUD showMessage:@"正在加载中"];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [MBProgressHUD hideHUD];
    [KVNProgress dismiss];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *urlstring=[request.URL absoluteString];
    NSLog(@"urlstring==%@",urlstring);
    NSRange range=[urlstring rangeOfString:@"code="];
    if (range.length>0) {
        NSString *code=[urlstring substringFromIndex:range.location+range.length];
        [self accessTokenWithCode:code];
        
        return NO;
    }
    //
    return YES;
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
//    [MBProgressHUD hideHUD];
    [KVNProgress dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)accessTokenWithCode:(NSString *)code
{
    //根据code获取accessToken
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"client_id"]=LSClient_id;
    params[@"client_secret"]=LSClient_Secret;
    params[@"grant_type"]=@"authorization_code";
    params[@"code"]=code;
    params[@"redirect_uri"]=LSRedirect_uri;
    
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    manger.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
    
    [manger POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=(NSDictionary *)responseObject;
        NSLog(@"responseObject=%@",responseObject);
        LSAccount *account=[LSAccount  objectWithKeyValues:dict];
        account.currentAccount=YES;
        [LSAccountTool setCurrentAccount:account];
        [[LSAccountTool accountTool] addAccount:account];
        [LSChooseRootController chooseRootController:LSKeyWindow];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error.localizedDescription);
    }];
//    [LSHttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(id responseObject) {
//        NSDictionary *dict=(NSDictionary *)responseObject;
//        NSLog(@"responseObject=%@",responseObject);
//        LSAccount *account=[LSAccount  objectWithKeyValues:dict];
//        account.currentAccount=YES;
//        [LSAccountTool setCurrentAccount:account];
//        [[LSAccountTool accountTool] saveAccount:account];
//        [LSChooseRootController chooseRootController:LSKeyWindow];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
}


@end
