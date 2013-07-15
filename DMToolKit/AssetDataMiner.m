//
//  AssetDataMiner.m
//  Unity-iPhone
//
//  Created by Bradford Farmer on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AssetDataMiner.h"
#import <Foundation/Foundation.h>
#import <sqlite3.h>
NSString * const AssetMetadataMinerDidSaveNotification = @"AssetMetadataMinerDidSaveNotification";
NSString * const AssetMetadataMinerDidSaveFailedNotification = @"AssetMetadataMinerDidSaveFailedNotification";
@interface AssetDataMiner (){
    sqlite3 *DuegonMasterDB;

}

- (NSString*)sharedDocumentsPath;
@property (strong, nonatomic) NSString *modelName;
@property (strong, nonatomic) NSString *sqliteName;
@property (assign, nonatomic) BOOL hasStartingData;
@end

@implementation AssetDataMiner

@synthesize managedObjectModel = m_managedObjectModel;
@synthesize mainObjectContext = m_mainObjectContext;
@synthesize persistentStoreCoordinator = m_persistentStoreCoordinator;

static NSString * const kDataManagerModelName = @"campaign";
static NSString * const kDataManagerSQLiteName = @"campaign.sqlite";
static NSString * const kDataManagerSQLiteBaseName = @"campaign";

//------------------------------------------------------------------------------
+ (AssetDataMiner *)sharedInstance {
    
    return (AssetDataMiner *)[self sharedInstanceModelName:kDataManagerModelName sqliteName:kDataManagerSQLiteName];
}

//------------------------------------------------------------------------------
+ (AssetDataMiner *)sharedInstanceModelName:(NSString *)modelName sqliteName:(NSString *)sqliteName {
    
    return [AssetDataMiner sharedInstanceModelName:modelName sqliteName:sqliteName hasStartingData:NO];
}

//------------------------------------------------------------------------------
+ (AssetDataMiner *)sharedInstanceModelName:(NSString *)modelName sqliteName:(NSString *)sqliteName hasStartingData:(BOOL)hasStartingData {
    
	static dispatch_once_t pred;
	static AssetDataMiner *sharedInstance = nil;
    
	dispatch_once(&pred, ^{ sharedInstance = [[self alloc] init]; });
    
    sharedInstance.modelName = modelName;
    sharedInstance.sqliteName = sqliteName;
    sharedInstance.hasStartingData = hasStartingData;
    
	return sharedInstance;
}
//------------------------------------------------------------------------------
- (void)dealloc {

}

//------------------------------------------------------------------------------
- (BOOL)databaseFileExists {
    
    NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDataManagerSQLiteName];
    return [[NSFileManager defaultManager] fileExistsAtPath:storePath];
}

