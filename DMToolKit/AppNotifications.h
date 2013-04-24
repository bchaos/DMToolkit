//
//  AppNotifications.h
//  ESCDemo
//
//  Created by Bradford Farmer on 11/1/12.
//  Copyright (c) 2012 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSStrng *kShowCharacterCreator=@"showCharacterCreator";

@interface AppNotifications : NSObject

+(NSNotification*)showCharacterCreator;

@end
