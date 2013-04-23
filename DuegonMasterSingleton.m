//
//  DuegonMasterSingleton.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "DuegonMasterSingleton.h"
static DuegonMasterSingleton * _sharedInstance =nil;
@implementation DuegonMasterSingleton
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
        character= [[CharacterObject alloc]init];
        [character loadCharacters];
	}
    
	return self;
}

@end
