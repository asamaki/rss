//
//  DetailViewController.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/09.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+WebCache.h"
#import "EFRDetailViewController.h"

@interface DetailViewController ()

@property (nonatomic) BOOL isShowAd;

@end



@implementation DetailViewController{
    UILabel *label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //GA_TRACK_CLASS;
    [self initBannerAd];
    
    UIBarButtonItem* barButtonSave = [[UIBarButtonItem alloc]
                               initWithTitle:@"保存"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(loadActionSheet)];
    
    UIBarButtonItem* barButtonOut = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                      target:self
                                      action:@selector(loadActionSheetItemAction)];
    
    self.navigationItem.rightBarButtonItems = @[barButtonSave, barButtonOut];
    
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+500)];
    
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height);
    // ScrollViewのdelegateをViewController自身に設定
//    scrollView.delegate = self;
//    scrollView.minimumZoomScale = 1.0f;    // 最小拡大率
//    scrollView.maximumZoomScale = 3.0f;    // 最大拡大率
//    scrollView.zoomScale = 1.0f;           // 表示時の拡大率
    
    
    NSString *urlString = self.articleDic[IMAGE];
    NSURL *url = [NSURL URLWithString:urlString];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *img = [[UIImage alloc]initWithData:data];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 320)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView sd_setImageWithURL:url
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    //self.imageView.image = img;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleHeight;
    
    //self.imageView.BackgroundColor = [UIColor colorWithHue:3.61 saturation:0.09 brightness:0.99 alpha:1.0];

    scrollView.backgroundColor = [UIColor whiteColor];
    
    
//    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    saveButton.frame = CGRectMake(10, 400, 100, 50);
//    [saveButton setTitle:@"押してね" forState:UIControlStateNormal];
//    [saveButton addTarget:self action:@selector(saveBookmark) forControlEvents:UIControlEventTouchDown];
//
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 330, 320, 120)];
    
    //tableView.backgroundColor = [UIColor blueColor];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    readButton.frame = CGRectMake(10, 400, 300, 44);
    readButton.backgroundColor = [UIColor redColor];
    [readButton setTitle:@"元サイトで見る" forState:UIControlStateNormal];
    readButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [readButton addTarget:self action:@selector(pushWebView) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:tableView];
    [scrollView addSubview:self.imageView];
    //[scrollView addSubview:saveButton];
    //[scrollView addSubview:readButton];
    
}

- (void)saveBookmark{
    NSDictionary *dict = [DetailViewController loadBookmark];
    
    BOOL isExists = [dict.allKeys containsObject:self.articleDic[ID]];
    
    if (isExists) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"既にお気に入りに保存されています"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSMutableDictionary *newMutableDic = [NSMutableDictionary dictionary];
    if(dict){
        newMutableDic = [dict mutableCopy];
    }
    [newMutableDic setObject:self.articleDic forKey:self.articleDic[ID]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:newMutableDic forKey:@"bookmarks"];
    BOOL successful = [defaults synchronize];
    if (successful) {
        NSLog(@"%@", @"データの保存に成功しました。");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"お気に入りに保存しました！"
                              message:nil
                              delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
 
}

+ (NSDictionary *)loadBookmark{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [defaults dictionaryForKey:@"bookmarks"];
    if (dic) {
        for (id key in dic) {
            NSLog(@"%@, %@", key, [dic valueForKey:key]);
        }
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }
    return dic;
}

//+ (NSArray *)loadBookmark2{
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *array = [defaults arrayForKey:@"bookmarks2"];
//    if (array) {
//        for (NSString *data in array) {
//            NSLog(@"%@", data);
//        }
//    } else {
//        NSLog(@"%@", @"データが存在しません。");
//    }
//    return array;
//}

+ (void)deleteBookmark:(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [defaults dictionaryForKey:@"bookmarks"];
    NSMutableDictionary *newMutableDic = [NSMutableDictionary dictionary];
    if(dict){
        newMutableDic = [dict mutableCopy];
    }
    [newMutableDic removeObjectForKey:key];
    [defaults setObject:newMutableDic forKey:@"bookmarks"];
    BOOL successful = [defaults synchronize];
    if (successful) {
        NSLog(@"%@", @"データの削除に成功しました。");
    }
    
}

// この記事へのリンクをメールボタンイベント
- (void)sendToMailButtonTapEvent
{
    // メールビュー生成
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // メール件名
    [picker setSubject:@"無題"];
    
    // 添付画像
    //NSData *myData = [[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"Pandora_744_1392.jpg"], 1)];
    //[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"image"];
    
    // メール本文
    NSString *message = self.articleDic[IMAGE];
    message = [message stringByAppendingString:@" "];
    message = [message stringByAppendingString:self.articleDic[TITLE]];
    
    [picker setMessageBody:message isHTML:NO];
    
    // メールビュー表示
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)sendToNgMailButtonTapEvent
{
    // メールビュー生成
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    // メール件名
    [picker setSubject:@"不適切もしくは不愉快な画像の報告"];
    
    // 添付画像
    //NSData *myData = [[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"Pandora_744_1392.jpg"], 1)];
    //[picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"image"];
    
    // メール本文
    
    NSString *message = self.articleDic[TITLE];
    message = [message stringByAppendingString:@" ID:"];
    message = [message stringByAppendingString:self.articleDic[ID]];
    message = [message stringByAppendingString:@" は不適切もしくは不愉快な画像です。削除してください。"];

    
    [picker setMessageBody:message isHTML:NO];
    
    // メールビュー表示
    [self presentViewController:picker animated:YES completion:nil];
}

// アプリ内メーラーのデリゲートメソッド
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
            // キャンセル
            
            break;
        case MFMailComposeResultSaved:
            // 保存 (ここでアラート表示するなど何らかの処理を行う)
            
            break;
        case MFMailComposeResultSent:
            // 送信成功 (ここでアラート表示するなど何らかの処理を行う)
            
            break;
        case MFMailComposeResultFailed:
            // 送信失敗 (ここでアラート表示するなど何らかの処理を行う)
            
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)lineText {
    NSString *string = self.articleDic[IMAGE];
    //string = [string stringByAppendingString:@" http://google.co.jp"];
    
    //エンコード
    string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *LINEUrlString = [NSString
                               stringWithFormat:@"line://msg/text/%@", string];
    
    //LINEがインストールされているか確認。されていなければアラート→AppStoreを開く
    if ([[UIApplication sharedApplication]
         canOpenURL:[NSURL URLWithString:LINEUrlString]]) {
        [[UIApplication sharedApplication]
         openURL:[NSURL URLWithString:LINEUrlString]];
    } else {
        [self cannotOpenAlert];
    }
}