//------------------------------------------------------------------------------
- (NSManagedObjectContext *)mainObjectContext {
    
	if (m_mainObjectContext){
        return m_mainObjectContext;
    }
    
	// Create the main context only on the main thread
	if (![NSThread isMainThread]) {
		[self performSelectorOnMainThread:@selector(mainObjectContext)
                               withObject:nil
                            waitUntilDone:YES];
		return m_mainObjectContext;
	}
    
	m_mainObjectContext = [[NSManagedObjectContext alloc] init];
	[m_mainObjectContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    
	return m_mainObjectContext;
}

//------------------------------------------------------------------------------
- (NSManagedObjectModel *)managedObjectModel {
    
	if (m_managedObjectModel)
		return m_managedObjectModel;
    

    NSBundle *bundle = [NSBundle mainBundle];
	NSString *modelPath = [bundle pathForResource:kDataManagerModelName ofType:@"momd"];
	m_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
    
    
	return m_managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    // Hats off to Jeff LaMarche.
    // http://iphonedevelopment.blogspot.com/2010/08/core-data-starting-data.html
    
    @synchronized (self)
    {
        if (m_persistentStoreCoordinator != nil)
            return m_persistentStoreCoordinator;
        NSFileManager *filemgr = [NSFileManager defaultManager];
        
        NSString * docsDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *defaultStorePath = [NSString stringWithFormat:@"%@/campaign.sqlite",docsDir];
        NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDataManagerSQLiteName];
        
        NSError *error;
        
        
        if([[NSFileManager defaultManager]fileExistsAtPath:defaultStorePath]){
          
        
        }
        else {
            
            if ([filemgr fileExistsAtPath: storePath ] == NO)
            {
                const char *dbpath = [storePath UTF8String];
                
                if (sqlite3_open(dbpath, &DuegonMasterDB) == SQLITE_OK)
                {
                    char *errMsg;
                    const char *sql_stmt = "CREATE TABLE IF NOT EXISTS Campaign (NSString name, NSString briefDescription , Map map,NSSet players, NSSet notes  )";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Skills (NSString name, NSString type, NSString keyAbility, NSString fulltext, NSSet notes,NSSet npc,  NSSet character, NSSet classSkills)";

                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Notes (NSString name, NSString text, NSDate date,NSSet location, NSSet *affiliations, NSSet campaign,NSSet character,NSSet items,NSSet map,NSSet player,NSSet *skills , NSString *group ,  NSString *externalid  )";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                   
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Domain (NSString name, NSString fulltext, NSSet Character,NSSet npc,NSSet spells )";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Feats NSString name, NSString fulltext, NSSet Character,NSSet npc)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
  
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Items (NSString name, NSString type,NSString subtype, NSString weight,NSString fulltext, NSSet spells, NSSet location,NSSet map, NSSet notes, NSSet spells, NSSet npcTreasure, NSSet npcItems, NSSet ecnounter)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS NPC (NSString name, NSString fulltext,NSNumber isMonster,NSSet skills, NSSet race, NSSet diety, NSSet feats, NSSet items, NSSet affiliations, Location location,NSSet treasure,NSSet *spells,  NSSet characterClass, NSSet encounterApart)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
               
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Character (NSString strength, NSString constitution,NSString dexterity, NSString intelligence,NSString wisdom, NSString charisma , NSString ac, NSString fortitude,NSString reflex, NSString will , NSString surges, NSString initiative,NSString alignment, NSString hitpoints , NSString perception, NSString story, NSString paragonpath, NSString height, NSString gender, NSString age, NSString currentXP,NSString personalTraits,NSString apperance,NSString background,NSSet inventory,Player owner,NSSet companions,NSSet diety,Race race, NSSet notes,NSString name, Location location,NSSet spells, NSString actionPoints, NSSet  powerAtWill, NSSet powerDaily, NSSet powerEncounter,  NSSet powerUtility,  CharacterClass characterClass)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
  

                    sql_stmt= "CREATE TABLE IF NOT EXISTS Location (NSString gridPoint, Campaign campaign , NSSet character, NSSet items, NSSet map, NSSet notes,NSSet npc)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
          
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Spells (NSString name, NSString school,NSString subSchool, NSString fulltext, NSSet character, NSSet items, NSSet npc, NSSet domain )";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;

                    sql_stmt= "CREATE TABLE IF NOT EXISTS Player (NSString name, NSSet characters,NSSet notes ,NSSet map)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Race (NSString name, NSString fulltext , NSSet character, NSSet npc)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Powers (NSString name, NSString fulltext , NSString discipline,NSString  subDiscipline, NSSet atwill, NSSet daily, NSSet encounter, NSSet utility)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS CharacterClass (NSString name, NSString type, NSString fulltext , NSSet npc, NSSet character, NSSet classSkills)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    
                    sql_stmt= "CREATE TABLE IF NOT EXISTS Encounter (NSString name, NSString about, NSSet monsters, NSSet possibleTreasure , Map map)";
                    
                    sqlite3_exec(DuegonMasterDB, sql_stmt, NULL, NULL, &errMsg) ;
                    

                    sqlite3_close(DuegonMasterDB);
                    
                } else {
                    
                }
            }
            
        }
        
        
        
        m_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @true, NSMigratePersistentStoresAutomaticallyOption,
                                 @true, NSInferMappingModelAutomaticallyOption, nil];
        
        
        NSURL *storeURL = [NSURL fileURLWithPath:defaultStorePath];
        if (![m_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
        {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        
        return m_persistentStoreCoordinator;
    }
}
 /*
//------------------------------------------------------------------------------
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_hasStartingData) {
        return [self persistentStoreCoordinatorStartingData];
    }
    
	if (m_persistentStoreCoordinator)
		return m_persistentStoreCoordinator;
    
	// Get the paths to the SQLite file
	NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:self.sqliteName];
	NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
	// Define the Core Data version migration options
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSString numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSString numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                             nil];
    
	// Attempt to load the persistent store
	NSError *error = nil;
	m_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
	if (![m_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                    configuration:nil
                                                              URL:storeURL
                                                          options:options
                                                            error:&error]) {
		NSLog(@"Fatal error while creating persistent store: %@", error);
		abort();
	}
    
	return m_persistentStoreCoordinator;
}

//------------------------------------------------------------------------------
- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorStartingData {
    
    // Hats off to Jeff LaMarche.
    // http://iphonedevelopment.blogspot.com/2010/08/core-data-starting-data.html
    
    @synchronized (self)
    {
        if (m_persistentStoreCoordinator != nil)
            return m_persistentStoreCoordinator;
        
        NSString *defaultStorePath = [[NSBundle bundleForClass:[self class]] pathForResource:self.modelName ofType:@"sqlite"];
        NSString *storePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:self.sqliteName];
        
        NSError *error;
        if (![[NSFileManager defaultManager] fileExistsAtPath:storePath])
        {
            if ([[NSFileManager defaultManager] copyItemAtPath:defaultStorePath toPath:storePath error:&error])
                NSLog(@"Copied starting data to %@", storePath);
            else
                NSLog(@"Error copying default DB to %@ (%@)", storePath, error);
        }
        
        NSURL *storeURL = [NSURL fileURLWithPath:storePath];
        
        m_persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSString numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSString numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        if (![m_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
        {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        return m_persistentStoreCoordinator;
    }
}
*/
//------------------------------------------------------------------------------
- (NSString *)sharedDocumentsPath {
    
	static NSString *SharedDocumentsPath = nil;
	if (SharedDocumentsPath)
		return SharedDocumentsPath;
    
	// Compose a path to the <Library>/Database directory
	NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0 ];
	SharedDocumentsPath = [libraryPath stringByAppendingPathComponent:@"Database" ];
   
    
	// Ensure the database directory exists
	NSFileManager *manager = [NSFileManager defaultManager];
	BOOL isDirectory;
	if (![manager fileExistsAtPath:SharedDocumentsPath isDirectory:&isDirectory] || !isDirectory) {
		NSError *error = nil;
		NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                         forKey:NSFileProtectionKey];
		[manager createDirectoryAtPath:SharedDocumentsPath
		   withIntermediateDirectories:YES
                            attributes:attr
                                 error:&error];
		if (error)
			NSLog(@"Error creating directory path: %@", [error localizedDescription]);
	}
    
	return SharedDocumentsPath;
}

