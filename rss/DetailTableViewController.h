//
//  DetailViewController.h
//  rss
//
//  Created by Ikai Masahiro on 2014/11/09.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIButton *readButton;
@property (copy, nonatomic) NSDictionary *articleDic;

+ (NSDictionary *)loadBookmark;
@end
