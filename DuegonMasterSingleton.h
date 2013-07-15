//
//  DuegonMasterSingleton.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterObject.h"
#import "Notes.h"
#import "Skills.h"
#import "Campaign.h"
#import "Domain.h"
#import "Feats.h"
#import "Items.h"
#import "Affiliations.h"
#import "NPC.h"
#import "Character.h"
#import "Location.h"
#import "Spells.h"
#import "Player.h"
#import "Race.h"
#import "Map.h"
#import "Encounter.h"
#import "Powers.h"
#import "CharacterClass.h"
#import <EvernoteSDK.h>
#import "EvernoteSession.h"
#import "EvernoteUserStore.h"
#import <ENMLUtility.h>
#import <Reachability.h>
@interface DuegonMasterSingleton : NSObject{
    
    CharacterObject * character;
   }
+(DuegonMasterSingleton *)sharedInstance;
-(NSArray * )allCharacters:(NSString *)filter;
-(Character *)createCharacterForPlayer:(Player *)player;
-(NSArray * )allPlayers:(NSString*)filter;
-(Player *)createPlayerNamed:(NSString *)playerName;
@property (nonatomic, strong)NSString * currentfulltext;
@property (nonatomic,strong) Player * currentPlayer;
@property (nonatomic,strong) Character * currentCharacter;
@property (nonatomic, strong)NSManagedObject * currentObject;
@property (nonatomic,strong) Notes * currentNote;
@property (nonatomic,strong) Skills * currentSkill;
@property (nonatomic,strong) Campaign * currentCampaign;
@property (nonatomic,strong) Feats * currentFeat;
@property (nonatomic,strong) Items * currentItem;
@property (nonatomic,strong) Affiliations * currentAffiliation;
@property (nonatomic,strong) NPC * currentNPC;
@property (nonatomic,strong) NPC * currentMonster;
@property (nonatomic,strong) Spells * currentSpell;
@property (nonatomic,strong) Location * currentLocation;
@property (nonatomic,strong) Race * currentRace;
@property (nonatomic,strong) Map * currentMap;
@property (nonatomic,strong) Encounter * currentEncounter;
@property (nonatomic,strong) Powers * currentPower;
@property (nonatomic, strong) CharacterClass * currentCharacterClass;
@property (nonatomic, strong) Domain * currentDomain;
@property (nonatomic,assign) BOOL  toNPCPage;
@property ( nonatomic, assign) BOOL ablilityToDownload;
@property (nonatomic, strong) Reachability * reach;
-(void)updateCurrentPlayer:(Player*)newPlayer;
-(void)save;

-(Feats *)createFeat;
-(NSArray *)AllFeats:(NSString*)filter;
-(Feats *)findFeatNamed:(NSString *)featName;

-(Spells *)createSpell;
-(NSArray * )AllSpells:(NSString*)filter;
-(Spells *)findSpellNamed:(NSString *)spellName;


-(Skills *)createSkill;
-(NSArray * )AllSkills:(NSString*)filter;
-(Skills *)findSkillNamed:(NSString *)skillName;

-(Campaign *)createCampaign;
-(NSArray * )AllCampaigns:(NSString*)filter;

-(Domain *)createDomain;
-(NSArray * )AllDomains:(NSString*)filter;

-(Items *)createItems;
-(NSArray * )AllItems:(NSString*)filter;
-(Items * )findItemNamed :(NSString *)itemName;

-(Affiliations *)createAffiliations;
-(NSArray * )AllAffiliations:(NSString*)filter;


-(Character *)createNPC;
-(NSArray * )AllNPC:(NSString*)filter;
-(Character * )findNPCNamed:(NSString *)npcName;

-(NPC *)createMonster;
-(NSArray * )AllMonsters:(NSString*)filter;

-(Location *)createLocation;
-(NSArray * )AllLocation:(NSString*)filter;

-(Race *)createRace;
-(NSArray * )AllRace:(NSString*)filter;


-(Map *)createMap;
-(NSArray * )AllMap:(NSString*)filter;
-(Map * )findMapNamed:(NSString *)mapName;

-(Encounter *)createEncounter;
-(NSArray * )AllEncounter:(NSString*)filter;
-(Encounter *)findEncounterNamed:(NSString *)encounterName;

-(Notes *)createNotes;
-(NSArray * )AllNotes:(NSString*)filter;

-(Powers *)createPower;
-(NSArray * )AllPowers:(NSString*)filter;
-(Character *)findPlayerCharacterNamed:(NSString *)characteName;
-(NSArray *)AllPlayerCharacters:(NSString *)filter;
-(CharacterClass *)createCharacterClass;
-(NSArray * )AllCharacterClasses:(NSString*)filter;
-(Notes *)findNoteWithTimeStamp:(NSDate*)timeStamp;
-(void)deleteItem:(NSManagedObject *)object;
-(Player *)createNPCOwner;
-(Player *)getNPCMaster;
-(NSArray * )allPlayerRaces:(NSString*)filter;

-(Notes *)findNoteWithExternalID :( NSString *)externalID;


-(void)saveEvernote:(Notes *)evernote;
-(BOOL)canDownload;
@end
