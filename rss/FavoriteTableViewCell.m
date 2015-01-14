//
//  FavoriteTableViewCell.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/27.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "FavoriteTableViewCell.h"

@implementation FavoriteTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //self.backgroundColor = [UIColor colorWithHue:0.61 saturation:0.09 brightness:0.99 alpha:1.0];
    
    if (self) {
        //メインテキスト
        self.titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 0.0)];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.customImageView];
    }
    return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    
    float desiredWidth = 80;
    float desiredHeight = 100;
    
    self.titleLabel.frame = CGRectMake(desiredWidth+20,20, 200,60);
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.numberOfLines = 5;
    
    self.customImageView.frame = CGRectMake(10,0,desiredWidth,desiredHeight);
    self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.customImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleHeight;
    //self.customImageView.BackgroundColor = [UIColor colorWithHue:3.61 saturation:0.09 brightness:0.99 alpha:1.0];
}

@end
