//
//  FavoriteTableViewController.h
//  rss
//
//  Created by Ikai Masahiro on 2014/11/25.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteTableViewController : UITableViewController<NADViewDelegate>

@property (nonatomic, retain) NADView * nadView;
@property (nonatomic, retain) NADView * nadViewLarge;


@end
