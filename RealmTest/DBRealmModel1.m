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
    RLMRealm *realm = [RLMRealm realmWithPath:[self realmPath] readOnly:NO error:&error];
    
    if (!realm) {
        NSLog(@"Error %@", error.localizedDescription);
    }
    return [DBRealmModel1 objectInRealm:realm forPrimaryKey:keyPrefix];
}

- (void)persist {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RLMRealm *realm = [RLMRealm realmWithPath:[self.class realmPath] readOnly:NO error:&error];
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

+ (NSString *)realmPath {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] copy];
    
    return [cachePath stringByAppendingPathComponent:kRealmId];
}

@end
