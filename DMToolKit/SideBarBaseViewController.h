//
//  SideBarBaseViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldCell.h"
@interface SideBarBaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;
-(TextFieldCell *) configureCell:(TextFieldCell *)cell;
-(TextFieldCell * )configureCellWithTextField:(TextFieldCell *)cell;
-(TextFieldCell* )addDetailsToCell:(TextFieldCell *)cell forObject:(NSManagedObject*)Object;

// menu items
-(BOOL)atMainMenu;
-(BOOL)atNoteMenu;
-(BOOL)atNPCMenu;
-(BOOL)atEncounterMenu;
-(BOOL)atItemsMenu;
-(BOOL)atMonstersMenu;
-(BOOL)atFeatsMenu;
-(BOOL)atSkillsMenu;
-(BOOL)atPowersMenu;
-(BOOL)atDomainsMenu;
-(BOOL)atRaceMenu;
-(BOOL)atClassesMenu;
-(BOOL)atEvernoteNoteMenu;
-(BOOL)atDriveMenu;
-(BOOL)atCompendiumSubMenu;
-(BOOL)atExternalNoteSubMenu;
-(BOOL)atEverNoteBook;
-(BOOL)atReferenceMenu;
-(BOOL)atPlayermenu;
-(BOOL)atCampaignMenu;
@end
