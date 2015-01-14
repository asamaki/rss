//
//  DetailViewController.h
//  rss
//
//  Created by Ikai Masahiro on 2014/11/09.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface DetailViewController : UIViewController <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate,NADViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIButton *readButton;
@property (copy, nonatomic) NSDictionary *articleDic;
@property (nonatomic, retain) NADView * nadView;
@property (nonatomic, retain) NADView * nadViewLarge;

+ (NSDictionary *)loadBookmark;
+ (void) deleteBookmark:(NSString*)key;
@end
