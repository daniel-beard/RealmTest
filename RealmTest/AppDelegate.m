//
//  AppDelegate.m
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#import "AppDelegate.h"
#import "DBRealmMigrationHelper.h"

#import "DBRealmModel1.h"
#import "DBRealmModel2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DBRealmMigrationHelper migrateIfNeeded];
    
    DBRealmModel1 *model1 = [DBRealmModel1 new];
    model1.keyPrefix = @"prefix";
    model1.keySuffix = @"suffix";
    model1.normalizedURLString = @"test.com";
    model1.timestamp = [NSDate date];
    model1.responseData = @"123";
    [model1 persist];
    
    DBRealmModel2 *model2 = [DBRealmModel2 new];
    model2.modelId = @"1";
    model2.modelTerm = @"test";
    model2.timestamp = [NSDate date];
    [model2 persist];
    
    // Override point for customization after application launch.
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