//------------------------------------------------------------------------------
- (void)prepareDatabaseFolder {
    
    [self sharedDocumentsPath];
}

//------------------------------------------------------------------------------
- (NSManagedObjectContext *)newManagedObjectContext {
    
	NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] init];
	[ctx setPersistentStoreCoordinator:self.persistentStoreCoordinator];
	return ctx;
}

//------------------------------------------------------------------------------
- (void)reset {
    
    m_managedObjectModel = nil;
    m_mainObjectContext = nil;
    m_persistentStoreCoordinator = nil;
}

//------------------------------------------------------------------------------
- (BOOL)save {
    
	return [self saveWithContext:self.mainObjectContext];
}

//------------------------------------------------------------------------------
- (BOOL)saveWithContext:(NSManagedObjectContext *)theContext {
    
	if (![theContext hasChanges])
		return YES;
    
	NSError *error = nil;
    if (theContext ==nil)
        return YES;
	if (![theContext save:&error]) {
		NSLog(@"Error while saving: %@\n%@", [error localizedDescription], [error userInfo]);
		[[NSNotificationCenter defaultCenter] postNotificationName:AssetMetadataMinerDidSaveFailedNotification
                                                            object:error];
		return NO;
	}
    
	[[NSNotificationCenter defaultCenter] postNotificationName:AssetMetadataMinerDidSaveNotification object:nil];
	return YES;
}

@end
