//
//  EFRHatenaParser.h
//  rss
//
//  Created by Ikai Masahiro on 2014/10/16.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EFRHatenaParser : NSObject

+ (NSArray *)parseResultWithCategoryName:(NSString *)categoryName;

@end
