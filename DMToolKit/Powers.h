//
//  Powers.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character;

@interface Powers : NSManagedObject

@property (nonatomic, retain) NSString * subDiscipline;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * fulltext;
@property (nonatomic, retain) NSString * discipline;
@property (nonatomic, retain) NSSet *atwill;
@property (nonatomic, retain) NSSet *daily;
@property (nonatomic, retain) NSSet *encounter;
@property (nonatomic, retain) NSSet *utility;
@end

@interface Powers (CoreDataGeneratedAccessors)

- (void)addAtwillObject:(Character *)value;
- (void)removeAtwillObject:(Character *)value;
- (void)addAtwill:(NSSet *)values;
- (void)removeAtwill:(NSSet *)values;

- (void)addDailyObject:(Character *)value;
- (void)removeDailyObject:(Character *)value;
- (void)addDaily:(NSSet *)values;
- (void)removeDaily:(NSSet *)values;

- (void)addEncounterObject:(Character *)value;
- (void)removeEncounterObject:(Character *)value;
- (void)addEncounter:(NSSet *)values;
- (void)removeEncounter:(NSSet *)values;

- (void)addUtilityObject:(Character *)value;
- (void)removeUtilityObject:(Character *)value;
- (void)addUtility:(NSSet *)values;
- (void)removeUtility:(NSSet *)values;

@end
