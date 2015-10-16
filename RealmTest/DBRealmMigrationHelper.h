//
//  DBRealmMigrationHelper.h
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBRealmMigrationHelper : NSObject

+ (void)migrateIfNeeded;

@end
