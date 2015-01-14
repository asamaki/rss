//
//  ItemViewController.h
//  rss
//
//  Created by Ikai Masahiro on 2014/11/03.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NADViewDelegate>
-(id)initWithUrl:url;
@property (copy, nonatomic) NSString *url;
@property (nonatomic, retain) NADView * nadView;
@property (nonatomic, retain) NADView * nadViewLarge;


@end
