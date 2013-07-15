//
//  MapMakerViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/7/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "masterBaseViewController.h"
#import "tileMap.h"
#import "SelectionViewController.h"
#import "campaignNoteTakerViewController.h"
#import "buttonWithFrameData.h"
#import "webViewPopoverViewController.h"
#import "mapDescriptionViewController.h"
#import "PCMailHandler.h"
@interface MapMakerViewController : masterBaseViewController<UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate, selectionViewControllerDelegate,UIAlertViewDelegate,campaignNoteTakerDelegate,UIPopoverControllerDelegate, mapDescriptionDelegate,webPopoverDelegate,PCMailHandlerDelegate>


- (IBAction)openMapDetails:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollAbleMap;
@property (strong, nonatomic) IBOutlet UIScrollView *toolkit;
@property (strong, nonatomic)NSArray * toolsDic;
@property (strong, nonatomic) IBOutlet UIButton *TitleButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic,strong) tileMap * map;
@property (weak, nonatomic) IBOutlet UITableView *groupSelectionTable;
@property (nonatomic, assign)BOOL loaded;
@property (strong, nonatomic) IBOutlet UIScrollView *sideMenu;
- (IBAction)switchEditingModes:(UIButton *)sender;
@property (nonatomic, strong)NSString * mapDataString;
@property(nonatomic, assign)int tablegroupIndex;
@property (nonatomic, assign)BOOL isToolBarTable;
@property (nonatomic, strong) UIPopoverController * popover;
@property (nonatomic, assign) int itemMode;
@property (nonatomic, strong) NSManagedObject * currentMangagedObject;
@property (strong, nonatomic) IBOutlet UIButton *PreviousMapButton;
@property (nonatomic, strong) NSMutableArray* previousMap;
@property (strong,  nonatomic) PCMailHandler *mail;
// public interface functions for subclasses
-(UIButton *)createBaseButton:(UIImage*)image withMode:(int)tag offset:(int)offset;
- (IBAction)previousMapSelected:(id)sender;
-(void)createSideBar;
@end
