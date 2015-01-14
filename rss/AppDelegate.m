//
//  AppDelegate.m
//  rss
//
//  Created by Ikai Masahiro on 2014/10/16.
//  Copyright (c) 2014年 Ikai Masahiro. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ItemViewController.h"
#import "DateItemViewController.h"
#import "FavoriteTableViewController.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //GA_INIT_TRACKER(20, @"UA-40504452-2");
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.itemViewController = [[ItemViewController alloc]init];
    [self.itemViewController setTitle:@"最新画像"];
    UINavigationController* navigationController1 = [[UINavigationController alloc] initWithRootViewController:self.itemViewController];
    //navigationController1.navigationBar.tintColor = [UIColor blackColor];  // バーアイテムカラー
    //navigationController1.navigationBar.barTintColor = [UIColor whiteColor];  // バー背景色
    
    UITabBarItem *tabItem1 = [[UITabBarItem alloc] initWithTitle:@"最新画像"
                                                           image:[[UIImage alloc]
                                                                  initWithContentsOfFile:[[NSBundle mainBundle]
                                                                                          pathForResource:@"stack_of_photos-60@2x"
                                                                                          ofType:@"png"]]
                                                             tag:0];
    self.itemViewController.tabBarItem = tabItem1;
    
    self.dateItemViewController = [[DateItemViewController alloc]init];
    [self.dateItemViewController setTitle:@"過去画像"];
    UINavigationController* navigationController2 = [[UINavigationController alloc] initWithRootViewController:self.dateItemViewController];
    UITabBarItem *tabItem2 = [[UITabBarItem alloc] initWithTitle:@"過去画像"
                                                           image:[[UIImage alloc]
                                                                  initWithContentsOfFile:[[NSBundle mainBundle]
                                                                                          pathForResource:@"clock-60@2x"
                                                                                          ofType:@"png"]]
                                                             tag:0];
    self.dateItemViewController.tabBarItem = tabItem2;
    
 
    
    self.favoriteItemViewController = [[FavoriteTableViewController alloc]init];
    [self.favoriteItemViewController setTitle:@"お気に入り"];
    UINavigationController* navigationController3 = [[UINavigationController alloc] initWithRootViewController:self.favoriteItemViewController];
    UITabBarItem *tabItem3 = [[UITabBarItem alloc] initWithTitle:@"お気に入り"
                                                           image:[[UIImage alloc]
                                                                initWithContentsOfFile:[[NSBundle mainBundle]
                                                                                        pathForResource:@"star-60@2x"
                                                                                        ofType:@"png"]]
                                                             tag:0];
    self.favoriteItemViewController.tabBarItem = tabItem3;

    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:0.040 green:0.040 blue:0.040 alpha:1.000];
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.040 green:0.040 blue:0.040 alpha:1.000];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    // ナビゲーションバーのタイトルの色を変更
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];

    self.tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navigationController1,navigationController2, navigationController3, nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.rootViewController = self.tabBarController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
                                             
    //ViewController *viewController = [[ViewController alloc]init];
    //self.navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    //self.window.rootViewController = self.navigationController;
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
