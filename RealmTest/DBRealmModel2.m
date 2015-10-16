//
//  DBRealmModel2.m
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#import "DBRealmModel2.h"
#import <Realm/Realm.h>

static NSString *const kRealmId = @"search.history";

@implementation DBRealmModel2

- (void)persist {
    NSError *error;
    RLMRealm *realm = [RLMRealm realmWithPath:[DBRealmModel2 realmPath] readOnly:NO error:&error];
    
    if (!realm) {
        NSLog(@"Error %@", error.localizedDescription);
    }
    
    self.compositePrimaryKey = [NSString stringWithFormat:@"%@%@", self.modelId, self.modelTerm];
    [realm transactionWithBlock:^{
        // Insert new object
        [DBRealmModel2 createOrUpdateInRealm:realm withValue:self];
        
        // Prune old models.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"modelId = %@", self.modelId];
        NSInteger maxHistory = 5;
        RLMResults *results = [[DBRealmModel2 objectsInRealm:realm withPredicate:predicate] sortedResultsUsingProperty:@"timestamp" ascending:NO];
        if (results.count > maxHistory) {
            DBRealmModel2 *oldestResult = [results objectAtIndex:maxHistory - 1];
            NSPredicate *oldPredicate = [NSPredicate predicateWithFormat:@"timestamp < %@ AND modelId = %@", oldestResult.timestamp, self.modelId];
            RLMResults *oldModels = [DBRealmModel2 objectsInRealm:realm withPredicate:oldPredicate];
            [realm deleteObjects:oldModels];
        }
    }];
}

+ (NSArray *)loadModelForModelId:(NSString *)modelId {
    NSError *error;
    RLMRealm *realm = [RLMRealm realmWithPath:[DBRealmModel2 realmPath]
                                     readOnly:NO
                                        error:&error];
    
    if (!realm) {
        NSLog(@"Error %@", error.localizedDescription);
    }
    
    // Return sorted by timestamp.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"modelId = %@", modelId];
    RLMResults *results = [[DBRealmModel2 objectsInRealm:realm withPredicate:predicate] sortedResultsUsingProperty:@"timestamp" ascending:NO];
    NSMutableArray *models = [NSMutableArray array];
    NSInteger maxHistory = 5;
    for (DBRealmModel2 *model in results) {
        if (models.count < maxHistory) {
            [models addObject:model.modelTerm];
        }
    }
    return [models copy];
}

+ (NSString *)primaryKey {
    return @"compositePrimaryKey";
}

+ (NSString *)realmPath {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] copy];
    
    return [cachePath stringByAppendingPathComponent:kRealmId];
}

@end
