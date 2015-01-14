//
//  DateItemViewController.h
//  rss
//
//  Created by Ikai Masahiro on 2014/11/20.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateItemViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,NADViewDelegate>

@property(nonatomic) UIButton* button;
@property (nonatomic, retain) NADView * nadView;

@end
