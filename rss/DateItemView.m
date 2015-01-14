//
//  DateItemView.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/20.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "DateItemView.h"

@implementation DateItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    saveButton.frame = CGRectMake(10, 400, 100, 50);
    [saveButton setTitle:@"押してね" forState:UIControlStateNormal];
    [self addSubview:saveButton];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
