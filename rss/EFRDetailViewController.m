//
//  EFRDetailViewController.m
//  rss
//
//  Created by Ikai Masahiro on 2014/10/19.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "EFRDetailViewController.h"

@interface EFRDetailViewController ()<UIWebViewDelegate>
@property (nonatomic) BOOL isShowAd;

@end

@implementation EFRDetailViewController{
    UIWebView* webView;
    UIBarButtonItem* reloadButton;
    UIBarButtonItem* stopButton;
    UIBarButtonItem* backButton;
    UIBarButtonItem* forwardButton;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        //custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
    self.title = self.articleDic[TITLE];
    [self.navigationController setToolbarHidden:NO animated:NO];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, WINSIZE.height)];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    reloadButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                               target:self
                                                               action:@selector(reloadDidPush)];
    
    stopButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                               target:self
                                                               action:@selector(stopDidPush)];
    
    backButton = [[UIBarButtonItem alloc]initWithTitle:@"<"
                                                 style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(backDidPush)];
    
    forwardButton = [[UIBarButtonItem alloc]initWithTitle:@">"
                                                 style:UIBarButtonItemStylePlain
                                                target:self
                                                action:@selector(fowardDidPush)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                               target:nil action:nil];
    
    NSArray* buttons = [NSArray arrayWithObjects:spacer, backButton, spacer, forwardButton, spacer, reloadButton, spacer, stopButton, spacer, nil];
    [self setToolbarItems:buttons animated:YES];
    [self initBannerAd];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated {
    if (webView.isLoading) {
        [webView stopLoading];
    }
    
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void)reloadDidPush
{
    [webView reload];
}
-(void) stopDidPush
{
    if(webView.loading){
        [webView stopLoading];
    }
}
-(void)backDidPush
{
    if(webView.canGoBack){
        [webView goBack];
    }
}
-(void)fowardDidPush
{
    if(webView.canGoForward){
        [webView goForward];
    }
}

-(void)updateControllEnabled
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = webView.loading;
    stopButton.enabled = webView.loading;
    backButton.enabled = webView.canGoBack;
    forwardButton.enabled = webView.canGoBack;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSURL *url = [NSURL URLWithString:self.articleDic[LINK]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    [self updateControllEnabled];
}



#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self updateControllEnabled];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateControllEnabled];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self updateControllEnabled];
}

- (void) initBannerAd
{
    self.isShowAd = NO;
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0,
                                                             self.view.frame.size.height,
                                                             0,
                                                             0)];
    self.nadView.delegate = self;
    // (3) ログ出力の指定
    [self.nadView setIsOutputLog:YES];
    // (4) set apiKey, spotId.
    [self.nadView setNendID:@"9f847cf06b9b396bd1b31a91f44fbcf1f1c656f8" spotID:@"17064"];
    //[self.nadView setNendID:@"a6eca9dd074372c898dd1df549301f277c53f2b9" spotID:@"3172"];
    [self.nadView setDelegate:self]; //(5)
    [self.nadView load]; //(6)
    //[self.view addSubview:self.nadView]; // 最初から表示する場合
}

- (void) nadViewDidReceiveAd:(NADView *)adView;
{
    self.isShowAd = YES;
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float viewHeight = frame.size.height;
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    float adViewWidth = self.nadView.frame.size.width;
    float adViewHeight = self.nadView.frame.size.height;
    [self.view bringSubviewToFront:self.nadView];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.nadView.frame = CGRectMake(0,
                                                         viewHeight - adViewHeight + statusBarHeight-self.navigationController.toolbar.frame.size.height,
                                                         adViewWidth,
                                                         adViewHeight);
                         
                         self.nadView.alpha = 1.0;
                     }
                     completion:nil];
    [self.view addSubview:self.nadView];
}
- (void) nadViewDidFailToReceiveAd:(NADView *)adView;
{
    self.isShowAd = NO;
    
}
@end


