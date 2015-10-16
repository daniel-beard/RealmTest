//
//  DBRealmProtocol.h
//  RealmTest
//
//  Created by Daniel Beard on 10/15/15.
//  Copyright © 2015 DanielBeard. All rights reserved.
//

#ifndef DBRealmProtocol_h
#define DBRealmProtocol_h

#import <Realm/Realm.h>

@protocol DBRealmProtocol <NSObject>

+ (RLMRealmConfiguration *)realmConfiguration;

@end

#endif /* DBRealmProtocol_h */
