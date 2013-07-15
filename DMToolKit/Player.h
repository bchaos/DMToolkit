//
//  Player.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Campaign, Character, Map, Notes;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Campaign *campaing;
@property (nonatomic, retain) NSSet *characters;
@property (nonatomic, retain) NSSet *map;
@property (nonatomic, retain) NSSet *notes;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(Character *)value;
- (void)removeCharactersObject:(Character *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

- (void)addMapObject:(Map *)value;
- (void)removeMapObject:(Map *)value;
- (void)addMap:(NSSet *)values;
- (void)removeMap:(NSSet *)values;

- (void)addNotesObject:(Notes *)value;
- (void)removeNotesObject:(Notes *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end
