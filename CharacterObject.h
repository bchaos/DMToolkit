//
//  CharacterObject.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectBase.h"
@interface CharacterObject : ObjectBase
@property (nonatomic, retain)NSDictionary * currentCharacter;
@property (nonatomic ,strong)NSDictionary * allCharacters;
@end
