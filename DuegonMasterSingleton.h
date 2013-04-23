//
//  DuegonMasterSingleton.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterObject.h"
@interface DuegonMasterSingleton : NSObject{
    
    CharacterObject * character;
}
+(DuegonMasterSingleton *)sharedInstance;
@end
