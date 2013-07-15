//
//  DuegonMasterSingleton.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "DuegonMasterSingleton.h"
#import "AssetDataMiner.h"
#import "PCOneLineFetch.h"


static DuegonMasterSingleton * _sharedInstance =nil;
@implementation DuegonMasterSingleton
-(NSManagedObjectContext *)context{
    return [[AssetDataMiner sharedInstance]mainObjectContext];
}
+(DuegonMasterSingleton *)sharedInstance {
    
    @synchronized([DuegonMasterSingleton class])
	{
		if (!_sharedInstance){
			if([[self alloc] init]){
                NSLog(@"shared instance Created");
            }
        }
        
		return _sharedInstance;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([DuegonMasterSingleton class])
	{
		NSAssert(_sharedInstance == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedInstance = [super alloc];
		return _sharedInstance;
	}
    
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
        _ablilityToDownload=NO;
         _reach =[Reachability reachabilityWithHostname:@"www.google.com"];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(reachabilityChanged)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
        [_reach startNotifier];
	}
    
	return self;
}


-(NSArray *)allItemsInClass : (Class )className withFilter:(NSString*)filter{
    NSManagedObjectContext* context= [self context];
    NSArray * allItems;
    if (filter==nil || [filter isEqualToString:@""]){
        allItems= [[context fetchObjectsForObjectName:className withPredicate:nil ]allObjects];
    }
    else{
        allItems= [[context fetchObjectsForObjectName:className withPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@",filter] ]allObjects];
    }
    if (allItems !=nil){
        NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        allItems = [allItems sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]];
    }
    return allItems;
}

-(NSArray * )allCharacters :(NSString *)filter{
  
    return [self allItemsInClass:[Character class] withFilter:filter];
}


-(Character *)createCharacterForPlayer:(Player *)player{
    NSManagedObjectContext* context= [self context];
     NSString *className = NSStringFromClass([Character class]);
    Character * newCharacter= (Character *)[NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
    [player addCharactersObject:newCharacter];
    [self save];
    self.currentCharacter=newCharacter;
    return newCharacter;
}

-(NSArray * )allPlayers :(NSString*)filter{
    NSMutableArray * playerList =[[NSMutableArray alloc
                                  ]initWithArray:[self allItemsInClass:[Player class] withFilter:filter]];
    [playerList removeObject:[self getNPCMaster]];

    return playerList;
}

-(Player *)createPlayerNamed:(NSString *)playerName{
    NSManagedObjectContext* context= [self context];
     NSString *className = NSStringFromClass([Player class]);
    Player * newplayer = (Player *)[NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
    [newplayer setName:playerName];
    [self createCharacterForPlayer:newplayer];
    [self save];
    self.currentPlayer=newplayer;
    return newplayer;

}
-(Player *)createNPCOwner{
    NSManagedObjectContext* context= [self context];
    NSString *className = NSStringFromClass([Player class]);
    Player * newplayer = (Player *)[NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
    [newplayer setName:@"NPCs"];
    [self save];
    return newplayer;
}
-(Player *)getNPCMaster{
    return [self findObjectNamed:@"NPCs" classToCheck:[Player class]];
}

-(void)updateCurrentPlayer:(Player*)newPlayer{
    self.currentPlayer=newPlayer;
    NSManagedObjectContext* context= [self context];
    Character * myCharacter= [[context fetchObjectsForObjectName:[Character class] withPredicate:[NSPredicate predicateWithFormat:@"owner=%@",newPlayer] ]anyObject];
    self.currentCharacter=myCharacter;
}


-(id)createBase:(Class)class{
    NSManagedObjectContext* context= [self context];
    NSString *className = NSStringFromClass(class);
   id managedObject=  [NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
    [self save];
    return managedObject;
   
}


-(id)findObjectNamed:(NSString*)name classToCheck:(Class)className{
    NSManagedObjectContext* context= [self context];
   return [[context fetchObjectsForObjectName:className withPredicate:[NSPredicate predicateWithFormat:@"name == %@",name] ]anyObject];
    
}
-(Feats *)createFeat{
    return (Feats *) [self createBase:[Feats class]];
}


-(NSArray * )AllFeats:(NSString*)filter{
    return [self allItemsInClass:[Feats class] withFilter:filter];

}


-(Feats *)findFeatNamed:(NSString *)featName{
    return (Feats *)[ self findObjectNamed:featName classToCheck:[Feats class]];
}

-(Encounter*)findEncounterNamed:(NSString *)encounterName{
     return (Encounter *)[ self findObjectNamed:encounterName classToCheck:[Encounter class]];
}

-(Map *)findMapNamed:(NSString *)mapName{
    NSManagedObjectContext* context= [self context];
    return [[context fetchObjectsForObjectName:[Map class] withPredicate:[NSPredicate predicateWithFormat:@"gridInfomation == %@",mapName] ]anyObject];
}
-(Items *)findItemNamed:(NSString *)itemName{
    return (Items *)[ self findObjectNamed:itemName classToCheck:[Items class]];
}

-(Character *)findNPCNamed:(NSString *)npcName{
   Player * npcMaster=  [self getNPCMaster];
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"name == %@",npcName];
    return [[npcMaster.characters filteredSetUsingPredicate:bPredicate] anyObject];
}

-(Character *)findPlayerCharacterNamed:(NSString *)characteName{
    NSArray * PlayerCharacters=  [self AllPlayerCharacters:nil];
    __block  Character* foundCharacter;
    [PlayerCharacters each:^(Character * myCharacter) {
        if ([myCharacter.name isEqualToString:characteName])
            foundCharacter= myCharacter;
    }];
    return foundCharacter;
}


-(NSArray *)AllPlayerCharacters:(NSString *)filter{
    NSArray * players = [self allPlayers:nil];
    __block NSMutableArray * characters = [[ NSMutableArray alloc]init];
    __block NSString * blockFilter=filter;
    [players each:^(Player *  player) {
        [[player.characters allObjects] each:^(Character *  mycharacter) {
            if (blockFilter !=nil && [JE_ string:mycharacter.name  containsString:blockFilter]){
                [characters addObject:mycharacter];
            }else{
                [characters addObject:mycharacter];
            }
           
        }];
    }];
    return characters;
}
-(Spells *)createSpell{
    return (Spells *) [self createBase:[Spells class]];
}


-(NSArray * )AllSpells:(NSString*)filter{
    return [self allItemsInClass:[Spells class] withFilter:filter];
}

-(Spells *)findSpellNamed:(NSString *)spellName{
    return (Spells *)[ self findObjectNamed:spellName classToCheck:[Spells class]];
}

-(Notes *) findNoteWithTimeStamp:(NSDate *)timeStamp{
    //due to temperal distortion the note is found with in the second of the write back.
    __block Notes * foundnote;
    [[self AllNotes:nil] each:^(Notes  * note) {
        NSTimeInterval difference = [timeStamp timeIntervalSinceDate:note.date];
        if(fabsf(difference) < 1){
            foundnote=note;
        }
    }];
    return foundnote;

}
-(Notes *)findNoteWithExternalID :( NSString *)externalID{
    NSManagedObjectContext* context= [self context];
    return [[context fetchObjectsForObjectName:[Notes class] withPredicate:[NSPredicate predicateWithFormat:@"externalid == %@",externalID] ]anyObject];

}

-(Skills *)createSkill{
    return (Skills *) [self createBase:[Skills class]];
}


-(NSArray * )AllSkills:(NSString*)filter{
   return [self allItemsInClass:[Skills class] withFilter:filter];
}


-(Skills *)findSkillNamed:(NSString *)skillName{
   return (Skills *)[ self findObjectNamed:skillName classToCheck:[Skills class]];
}



-(Campaign *)createCampaign{
     return (Campaign *) [self createBase:[Campaign class]];
}


-(NSArray * )AllCampaigns:(NSString*)filter{
  return [self allItemsInClass:[Campaign class] withFilter:filter];
}


-(Domain *)createDomain{
    return (Domain *) [self createBase:[Domain class]];
}


-(NSArray * )AllDomains:(NSString*)filter{
    return [self allItemsInClass:[Domain class] withFilter:filter];
}



-(Items *)createItems{
  return (Items *) [self createBase:[Items class]];
}


-(NSArray * )AllItems:(NSString*)filter{
  return [self allItemsInClass:[Items class] withFilter:filter];
}


-(Affiliations *)createAffiliations{
    return (Affiliations *) [self createBase:[Affiliations class]];
}


-(NSArray * )AllAffiliations:(NSString*)filter{
    return [self allItemsInClass:[Affiliations class] withFilter:filter];
}

-(NPC *)createBaseNCP:(BOOL)isMonster{
    NSManagedObjectContext* context= [self context];
    NSString *className = NSStringFromClass([NPC class]);
    NPC * newNPC = (NPC *)[NSEntityDescription insertNewObjectForEntityForName:className inManagedObjectContext:context];
    newNPC.isMonster= [NSNumber numberWithBool:isMonster];
    [self save];
    return newNPC;

}

-(NSArray * )AllBaseNPCs:(NSString*)filter isMonster:(BOOL)isMonster{
    NSManagedObjectContext* context= [self context];
    NSArray * allNPCs;
    if (filter==nil ||[filter isEqualToString:@""]){
        NSPredicate *pred=[NSPredicate predicateWithFormat:@"isMonster == %@", [NSNumber numberWithBool:isMonster]];
        allNPCs= [[context fetchObjectsForObjectName:[NPC class] withPredicate:pred ]allObjects];
    }
    else{
        allNPCs= [[context fetchObjectsForObjectName:[NPC class] withPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@ AND isMonster = %@",filter, [NSNumber numberWithBool:isMonster]] ]allObjects];
    }
    if (allNPCs !=nil){
        NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        allNPCs = [allNPCs sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]];
    }
    return allNPCs;
}


-(Character *)createNPC{
    return  [self createCharacterForPlayer:[self findObjectNamed:@"NPCs" classToCheck:[Player class]] ];
}


-(NSArray * )AllNPC:(NSString*)filter{
    return  [[[self findObjectNamed:@"NPCs" classToCheck:[Player class]] valueForKey:@"characters"]allObjects];
}


-(NPC *)createMonster{
    return  [self createBaseNCP:YES];
}


-(NSArray * )AllMonsters:(NSString*)filter{
    return  [self AllBaseNPCs:filter isMonster:YES];
}

-(Location *)createLocation{
    return (Location *) [self createBase:[Location class]];
}


-(NSArray * )AllLocation:(NSString*)filter{
    return [self allItemsInClass:[Location class] withFilter:filter];
}

-(Race *)createRace{
    return (Race *) [self createBase:[Race class]];
}


-(NSArray * )AllRace:(NSString*)filter{
    return [self allItemsInClass:[Race class] withFilter:filter];
}

-(NSArray * )allPlayerRaces:(NSString*)filter{
    NSArray * allRaces =[self AllRace:filter];
   __block NSMutableArray * playerRaces = [[ NSMutableArray alloc]init];
    [allRaces each:^(Race *  object) {
        if([object.playerRace isEqualToNumber: @true]){
            [playerRaces addObject:object];
        }
    }];
    return playerRaces;
}

-(Map *)createMap{
    return (Map *) [self createBase:[Map class]];
}


-(NSArray * )AllMap:(NSString*)filter{
    return [self allItemsInClass:[Map class] withFilter:filter];
}

-(Encounter *)createEncounter{
    return (Encounter *) [self createBase:[Encounter class]];
}


-(NSArray * )AllEncounter:(NSString*)filter{
    return [self allItemsInClass:[Encounter class] withFilter:filter];
}


-(Notes *)createNotes{
    return (Notes *) [self createBase:[Notes class]];
}


-(NSArray * )AllNotes:(NSString*)filter{
    NSArray * notes =  [self allItemsInClass:[Notes class] withFilter:filter];
    NSMutableArray * internalNotes = [[NSMutableArray alloc]init];
    for (Notes * note in notes ){
        if (![note.group isEqualToString:@"Evernote"] && ![note.group isEqualToString:@"GoogleDoc"]){
            [internalNotes addObject:note];
        }
    }
    return internalNotes;
}

-(Powers *)createPower{
    return (Powers *) [self createBase:[Powers class]];
}


-(NSArray * )AllPowers:(NSString*)filter{
    return [self allItemsInClass:[Powers class] withFilter:filter];
}


-(CharacterClass *)createCharacterClass{
    return (CharacterClass *) [self createBase:[CharacterClass class]];
}


-(NSArray * )AllCharacterClasses:(NSString*)filter{
    return [self allItemsInClass:[CharacterClass class] withFilter:filter];
}

#pragma mark - Writeback functions


-(void)save{
    [[self context]save:nil];
    
}
-(BOOL)canDownload {
    return self.ablilityToDownload;
}


-(void)saveEvernote:(Notes*)evernote{
    if ([self canDownload]){
        [[EvernoteNoteStore  noteStore]getNoteWithGuid:evernote.externalid withContent:YES withResourcesData:YES withResourcesRecognition:YES withResourcesAlternateData:YES success:^(EDAMNote *note) {
            note.content= evernote.text;
            [[EvernoteNoteStore noteStore]updateNote:note success:^(EDAMNote *note) {
                
                
            } failure:^(NSError *error) {
                
            }];
            
            
        }failure:^(NSError *error) {
            
        }];
    }
    
}


-(void)deleteItem:(NSManagedObject *)object{
     NSManagedObjectContext* context= [self context];
    [context deleteObject:object];
    [self save];
}

-(void)reachabilityChanged{
    if([_reach currentReachabilityStatus] != NotReachable){
        
        self.ablilityToDownload=YES;
    }
    else{
        self.ablilityToDownload=NO;
    }
}


@end
