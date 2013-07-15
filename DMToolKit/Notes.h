//
//  Notes.h
//  DMToolKit
//
//  Created by Bradford Farmer on 7/12/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Affiliations, Campaign, Character, Items, Location, Map, Player, Skills;

@interface Notes : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * externalid;
@property (nonatomic, retain) NSSet *affiliations;
@property (nonatomic, retain) NSSet *campaign;
@property (nonatomic, retain) NSSet *character;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) NSSet *location;
@property (nonatomic, retain) NSSet *map;
@property (nonatomic, retain) NSSet *player;
@property (nonatomic, retain) NSSet *skills;
@end

@interface Notes (CoreDataGeneratedAccessors)

- (void)addAffiliationsObject:(Affiliations *)value;
- (void)removeAffiliationsObject:(Affiliations *)value;
- (void)addAffiliations:(NSSet *)values;
- (void)removeAffiliations:(NSSet *)values;

- (void)addCampaignObject:(Campaign *)value;
- (void)removeCampaignObject:(Campaign *)value;
- (void)addCampaign:(NSSet *)values;
- (void)removeCampaign:(NSSet *)values;

- (void)addCharacterObject:(Character *)value;
- (void)removeCharacterObject:(Character *)value;
- (void)addCharacter:(NSSet *)values;
- (void)removeCharacter:(NSSet *)values;

- (void)addItemsObject:(Items *)value;
- (void)removeItemsObject:(Items *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

- (void)addLocationObject:(Location *)value;
- (void)removeLocationObject:(Location *)value;
- (void)addLocation:(NSSet *)values;
- (void)removeLocation:(NSSet *)values;

- (void)addMapObject:(Map *)value;
- (void)removeMapObject:(Map *)value;
- (void)addMap:(NSSet *)values;
- (void)removeMap:(NSSet *)values;

- (void)addPlayerObject:(Player *)value;
- (void)removePlayerObject:(Player *)value;
- (void)addPlayer:(NSSet *)values;
- (void)removePlayer:(NSSet *)values;

- (void)addSkillsObject:(Skills *)value;
- (void)removeSkillsObject:(Skills *)value;
- (void)addSkills:(NSSet *)values;
- (void)removeSkills:(NSSet *)values;

@end