//画像を投稿
//-(void)lineImage {
//    UIImage *image = [UIImage imageNamed:@"test.png"];
//    
//    UIPasteboard *pasteboard;
//    
//    //iOS7.0以降では共有のクリップボードしか使えない。その際クリップボードが上書きされてしまうので注意。
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
//        pasteboard = [UIPasteboard generalPasteboard];
//    } else {
//        pasteboard = [UIPasteboard pasteboardWithUniqueName];
//    }
//    
//    [pasteboard setData:UIImagePNGRepresentation(image)
//      forPasteboardType:@"public.png"];
//    
//    NSString *LINEUrlString = [NSString stringWithFormat:@"line://msg/image/%@", pasteboard.name];
//    
//    //LINEがインストールされているか確認。されていなければアラート→AppStoreを開く
//    if ([[UIApplication sharedApplication]
//         canOpenURL:[NSURL URLWithString:LINEUrlString]]) {
//        [[UIApplication sharedApplication]
//         openURL:[NSURL URLWithString:LINEUrlString]];
//    } else {
//        [self cannotOpenAlert];
//    }
//}

//アラート
-(void)cannotOpenAlert{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"LINEがインストールされていません"
                          message:@"AppStoreを開いてLINEをインストールします。"
                          delegate:self
                          cancelButtonTitle:@"いいえ"
                          otherButtonTitles:@"はい", nil
                          ];
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0://いいえのとき
            break;
        case 1://はいのとき
            [[UIApplication sharedApplication]
             openURL:[NSURL
                      URLWithString:@"https://itunes.apple.com/jp/app/line/id443904275?mt=8"]];
            break;
    }
}

- (void)pushWebView {
    EFRDetailViewController *detailViewController = [[EFRDetailViewController alloc] init];
    detailViewController.articleDic = self.articleDic;
    detailViewController.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)loadActionSheetItemAction
{
    // コントローラを生成
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:nil
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Cancel用のアクションを生成
    UIAlertAction * cancelAction =
    [UIAlertAction actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Cancel button tapped.");
                           }];
    
    // Destructive用のアクションを生成
    UIAlertAction * mailAction =
    [UIAlertAction actionWithTitle:@"メールで共有"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [self sendToMailButtonTapEvent];
                           }];
    
    // OK用のアクションを生成
    UIAlertAction * lineAction =
    [UIAlertAction actionWithTitle:@"LINEで共有"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [self lineText ];
                           }];
    
    // OK用のアクションを生成
    UIAlertAction * ngAction =
    [UIAlertAction actionWithTitle:@"不適切な画像を報告"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [self sendToNgMailButtonTapEvent ];
                           }];
    
    // コントローラにアクションを追加
    [ac addAction:cancelAction];
    [ac addAction:mailAction];
    [ac addAction:lineAction];
    [ac addAction:ngAction];
    
    // アクションシート表示処理
    [self presentViewController:ac animated:YES completion:nil];
    
}

