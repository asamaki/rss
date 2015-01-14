//
//  ItemViewController.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/03.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "ItemViewController.h"
#import "EFRHatenaParser.h"
#import "DetailViewController.h"
#import "CustomTableViewCell.h"
#import "BannerTableViewCell.h"
#import "UIImageView+WebCache.h"




@interface ItemViewController ()

@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) NSArray *json_articles;
@property (nonatomic) UITableView *tableView;
@property (readwrite) NSInteger page;
@property (nonatomic) BOOL scrollingToTop;
@property (strong, nonatomic) UIActivityIndicatorView *indicator;
@property (nonatomic) BOOL isShowAd;

@end

@implementation ItemViewController

- (id) initWithUrl:(NSString*)url
{
    if(self = [super init]){
        _url = url;
    }
    return self;
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
    
    self.nadViewLarge = [[NADView alloc] initWithFrame:CGRectMake(10, 50, 300, 250)];
    // (3) ログ出力の指定
    [self.nadViewLarge setIsOutputLog:YES];
    // (4) set apiKey, spotId.
    //[self.nadView setNendID:@"88d88a288fdea5c01d17ea8e494168e834860fd6" spotID:@"70356"];
    [self.nadViewLarge setNendID:@"45bf40d2088a566a8066027d05f173e79234c6f8" spotID:@"277133"];
    [self.nadViewLarge setDelegate:self]; //(5)
    [self.nadViewLarge load]; //(6)
    //[self.contentView addSubview:self.nadView]; // 最初から表示する場合
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
                                                            viewHeight - adViewHeight + statusBarHeight-self.tabBarController.tabBar.frame.size.height,
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

- (void)eulaAlart
{
    // NSUserDefaultsの取得
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // KEY_BOOLの内容を取得し、BOOL型変数へ格納
    BOOL isBool = [defaults boolForKey:@"KEY_BOOL1"];
    
    // isBoolがNOの場合、アラート表示
    if (!isBool) {
        
        NSString *body = @"投稿されているコンテンツで過度な暴力表現、性的表現などの投稿は削除される事があります。アプリの利用者は本アプリを利用に際し生じた一切の事象について運営者は責任を負わないことを承諾します。その他利用方法につきましてはhttp://gazo.asamaki.com/app_policy.phpを参照してください。";
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:body preferredStyle:UIAlertControllerStyleAlert];
        
        
        // addActionした順に左から右にボタンが配置されます
        [alertController addAction:[UIAlertAction actionWithTitle:@"同意する" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self otherButtonPushed];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"同意しない" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // cancelボタンが押された時の処理
            [self cancelButtonPushed];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
//        // KEY_BOOLにYESを設定
//        [defaults setBool:YES forKey:@"KEY_BOOL"];
//        
//        // 設定を保存
//        [defaults synchronize];
    }
}
- (void)cancelButtonPushed {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // KEY_BOOLにYESを設定
    [defaults setBool:NO forKey:@"KEY_BOOL1"];
    
    // 設定を保存
    [defaults synchronize];
    NSString *body = @"使用許諾契約に同意しないと本アプリは利用できません。";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:body preferredStyle:UIAlertControllerStyleAlert];
    
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"確認" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self eulaAlart];
    }]];

    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)otherButtonPushed {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // KEY_BOOLにYESを設定
    [defaults setBool:YES forKey:@"KEY_BOOL1"];
    
    // 設定を保存
    [defaults synchronize];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];


    

}
//- (void)viewDidLayoutSubviews
//{
//    CGRect frame = [[UIScreen mainScreen] applicationFrame];
//    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
//    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
//    //self.tableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
//    self.tableView.contentInset = UIEdgeInsetsMake(statusBarHeight+navigationBarHeight,0,0,0);
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    //GA_TRACK_CLASS;
    
    [self initBannerAd];
    
    _page = 1;
    self.articles = [self parseJson];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, 100)];
    
    CGRect frame = self.view.frame;
//    CGFloat tabBarHeight = self.tabBarController.tabBar.bounds.size.height;
//    float statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
//    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
//
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    
    //self.tableView.contentInset = UIEdgeInsetsMake(statusBarHeight+navigationBarHeight,0,0,0);
    //self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, navigationBarHeight+statusHeight)];
    self.tableView.backgroundColor = [UIColor colorWithRed:0.100 green:0.100 blue:0.100 alpha:1.000];
//    [self.tableView setContentOffset:CGPointMake(0,self.tableView.contentOffset.y-refreshControl.frame.size.height) animated:YES];
//    UIEdgeInsets insets = self.tableView.contentInset;
//    
//    insets.top += 50;
//    
//    self.tableView.contentInset = insets;
    //self.tableView.contentInset = UIEdgeInsetsMake(statusBarHeight+navigationBarHeight,0,0,0);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView addSubview:refreshControl];
    [self.view addSubview:self.tableView];
    [self.indicator setColor:[UIColor darkGrayColor]];
    [self.indicator setHidesWhenStopped:YES];
    [self.indicator stopAnimating];
    
    [self eulaAlart];
}

