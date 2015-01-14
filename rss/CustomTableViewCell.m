//
//  CustomTableViewCell.m
//  rss
//
//  Created by Ikai Masahiro on 2014/11/08.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    //self.backgroundColor = [UIColor colorWithHue:0.61 saturation:0.09 brightness:0.99 alpha:1.0];
    
    if (self) {
        //メインテキスト
        self.titleLabel  = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 335, 40)];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.numberOfLines = 5;
        [self.contentView addSubview:self.titleLabel];
        
        self.customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 0.0, 0.0)];
//        self.customImageView.tag = 3;
//        self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
//        self.customImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleHeight;

        [self.contentView addSubview:self.customImageView];
    }
    
    //レイアウトをアップデート
    //[self updateLayout];
    
    return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    
    float desiredWidth = 320;
    float desiredHeight = 300;
    
//    UIScreen *screen = [UIScreen mainScreen];
//    CGRect rect = screen.bounds;
//    NSLog(@"%.2f, %.2f", rect.size.width, rect.size.height);
//    
    self.customImageView.frame = CGRectMake(0,50,desiredWidth,desiredHeight);
    self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.customImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleHeight;
    //self.customImageView.BackgroundColor = [UIColor colorWithHue:3.61 saturation:0.09 brightness:0.99 alpha:1.0];
    self.titleLabel.backgroundColor = [UIColor colorWithRed:0.100 green:0.100 blue:0.100 alpha:0.000];
    self.customImageView.BackgroundColor = [UIColor colorWithRed:0.100 green:0.100 blue:0.100 alpha:0.000];
    //self.customImageView.contentMode = UIViewContentModeScaleAspectFit;
}

//-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
//    if( highlighted ) {
//        //[self setBackgroundColor:[UIColor colorWithRed:0.100 green:0.100 blue:0.100 alpha:0.000]];
//         self.selectionStyle = UITableViewCellSelectionStyleGray;
//    }
//}


@end
