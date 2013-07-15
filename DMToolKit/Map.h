//
//  Map.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Campaign, Items, Location, Map, NPC, Notes, Player,Encounter;

@interface Map : NSManagedObject

@property (nonatomic, retain) NSString * gridInfomation;
@property (nonatomic, retain) Campaign *campain;
@property (nonatomic, retain) Encounter *encounter;

@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Notes *notes;

@property (nonatomic, retain) NSSet *npcs;
@property (nonatomic, retain) NSSet *partyMembers;
@property (nonatomic, retain) NSSet *subMaps;
@property (nonatomic, retain) NSSet *treasure;
@end

@interface Map (CoreDataGeneratedAccessors)

- (void)addNpcsObject:(NPC *)value;
- (void)removeNpcsObject:(NPC *)value;
- (void)addNpcs:(NSSet *)values;
- (void)removeNpcs:(NSSet *)values;

- (void)addPartyMembersObject:(Player *)value;
- (void)removePartyMembersObject:(Player *)value;
- (void)addPartyMembers:(NSSet *)values;
- (void)removePartyMembers:(NSSet *)values;

- (void)addSubMapsObject:(Map *)value;
- (void)removeSubMapsObject:(Map *)value;
- (void)addSubMaps:(NSSet *)values;
- (void)removeSubMaps:(NSSet *)values;

- (void)addTreasureObject:(Items *)value;
- (void)removeTreasureObject:(Items *)value;
- (void)addTreasure:(NSSet *)values;
- (void)removeTreasure:(NSSet *)values;

@end
