//
//  DBRealmModel2.h
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBRealmProtocol.h"

@interface DBRealmModel2 : RLMObject <DBRealmProtocol>

@property NSString *modelId;
@property NSString *modelTerm;
@property NSDate *timestamp;
@property NSString *compositePrimaryKey;

- (void)persist;

@end
