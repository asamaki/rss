//
//  BannerTableViewCell.m
//  rss
//
//  Created by Ikai Masahiro on 2014/12/02.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "BannerTableViewCell.h"

@implementation BannerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    //[self initBannerAd];
    }
    return self;
}

- (void) initBannerAd
{
    self.nadView = [[NADView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    // (3) ログ出力の指定
    [self.nadView setIsOutputLog:YES];
    // (4) set apiKey, spotId.
    //[self.nadView setNendID:@"88d88a288fdea5c01d17ea8e494168e834860fd6" spotID:@"70356"];
    [self.nadView setNendID:@"45bf40d2088a566a8066027d05f173e79234c6f8" spotID:@"277133"];
    [self.nadView setDelegate:self]; //(5)
    [self.nadView load]; //(6)
    [self.contentView addSubview:self.nadView]; // 最初から表示する場合
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
//    float desiredWidth = 80;
//    float desiredHeight = 100;
//    
//    self.titleLabel.frame = CGRectMake(desiredWidth+20,20, 200,60);
//    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    self.titleLabel.font = [UIFont systemFontOfSize:15];
//    self.titleLabel.numberOfLines = 5;
//    
//    self.customImageView.frame = CGRectMake(10,0,desiredWidth,desiredHeight);
//    self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.customImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleHeight;
    //self.customImageView.BackgroundColor = [UIColor colorWithHue:3.61 saturation:0.09 brightness:0.99 alpha:1.0];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
