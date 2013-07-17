//
//  Skills.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, CharacterClass, NPC, Notes;

@interface Skills : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * keyAbility;
@property (nonatomic, retain) NSString * fulltext;
@property (nonatomic, retain) NSSet *character;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) NSSet *npc;
@property (nonatomic, retain) NSSet *classSkills;
@end

@interface Skills (CoreDataGeneratedAccessors)

- (void)addCharacterObject:(Character *)value;
- (void)removeCharacterObject:(Character *)value;
- (void)addCharacter:(NSSet *)values;
- (void)removeCharacter:(NSSet *)values;

- (void)addNotesObject:(Notes *)value;
- (void)removeNotesObject:(Notes *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

- (void)addNpcObject:(NPC *)value;
- (void)removeNpcObject:(NPC *)value;
- (void)addNpc:(NSSet *)values;
- (void)removeNpc:(NSSet *)values;

- (void)addClassSkillsObject:(CharacterClass *)value;
- (void)removeClassSkillsObject:(CharacterClass *)value;
- (void)addClassSkills:(NSSet *)values;
- (void)removeClassSkills:(NSSet *)values;

@end