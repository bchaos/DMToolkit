//
//  Campaign.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location, Map, Notes, Player;

@interface Campaign : NSManagedObject

@property (nonatomic, retain) NSString * briefDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *location;
@property (nonatomic, retain) Map *map;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) NSSet *players;
@end

@interface Campaign (CoreDataGeneratedAccessors)

- (void)addLocationObject:(Location *)value;
- (void)removeLocationObject:(Location *)value;
- (void)addLocation:(NSSet *)values;
- (void)removeLocation:(NSSet *)values;

- (void)addNotesObject:(Notes *)value;
- (void)removeNotesObject:(Notes *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSSet *)values;
- (void)removePlayers:(NSSet *)values;

@end
