//
//  AppDelegate.m
//  WellMap
//
//  Created by 同筑科技 on 2017/6/23.
//  Copyright © 2017年 well. All rights reserved.
//

//百度地图
#define BMK_KEY @"kt6uSu35c51BHEeAM2HRuz32YYLGb8zP"//百度地图的key

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import "AppDelegate.h"

@interface AppDelegate ()<BMKGeneralDelegate>

@property (nonatomic,strong) BMKMapManager* mapManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    //百度地图
    self.mapManager = [BMKMapManager new];
    BOOL ret = [self.mapManager start:BMK_KEY generalDelegate:nil];
    if (!ret)
    {
        NSLog(@"百度地图启动失败");
    }
    else
    {
        NSLog(@"百度地图启动成功");
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
