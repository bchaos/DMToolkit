//
//  NPC.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Affiliations, Character, CharacterClass, Domain, Feats, Items, Location, Map, Race, Skills, Spells;

@interface NPC : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * fulltext;
@property (nonatomic, retain) NSNumber * isMonster;
@property (nonatomic, retain) NSSet *affiliations;
@property (nonatomic, retain) Character *companion;
@property (nonatomic, retain) NSSet *domain;
@property (nonatomic, retain) NSSet *feats;
@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSSet *map;
@property (nonatomic, retain) NSSet *npcClass;
@property (nonatomic, retain) NSSet *race;
@property (nonatomic, retain) NSSet *skills;
@property (nonatomic, retain) NSSet *spells;
@property (nonatomic, retain) NSSet *treasure;
@property (nonatomic, retain) NSSet *encounterApart;
@end

@interface NPC (CoreDataGeneratedAccessors)

- (void)addAffiliationsObject:(Affiliations *)value;
- (void)removeAffiliationsObject:(Affiliations *)value;
- (void)addAffiliations:(NSSet *)values;
- (void)removeAffiliations:(NSSet *)values;

- (void)addDomainObject:(Domain *)value;
- (void)removeDomainObject:(Domain *)value;
- (void)addDomain:(NSSet *)values;
- (void)removeDomain:(NSSet *)values;

- (void)addFeatsObject:(Feats *)value;
- (void)removeFeatsObject:(Feats *)value;
- (void)addFeats:(NSSet *)values;
- (void)removeFeats:(NSSet *)values;

- (void)addItemsObject:(Items *)value;
- (void)removeItemsObject:(Items *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

- (void)addMapObject:(Map *)value;
- (void)removeMapObject:(Map *)value;
- (void)addMap:(NSSet *)values;
- (void)removeMap:(NSSet *)values;

- (void)addNpcClassObject:(Class *)value;
- (void)removeNpcClassObject:(Class *)value;
- (void)addNpcClass:(NSSet *)values;
- (void)removeNpcClass:(NSSet *)values;

- (void)addRaceObject:(Race *)value;
- (void)removeRaceObject:(Race *)value;
- (void)addRace:(NSSet *)values;
- (void)removeRace:(NSSet *)values;

- (void)addSkillsObject:(Skills *)value;
- (void)removeSkillsObject:(Skills *)value;
- (void)addSkills:(NSSet *)values;
- (void)removeSkills:(NSSet *)values;

- (void)addSpellsObject:(Spells *)value;
- (void)removeSpellsObject:(Spells *)value;
- (void)addSpells:(NSSet *)values;
- (void)removeSpells:(NSSet *)values;

- (void)addTreasureObject:(Items *)value;
- (void)removeTreasureObject:(Items *)value;
- (void)addTreasure:(NSSet *)values;
- (void)removeTreasure:(NSSet *)values;

- (void)addEncounterApartObject:(NSManagedObject *)value;
- (void)removeEncounterApartObject:(NSManagedObject *)value;
- (void)addEncounterApart:(NSSet *)values;
- (void)removeEncounterApart:(NSSet *)values;

@end
