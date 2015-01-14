//
//  BannerTableViewCell.h
//  rss
//
//  Created by Ikai Masahiro on 2014/12/02.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerTableViewCell : UITableViewCell <NADViewDelegate>
@property (nonatomic, retain) NADView * nadView;
@end
