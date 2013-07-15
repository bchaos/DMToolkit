//
//  AssetDataMiner.h
//  Unity-iPhone
//
//  Created by Bradford Farmer on 9/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AssetDataMiner : NSObject

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *mainObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (AssetDataMiner *)sharedInstance;
- (NSManagedObjectContext *)newManagedObjectContext;
- (void)reset;
- (NSString*)sharedDocumentsPath;
- (void)prepareDatabaseFolder;
- (BOOL)save;
- (BOOL)saveWithContext:(NSManagedObjectContext *)theContext;

- (BOOL)databaseFileExists;
@end