- (void)loadActionSheet
{
    // コントローラを生成
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:nil
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    // Cancel用のアクションを生成
    UIAlertAction * cancelAction =
    [UIAlertAction actionWithTitle:@"キャンセル"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"Cancel button tapped.");
                           }];
    
    // Destructive用のアクションを生成
    UIAlertAction * saveCameraRoleAction =
    [UIAlertAction actionWithTitle:@"画像を保存"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [self saveCameraRole];
                           }];
    
    // OK用のアクションを生成
    UIAlertAction * bookmarkAction =
    [UIAlertAction actionWithTitle:@"お気に入りに保存"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               [self saveBookmark ];
                           }];
    
    // コントローラにアクションを追加
    [ac addAction:cancelAction];
    [ac addAction:saveCameraRoleAction];
    [ac addAction:bookmarkAction];
    
    // アクションシート表示処理
    [self presentViewController:ac animated:YES completion:nil];
    
}
-(void)saveCameraRole
{
    SEL selector = @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:);
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, selector, NULL);
}

- (void)onCompleteCapture:(UIImage *)screenImage
 didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSString *message = @"画像をカメラロールに保存しました";
    if (error) message = @"画像の保存に失敗しました";
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:@""
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction * okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                               NSLog(@"OK button tapped.");
                           }];
    
    [ac addAction:okAction];
    
    // アラート表示処理
    [self presentViewController:ac animated:YES completion:nil];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"Cell";
    //CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    // ぼけて形式の広告いれるときはnumberOfRowsInSectionで一つ多く数を申請しておいて、cellForRowAtIndexPathで一番下なら〜とif分で判定する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    if(indexPath.row == 0){
        cell.accessoryType = UITableViewCellAccessoryNone;
        label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 310, 70)];
        label.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        //label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        //label.font = [UIFont systemFontOfSize:12];
        //label.backgroundColor = [UIColor redColor];
        label.text = self.articleDic[TITLE];
        label.numberOfLines = 0;
        
        [cell.contentView addSubview:label];
//        cell.textLabel.font = [UIFont systemFontOfSize:2.f];
//        cell.textLabel.text = self.articleDic[TITLE];
    }else if(indexPath.row == 1){
        //cell.textLabel.text = self.articleDic[TITLE];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"元サイトへ";
    }
    
    //cell.backgroundColor = [UIColor lightTextColor];

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // ハイライトを解除
    [self pushWebView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        return 70;
    }

    return 50;
}

+(float)adjustHeight:(NSString *)show_word label:(UILabel *)label{
    CGFloat fontSize = label.font.pointSize;
    float  labelWidth  = label.bounds.size.width;
    float  labelHeight = label.bounds.size.height;
//    float  lagelX      = label.frame.origin.x;
//    float  lagelY      = label.frame.origin.y;
//    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGSize size = CGSizeMake(labelWidth, labelHeight);
    
    CGRect totalRect = [show_word boundingRectWithSize:size
                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                            attributes:[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName]
                                               context:nil];
    float fitSizeHeight = totalRect.size.height;
    
    return fitSizeHeight;
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

/**
 * ScrollViewが拡大縮小されるたびに呼び出される
 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self updateImageCenter];
}

/**
 * ScrollViewの拡大縮小終了時に呼び出される
 */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(CGFloat)scale
{
    [self updateImageCenter];
}

/**
 * 拡大縮小された画像のサイズに合わせて中央座標を変更する
 */
- (void)updateImageCenter
{
    // 画像の表示サイズを取得
    CGSize imageSize = self.imageView.image.size;
    imageSize.width *= self.scrollView.zoomScale;
    imageSize.height *= self.scrollView.zoomScale;
    
    // サブスクロールビューのサイズを取得
    CGRect  bounds = self.scrollView.bounds;
    
    // イメージビューの中央の座標を計算
    CGPoint point;
    point.x = imageSize.width / 2;
    if (imageSize.width < bounds.size.width) {
        point.x += (bounds.size.width - imageSize.width) / 2;
    }
    point.y = imageSize.height / 2;
    if (imageSize.height < bounds.size.height) {
        point.y += (bounds.size.height - imageSize.height) / 2;
    }
    self.imageView.center = point;
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


@end
