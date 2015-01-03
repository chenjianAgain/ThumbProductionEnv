//
//  AppDelegate.m
//  ThumbProductionEnvironment
//
//  Created by joseph on 15/1/3.
//  Copyright (c) 2015年 joseph. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setNavigationBarAndTabbar];
    return YES;
}

#pragma mark - nav and tabbar appearence

- (void)setNavigationBarAndTabbar
{
    //设置tabbaritem
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    
    //设置navigationbar
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont systemFontOfSize:20]
                                                           }];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置statusbar
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self hideTableViewFooter:[UITableView appearance]];
    [[UITableView appearance] setBackgroundColor:[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1]];
}

- (void)hideTableViewFooter: (UITableView *)tableView
{
    UIView* view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = view;
}


@end
