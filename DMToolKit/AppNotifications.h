//
//  AppNotifications.h
//  ESCDemo
//
//  Created by Bradford Farmer on 11/1/12.
//  Copyright (c) 2012 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *kShowCharacterCreator=@"showCharacterCreator";
static NSString *kShowCharacterCreatorNPC=@"showCharacterCreatorNPC";
@interface AppNotifications : NSObject

+(NSNotification*)showCharacterCreator;

@end