#pragma mark - 表示セルの一番下まできたら次のONCE_READ_COUNT件数取得
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.dragging || self.scrollingToTop) {
        if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height))
        {

            if([_indicator isAnimating]) {
                    return;
                }
            
                self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, 150)];
                [self startIndicator];
                [self performSelector:@selector(reloadMoreData) withObject:nil afterDelay:1.5f];
                
        }
    }
    if (self.isShowAd)
    {
        // スクロールしても、常に画面下に広告を表示する
        CGRect frame = [[UIScreen mainScreen] applicationFrame];
        float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
        float viewHeight = frame.size.height;
        float adViewWidth = self.nadView.frame.size.width;
        float adViewHeight = self.nadView.frame.size.height;
        
        self.nadView.frame = CGRectMake(0,
                                           viewHeight - adViewHeight + statusBarHeight -self.tabBarController.tabBar.frame.size.height,
                                           adViewWidth,
                                           adViewHeight);
        [self.view bringSubviewToFront:self.nadView];
    }
    
}

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
//    self.scrollingToTop = YES;
//    return YES;
//}
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
//    self.scrollingToTop = NO;
//}


- (void)reloadMoreData
{
    _page++;
    
    NSArray *moreArticles = [self parseJson];
    NSArray *currentArticles = self.articles;
    self.articles = [currentArticles arrayByAddingObjectsFromArray:moreArticles];
    
    //配列に追加する
    [self.tableView reloadData];
    [self endIndicator];
}

- (void)startIndicator
{
    [_indicator startAnimating];
    CGRect footerFrame = self.tableView.tableFooterView.frame;
    //footerFrame.size.height += 10.0f;
    
    [_indicator setFrame:footerFrame];
    [self.tableView setTableFooterView:_indicator];
}


- (void)endIndicator
{
    [_indicator stopAnimating];
    [_indicator removeFromSuperview];
    [self.tableView setTableFooterView:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *) parseJson{
    NSString *baseUrl = _url;
    if (_url == nil) {
        baseUrl = @"http://gazo.asamaki.com/items/json_app_2_0_0/";
    }
    NSString *pageString = [NSString stringWithFormat:@"%ld", (long)_page];
    NSString *requestUrl = [baseUrl stringByAppendingString:pageString];
//    NSLog(@"%ld",(long)_page);
//    NSLog(@"%@",requestUrl);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    NSData *json_raw_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jstr = [[NSString alloc] initWithData:json_raw_data encoding:NSUTF8StringEncoding];
    NSData *json_data = [jstr dataUsingEncoding:NSUnicodeStringEncoding];
    
    NSError *error=nil;
    NSMutableArray *jarray = [NSJSONSerialization JSONObjectWithData:json_data
                                                      options:NSJSONReadingMutableContainers
                                                        error:&error];
    if (jarray.count == 10) {
        [jarray addObject:[NSNull null]];
    }

    NSArray *mJarray = [jarray copy];
    return mJarray;
}
- (void)refreshControlValueChanged:(UIRefreshControl *)sender {
    _page = 1;
    self.articles = [self parseJson];
    [self.tableView reloadData];
    
    [sender endRefreshing];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",(long)self.articles.count);
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSString *cellIdentifier = @"Cell";
    //CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    // ぼけて形式の広告いれるときはnumberOfRowsInSectionで一つ多く数を申請しておいて、cellForRowAtIndexPathで一番下なら〜とif分で判定する
    
    NSInteger indexPathRowFooter = (indexPath.row + 1) % 11;
    NSLog(@"%ld",(long)indexPathRowFooter);
    NSString *CellIdentifier;
    
    
    if(indexPathRowFooter != 0){
        CellIdentifier = @"CustomCell";
    }else{
        CellIdentifier = @"BannerCell";
    }
    // Set cell identifier
    //static const id identifiers[2] = { @"CustomCell", @"BannerCell"};
    
    
    //NSString *CellIdentifier = identifiers[indexPath.row];
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
//        switch (indexPathRowFooter) {
//            case 0:
//                cell = [[BannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//                break;
//            default:
//                cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//                break;
//        }
        if([CellIdentifier  isEqual: @"BannerCell"]){
                cell = [[BannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }else{
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 
        }
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor =[UIColor colorWithRed:0.100 green:0.100 blue:0.100 alpha:0.000];
    
    //if(indexPathRowFooter != 0){
    if([CellIdentifier  isEqual: @"CustomCell"]){
        CustomTableViewCell *customCell = (CustomTableViewCell *)cell;
        customCell.titleLabel.text = self.articles[indexPath.row][TITLE];
        NSString *urlString = self.articles[indexPath.row][IMAGE];
        NSURL *url = [NSURL URLWithString:urlString];
        [customCell.customImageView sd_setImageWithURL:url
                                placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        customCell.titleLabel.textColor = [UIColor whiteColor];
    }else{
        BannerTableViewCell *bannerCell = (BannerTableViewCell *)cell;
        [bannerCell.contentView addSubview:self.nadViewLarge];

        //self.contentView addSubview:self.nadView];
    }
    
//    if(indexPath.row % 10 == 9){
//        BannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (nil == cell) {
//            cell = [[BannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        }
//        cell.backgroundColor =[UIColor colorWithRed:0.100 green:0.100 blue:0.100 alpha:0.000];
//        
//    }else{
//        CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//        if (nil == cell) {
//            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        cell.titleLabel.text = self.articles[indexPath.row][TITLE];
//        NSString *urlString = self.articles[indexPath.row][IMAGE];
//        NSURL *url = [NSURL URLWithString:urlString];
//        [cell.customImageView sd_setImageWithURL:url
//                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        cell.backgroundColor =[UIColor colorWithRed:0.100 green:0.100 blue:0.100 alpha:0.000];
//        cell.titleLabel.textColor = [UIColor whiteColor];
//    }
    

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // ハイライトを解除
    NSInteger indexPathRowFooter = (indexPath.row + 1) % 11;
    if (indexPathRowFooter == 0) {
        return ;
    }
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.articleDic = self.articles[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 350;
}
@end