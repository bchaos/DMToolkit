//
//  Location.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Campaign, Character, Items, Map, NPC, Notes;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * gridPoint;
@property (nonatomic, retain) Campaign *campaign;
@property (nonatomic, retain) NSSet *character;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) NSSet *map;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) NSSet *npc;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addCharacterObject:(Character *)value;
- (void)removeCharacterObject:(Character *)value;
- (void)addCharacter:(NSSet *)values;
- (void)removeCharacter:(NSSet *)values;

- (void)addItemsObject:(Items *)value;
- (void)removeItemsObject:(Items *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

- (void)addMapObject:(Map *)value;
- (void)removeMapObject:(Map *)value;
- (void)addMap:(NSSet *)values;
- (void)removeMap:(NSSet *)values;

- (void)addNotesObject:(Notes *)value;
- (void)removeNotesObject:(Notes *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

- (void)addNpcObject:(NPC *)value;
- (void)removeNpcObject:(NPC *)value;
- (void)addNpc:(NSSet *)values;
- (void)removeNpc:(NSSet *)values;

@end
