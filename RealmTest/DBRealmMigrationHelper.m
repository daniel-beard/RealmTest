//
//  DBRealmMigrationHelper.m
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#import "DBRealmMigrationHelper.h"
#import <Realm/Realm.h>

#import "DBRealmModel1.h"
#import "DBRealmModel2.h"

@implementation DBRealmMigrationHelper

+ (void)migrateIfNeeded {
    // Default realm. Currently unused.
    // wrapped this in a dispatch once so we don't crash with schema already created. it happens on unit tests cause we need migrate.
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        RLMRealmConfiguration *defaultConfig = [RLMRealmConfiguration defaultConfiguration];
        defaultConfig.schemaVersion = 1;
        defaultConfig.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
            // We haven’t migrated anything yet, so oldSchemaVersion == 0
            if (oldSchemaVersion < 1) {
                // Nothing to do!
                // Realm will automatically detect new properties and removed properties
                // And will update the schema on disk automatically
            }
        };
        [RLMRealmConfiguration setDefaultConfiguration:defaultConfig];
        NSError *error = [RLMRealm migrateRealm:defaultConfig];
        NSLog(@"Error %@", error.localizedDescription);
        
        RLMRealmConfiguration *config = [DBRealmModel1 realmConfiguration];
        NSLog(@"Schema version = %@", @(config.schemaVersion));
        error = [RLMRealm migrateRealm:config];
        NSLog(@"Error %@", error.localizedDescription);
        error = [RLMRealm migrateRealm:[DBRealmModel2 realmConfiguration]];
        NSLog(@"Error %@", error.localizedDescription);
        
    });
}

@end
