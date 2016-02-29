//
//  DBRealmModel1.m
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#import "DBRealmModel1.h"
#import <Realm/Realm.h>

static NSString *const kRealmId = @"cache.channel";

@implementation DBRealmModel1

+ (DBRealmModel1 *)loadCachedModelForKeyPrefix:(NSString *)keyPrefix {
    NSError *error;
    RLMRealm *realm = [RLMRealm realmWithConfiguration:[self realmConfiguration] error:&error];
    
    if (!realm) {
        NSLog(@"Error %@", error.localizedDescription);
    }
    return [DBRealmModel1 objectInRealm:realm forPrimaryKey:keyPrefix];
}

- (void)persist {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RLMRealm *realm = [RLMRealm realmWithConfiguration:[self.class realmConfiguration] error:&error];
        if (!realm) {
            NSLog(@"Error %@", error.localizedDescription);
        }
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:self];
        [realm commitWriteTransaction];
    });
}

#pragma mark - Private Methods

+ (NSString *)primaryKey {
    return @"keyPrefix";
}

+ (RLMRealmConfiguration *)realmConfiguration {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] copy];
    NSString *realmPath = [cachePath stringByAppendingPathComponent:kRealmId];
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.path = realmPath;
    config.readOnly = NO;
    
    config.schemaVersion = 2;
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {


    [migration enumerateObjects:DBRealmModel1.className
                          block:^(RLMObject *oldObject, RLMObject *newObject) {
                              // We haven’t migrated anything yet, so oldSchemaVersion == 0
                              if (oldSchemaVersion < 1) {
                                  // Nothing to do!
                                  // Realm will automatically detect new properties and removed properties
                                  // And will update the schema on disk automatically
                              }

                                // Add the 'test' property to Realms with a schema version of 0 or 1
                                if (oldSchemaVersion < 2) {
                                    newObject[@"test"] = @"";
                                }
                          }];
    };
    return config;
}

@end
