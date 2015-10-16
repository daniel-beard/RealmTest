//
//  DBRealmModel1.h
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBRealmProtocol.h"

@interface DBRealmModel1 : RLMObject <DBRealmProtocol>

// Primary key
@property NSString *keyPrefix;
@property NSString *keySuffix;
@property NSString *normalizedURLString;
@property NSDate *timestamp;
@property NSString *responseData;

- (void)persist;

@end
