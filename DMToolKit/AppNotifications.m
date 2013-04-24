//
//  AppNotifications.m
//  ESCDemo
//
//  Created by Bradford Farmer on 11/1/12.
//  Copyright (c) 2012 Bradford Farmer. All rights reserved.
//

#import "AppNotifications.h"

@implementation AppNotifications

+(NSNotification*)showCharacterCreator{
    return [NSNotification notificationWithName: kShowCharacterCreator object:nil];
};


@end
