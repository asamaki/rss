//
//  FavoriteTableViewController.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/25.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "FavoriteTableViewController.h"
#import "DetailViewController.h"
#import "FavoriteTableViewCell.h"

@interface FavoriteTableViewController ()

@property (nonatomic) BOOL isShowAd;

@end

@implementation FavoriteTableViewController{
    NSMutableArray *_articles;
    UITableView *_tableView;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    NSDictionary *articlesDic = [DetailViewController loadBookmark];
    NSArray *articles = [articlesDic allValues];
    _articles = [articles mutableCopy];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBannerAd];
    //GA_TRACK_CLASS;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINSIZE.width, 60)];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.view addSubview:_tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", (unsigned long)_articles.count);
    return _articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell_Favorite";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    // ぼけて形式の広告いれるときはnumberOfRowsInSectionで一つ多く数を申請しておいて、cellForRowAtIndexPathで一番下なら〜とif分で判定する
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell) {
        cell = [[FavoriteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
//    cell.titleLabel.text = _articles[indexPath.row][TITLE];
//    NSString *urlString = _articles[indexPath.row][IMAGE];
//    NSURL *url = [NSURL URLWithString:urlString];
//
//    [cell.customImageView sd_setImageWithURL:url
//                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.titleLabel.text = _articles[indexPath.row][TITLE];
    NSString *urlString = _articles[indexPath.row][IMAGE];
    NSURL *url = [NSURL URLWithString:urlString];
    
    [cell.customImageView sd_setImageWithURL:url
                            placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // ハイライトを解除
    
    DetailViewController *detailViewController = [[DetailViewController alloc] init];
    detailViewController.articleDic = _articles[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        

        //[DetailViewController deleteBookmark:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        [DetailViewController deleteBookmark:_articles[indexPath.row][ID]];
        [_articles removeObjectAtIndex:indexPath.row]; // 削除ボタンが押された行のデータを配列から削除します。
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // ここは空のままでOKです。
    }
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (self.isShowAd)
//    {
//        // スクロールしても、常に画面下に広告を表示する
//        CGRect frame = [[UIScreen mainScreen] applicationFrame];
//        //float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
//        float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
//        float viewHeight = frame.size.height;
//        float adViewWidth = self.nadView.frame.size.width;
//        float adViewHeight = self.nadView.frame.size.height;
//        
//        self.nadView.frame = CGRectMake(0,
//                                       viewHeight  - navigationBarHeight -adViewHeight - self.tabBarController.tabBar.frame.size.height,
//                                        adViewWidth,
//                                        adViewHeight);
//        [self.view bringSubviewToFront:self.nadView];
//    }
//    
//}

- (void) initBannerAd
{
    self.isShowAd = YES;
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0,
                                                             0,
                                                             WINSIZE.width,
                                                             WINSIZE.height)];
    self.nadView.delegate = self;
    // (3) ログ出力の指定
    [self.nadView setIsOutputLog:YES];
    // (4) set apiKey, spotId.
    [self.nadView setNendID:@"9f847cf06b9b396bd1b31a91f44fbcf1f1c656f8" spotID:@"17064"];
    //[self.nadView setNendID:@"a6eca9dd074372c898dd1df549301f277c53f2b9" spotID:@"3172"];
    [self.nadView setDelegate:self]; //(5)
    [self.nadView load]; //(6)
    [self.view addSubview:self.nadView]; // 最初から表示する場合
}

//- (void) nadViewDidReceiveAd:(NADView *)adView;
//{
//    self.isShowAd = YES;
//    
//    CGRect frame = [[UIScreen mainScreen] applicationFrame];
//    float viewHeight = frame.size.height;
//    //float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
//    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
//    float adViewWidth = self.nadView.frame.size.width;
//    float adViewHeight = self.nadView.frame.size.height;
//    [self.view bringSubviewToFront:self.nadView];
//    
//    [UIView animateWithDuration:1.0
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         self.nadView.frame = CGRectMake(0,
//                                                         viewHeight  - navigationBarHeight -adViewHeight - self.tabBarController.tabBar.frame.size.height,
//                                                         adViewWidth,
//                                                         adViewHeight);
//                         
//                         self.nadView.alpha = 1.0;
//                     }
//                     completion:nil];
//    [self.view addSubview:self.nadView];
//}
- (void) nadViewDidFailToReceiveAd:(NADView *)adView;
{
    self.isShowAd = NO;
    
}

@end
