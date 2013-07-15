//
//  Spells.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Domain, Items, NPC;

@interface Spells : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subschool;
@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSString * fulltext;
@property (nonatomic, retain) NSSet *character;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) NSSet *npc;
@property (nonatomic, retain) NSSet *domain;
@end

@interface Spells (CoreDataGeneratedAccessors)

- (void)addCharacterObject:(Character *)value;
- (void)removeCharacterObject:(Character *)value;
- (void)addCharacter:(NSSet *)values;
- (void)removeCharacter:(NSSet *)values;

- (void)addItemsObject:(Items *)value;
- (void)removeItemsObject:(Items *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

- (void)addNpcObject:(NPC *)value;
- (void)removeNpcObject:(NPC *)value;
- (void)addNpc:(NSSet *)values;
- (void)removeNpc:(NSSet *)values;

- (void)addDomainObject:(Domain *)value;
- (void)removeDomainObject:(Domain *)value;
- (void)addDomain:(NSSet *)values;
- (void)removeDomain:(NSSet *)values;

@end
