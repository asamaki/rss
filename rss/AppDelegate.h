//
//  AppDelegate.h
//  rss
//
//  Created by Ikai Masahiro on 2014/10/16.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UIViewController* localViewController;
@property (strong, nonatomic) UIViewController* itemViewController;
@property (strong, nonatomic) UIViewController* dateItemViewController;
@property (strong, nonatomic) UIViewController* favoriteItemViewController;

@end

