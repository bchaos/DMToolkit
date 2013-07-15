//
//  Character.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Affiliations, CharacterClass, Domain, Feats, Items, Location, NPC, Notes, Player, Powers, Race, Skills, Spells;

@interface Character : NSManagedObject

@property (nonatomic, retain) NSString * ac;
@property (nonatomic, retain) NSString * actionPoints;
@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * alignment;
@property (nonatomic, retain) NSString * apperance;
@property (nonatomic, retain) NSString * background;
@property (nonatomic, retain) NSString * charisma;
@property (nonatomic, retain) NSString * constitution;
@property (nonatomic, retain) NSString * currentXP;
@property (nonatomic, retain) NSString * dexterity;
@property (nonatomic, retain) NSString * fortitude;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * hitpoints;
@property (nonatomic, retain) NSString * initiative;
@property (nonatomic, retain) NSString * insight;
@property (nonatomic, retain) NSString * intelligence;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * paragonpath;
@property (nonatomic, retain) NSString * perception;
@property (nonatomic, retain) NSString * personalTraits;
@property (nonatomic, retain) NSString * reflex;
@property (nonatomic, retain) NSString * speed;
@property (nonatomic, retain) NSString * story;
@property (nonatomic, retain) NSString * strength;
@property (nonatomic, retain) NSString * surges;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * will;
@property (nonatomic, retain) NSString * wisdom;
@property (nonatomic, retain) NSString * gods;
@property (nonatomic, retain) Affiliations *affiliations;
@property (nonatomic, retain) CharacterClass *characterClass;
@property (nonatomic, retain) NSSet *companions;
@property (nonatomic, retain) NSSet *domain;
@property (nonatomic, retain) NSSet *feats;
@property (nonatomic, retain) NSSet *inventory;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) Player *owner;
@property (nonatomic, retain) NSSet *powerAtWill;
@property (nonatomic, retain) NSSet *powerDaily;
@property (nonatomic, retain) NSSet *powerEncounter;
@property (nonatomic, retain) NSSet *powerUtility;
@property (nonatomic, retain) Race *race;
@property (nonatomic, retain) NSSet *skills;
@property (nonatomic, retain) NSSet *spells;
@end

@interface Character (CoreDataGeneratedAccessors)

- (void)addCompanionsObject:(NPC *)value;
- (void)removeCompanionsObject:(NPC *)value;
- (void)addCompanions:(NSSet *)values;
- (void)removeCompanions:(NSSet *)values;

- (void)addDomainObject:(Domain *)value;
- (void)removeDomainObject:(Domain *)value;
- (void)addDomain:(NSSet *)values;
- (void)removeDomain:(NSSet *)values;

- (void)addFeatsObject:(Feats *)value;
- (void)removeFeatsObject:(Feats *)value;
- (void)addFeats:(NSSet *)values;
- (void)removeFeats:(NSSet *)values;

- (void)addInventoryObject:(Items *)value;
- (void)removeInventoryObject:(Items *)value;
- (void)addInventory:(NSSet *)values;
- (void)removeInventory:(NSSet *)values;

- (void)addNotesObject:(Notes *)value;
- (void)removeNotesObject:(Notes *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

- (void)addPowerAtWillObject:(Powers *)value;
- (void)removePowerAtWillObject:(Powers *)value;
- (void)addPowerAtWill:(NSSet *)values;
- (void)removePowerAtWill:(NSSet *)values;

- (void)addPowerDailyObject:(Powers *)value;
- (void)removePowerDailyObject:(Powers *)value;
- (void)addPowerDaily:(NSSet *)values;
- (void)removePowerDaily:(NSSet *)values;

- (void)addPowerEncounterObject:(Powers *)value;
- (void)removePowerEncounterObject:(Powers *)value;
- (void)addPowerEncounter:(NSSet *)values;
- (void)removePowerEncounter:(NSSet *)values;

- (void)addPowerUtilityObject:(Powers *)value;
- (void)removePowerUtilityObject:(Powers *)value;
- (void)addPowerUtility:(NSSet *)values;
- (void)removePowerUtility:(NSSet *)values;

- (void)addSkillsObject:(Skills *)value;
- (void)removeSkillsObject:(Skills *)value;
- (void)addSkills:(NSSet *)values;
- (void)removeSkills:(NSSet *)values;

- (void)addSpellsObject:(Spells *)value;
- (void)removeSpellsObject:(Spells *)value;
- (void)addSpells:(NSSet *)values;
- (void)removeSpells:(NSSet *)values;

@end
