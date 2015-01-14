//
//  EFRDetailViewController.h
//  rss
//
//  Created by Ikai Masahiro on 2014/10/19.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EFRDetailViewController : UIViewController <UIWebViewDelegate, NADViewDelegate>

@property (copy, nonatomic) NSDictionary *articleDic;
@property (nonatomic, retain) NADView * nadView;

@end
