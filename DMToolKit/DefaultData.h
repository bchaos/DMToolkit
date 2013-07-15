//
//  DefaultData.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterClass.h"
#import "Race.h"
#import "Items.h"
#import "Feats.h"
#import "NPC.h"
#import "Skills.h"
#import "Spells.h"
#import "Domain.h"
#import "Powers.h"
@interface DefaultData : NSObject<NSXMLParserDelegate>
@property (nonatomic, strong)NSXMLParser *parser;
@property (nonatomic, strong)NSMutableString *currentProperty;
@property (nonatomic, strong)Race *currentRace;
@property(nonatomic, strong)Items *currentItem;
@property(nonatomic, strong)Items *currentEquipment;
@property (nonatomic, strong)Feats *currentFeat;
@property(nonatomic, strong)NPC *currentMonster;
@property (nonatomic, strong)Skills *currentSkill;
@property (nonatomic, strong) Spells *currentSpell;
@property (nonatomic, strong)Domain *currentDomain;
@property (nonatomic, strong)Powers * currentPowers;
@property (nonatomic, strong)CharacterClass * currentCharacterClass;
-(void)createDefaultData;
@end
