//
//  mapMakeriphoneViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 7/21/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "MapMakerViewController.h"
#import "ToolSelectorViewController.h"
@interface mapMakeriphoneViewController : MapMakerViewController<toolSelectorDelegate> 
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backbutton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *openMapEditingMenu;
- (IBAction)mapmaking:(UIBarButtonItem*)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *openPlaceAnObjectMenu;
- (IBAction)placeAnObject:(UIBarButtonItem*)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *mapEditingMenu;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@property (nonatomic, assign)BOOL   hasbackbutton;
- (IBAction)toggleEditMode:(id)sender;
@end
