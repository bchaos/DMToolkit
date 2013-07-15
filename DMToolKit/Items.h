//
//  Items.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Location, Map, NPC, Notes, Spells;

@interface Items : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * subtype;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * fulltext;
@property (nonatomic, retain) NSSet *character;
@property (nonatomic, retain) NSSet *location;
@property (nonatomic, retain) NSSet *map;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) NSSet *npcItems;
@property (nonatomic, retain) NSSet *npcTreasure;
@property (nonatomic, retain) NSSet *spells;
@property (nonatomic, retain) NSSet *encounter;
@end

@interface Items (CoreDataGeneratedAccessors)

- (void)addCharacterObject:(Character *)value;
- (void)removeCharacterObject:(Character *)value;
- (void)addCharacter:(NSSet *)values;
- (void)removeCharacter:(NSSet *)values;

- (void)addLocationObject:(Location *)value;
- (void)removeLocationObject:(Location *)value;
- (void)addLocation:(NSSet *)values;
- (void)removeLocation:(NSSet *)values;

- (void)addMapObject:(Map *)value;
- (void)removeMapObject:(Map *)value;
- (void)addMap:(NSSet *)values;
- (void)removeMap:(NSSet *)values;

- (void)addNotesObject:(Notes *)value;
- (void)removeNotesObject:(Notes *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

- (void)addNpcItemsObject:(NPC *)value;
- (void)removeNpcItemsObject:(NPC *)value;
- (void)addNpcItems:(NSSet *)values;
- (void)removeNpcItems:(NSSet *)values;

- (void)addNpcTreasureObject:(NPC *)value;
- (void)removeNpcTreasureObject:(NPC *)value;
- (void)addNpcTreasure:(NSSet *)values;
- (void)removeNpcTreasure:(NSSet *)values;

- (void)addSpellsObject:(Spells *)value;
- (void)removeSpellsObject:(Spells *)value;
- (void)addSpells:(NSSet *)values;
- (void)removeSpells:(NSSet *)values;

- (void)addEncounterObject:(NSManagedObject *)value;
- (void)removeEncounterObject:(NSManagedObject *)value;
- (void)addEncounter:(NSSet *)values;
- (void)removeEncounter:(NSSet *)values;

@end
