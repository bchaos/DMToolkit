//
//  Encounter.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Items, NPC, Map;

@interface Encounter : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSSet *monsters;
@property (nonatomic, retain) NSSet *possibleTreasure;
@property (nonatomic, retain) Map *map;
@end

@interface Encounter (CoreDataGeneratedAccessors)

- (void)addMonstersObject:(NPC *)value;
- (void)removeMonstersObject:(NPC *)value;
- (void)addMonsters:(NSSet *)values;
- (void)removeMonsters:(NSSet *)values;

- (void)addPossibleTreasureObject:(Items *)value;
- (void)removePossibleTreasureObject:(Items *)value;
- (void)addPossibleTreasure:(NSSet *)values;
- (void)removePossibleTreasure:(NSSet *)values;

@end
