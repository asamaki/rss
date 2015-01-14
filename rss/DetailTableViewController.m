//
//  DetailViewController.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/09.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "DetailTableViewController.h"
#import "UIImageView+WebCache.h"
#import "EFRDetailViewController.h"

@implementation DetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem* barButton = [[UIBarButtonItem alloc]
                               initWithTitle:@"保存"
                               style:UIBarButtonItemStylePlain
                               target:self
                               action:@selector(loadActionSheet)];
    self.navigationItem.rightBarButtonItems = @[barButton];
    
    
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    // ScrollViewのdelegateをViewController自身に設定
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.5f;    // 最小拡大率
    scrollView.maximumZoomScale = 3.0f;    // 最大拡大率
    scrollView.zoomScale = 1.0f;           // 表示時の拡大率
    
    
    NSString *urlString = self.articleDic[IMAGE];
    NSURL *url = [NSURL URLWithString:urlString];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *img = [[UIImage alloc]initWithData:data];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320, 350)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView sd_setImageWithURL:url
                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];

    //self.imageView.image = img;
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleHeight;
    
    self.imageView.BackgroundColor = [UIColor colorWithHue:3.61 saturation:0.09 brightness:0.99 alpha:1.0];

    scrollView.backgroundColor = [UIColor lightGrayColor];
    
//    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    saveButton.frame = CGRectMake(10, 400, 100, 50);
//    [saveButton setTitle:@"押してね" forState:UIControlStateNormal];
//    [saveButton addTarget:self action:@selector(saveBookmark) forControlEvents:UIControlEventTouchDown];
//    
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    readButton.frame = CGRectMake(10, 400, 300, 44);
    //readButton.backgroundColor = [UIColor redColor];
    [readButton setTitle:@"元サイトで見る" forState:UIControlStateNormal];
    readButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [readButton addTarget:self action:@selector(pushWebView) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:self.imageView];
    //[scrollView addSubview:saveButton];
    [scrollView addSubview:readButton];
    
}

- (void)saveBookmark{
    NSDictionary *dict = [DetailTableViewController loadBookmark];
    
    BOOL isExists = [dict.allKeys containsObject:self.articleDic[ID]];
    
    if (isExists) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"既にお気に入りに登録されています"
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
                              initWithTitle:@"お気に入りに登録しました！"
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

+ (NSArray *)loadBookmark2{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults arrayForKey:@"bookmarks2"];
    if (array) {
        for (NSString *data in array) {
            NSLog(@"%@", data);
        }
    } else {
        NSLog(@"%@", @"データが存在しません。");
    }
    return array;
}

- (void)pushWebView {
    EFRDetailViewController *detailViewController = [[EFRDetailViewController alloc] init];
    detailViewController.articleDic = self.articleDic;
    detailViewController.hidesBottomBarWhenPushed= YES;
    [self.navigationController pushViewController:detailViewController animated:YES];
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
    [UIAlertAction actionWithTitle:@"Cancel"
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
    [UIAlertAction actionWithTitle:@"お気に入りに追加"
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
    
    NSString *message = @"画像を保存しました";
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



@end
