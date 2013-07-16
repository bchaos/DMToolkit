//
//  AppDelegate.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/22/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "AppDelegate.h"
#import "DefaultData.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self copyDatabaseIfNeeded];
    [self startUpEvernote];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
        UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
        splitViewController.delegate = (id)navigationController.topViewController;
        splitViewController.view.opaque = NO;
        _imgView = [[UIImageView alloc] initWithImage:
                    [UIImage imageNamed:@"FullNavBar.png"]];
        [_imgView setFrame:CGRectMake(0, 0, 1024, 768)];
        [[splitViewController view] insertSubview:_imgView atIndex:0];
        [[splitViewController view] setBackgroundColor:[UIColor clearColor]];
        [self fixRoundedSplitViewCorner];
    }else{
        
    }
    //DefaultData *data=[[DefaultData alloc]init];
    //[data createDefaultData];
    
    
    return YES;
}
-(void)startUpEvernote{
    NSString *EVERNOTE_HOST = BootstrapServerBaseURLStringUS;
    NSString *CONSUMER_KEY = @"bchaos";
    NSString *CONSUMER_SECRET = @"6fd93884666eef5b";
    
    [EvernoteSession setSharedSessionHost:EVERNOTE_HOST
                              consumerKey:CONSUMER_KEY
                           consumerSecret:CONSUMER_SECRET];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL canHandle = NO;
    if ([[NSString stringWithFormat:@"en-%@", [[EvernoteSession sharedSession] consumerKey]] isEqualToString:[url scheme]] == YES) {
        canHandle = [[EvernoteSession sharedSession] canHandleOpenURL:url];
    }
    return canHandle;
}


-(void) fixRoundedSplitViewCorner {
    [self explode:[[UIApplication sharedApplication] keyWindow] level:0];
}
-(void) explode:(id)aView level:(int)level
{
    
    if ([aView isKindOfClass:[UIImageView class]]) {
        UIImageView* roundedCornerImage = (UIImageView*)aView;
        roundedCornerImage.hidden = YES;
    }
    if (level < 2) {
        for (UIView *subview in [aView subviews]) {
            [self explode:subview level:(level + 1)];
        }
    }
    
    _imgView.hidden = FALSE;
}


- (void) copyDatabaseIfNeeded {
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath = [self getDBPath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    
    if(!success) {
        
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"campaign.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (NSString *) getDBPath {
    //Search for standard documents using NSSearchPathForDirectoriesInDomains
    //First Param = Searching the documents directory
    //Second Param = Searching the Users directory and not the System
    //Expand any tildes and identify home directories.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return [documentsDir stringByAppendingPathComponent:@"campaign.sqlite"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[EvernoteSession sharedSession] handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
