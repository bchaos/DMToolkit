//
//  AppDelegate.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/22/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EvernoteSDK.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property( nonatomic, strong)UIImageView * imgView;

- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
@end
