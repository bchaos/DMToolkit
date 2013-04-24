//
//  ObjectBase.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectBase : NSObject
@property (nonatomic, strong) NSString* fileToLoad;
@property (nonatomic, strong)NSString * filePath;
@property (nonatomic, strong)NSDictionary * loadedData;
-(void)load;
-(void)unload;
-(void)save;
@end
