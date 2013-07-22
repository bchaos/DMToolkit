//
//  FeatsAndSkills.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "BaseTableViewController.h"
#import "panableTable.h"
#import "dungeonMasterSingleton.h"
#import "webViewPopoverViewController.h"
#import "FeatAndSkillsCell.h"
@interface FeatsAndSkills : masterBaseViewController<UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, webPopoverDelegate>
@property (strong, nonatomic) IBOutlet panableTable *skillsTable;
@property (strong, nonatomic) IBOutlet panableTable *featsTable;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *featPanner;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *skillPanner;
@property (nonatomic, strong) Character * myCharacter;
@property (nonatomic, strong) NSMutableArray * skillsArray;
@property (nonatomic, strong) NSMutableArray * featsArray;
@property (nonatomic, strong)UIPopoverController * popover;
@property (nonatomic, assign)int CharacterSkillCount;
@property (nonatomic, assign)BOOL newObjectAdded;
@property (nonatomic, strong)FeatAndSkillsCell * tempCell;
- (IBAction)didPan:(UIPanGestureRecognizer *)sender;


@property (nonatomic, strong)UIPickerView * picker;
@property (nonatomic, strong)UITextField * pickerSearch;
@property (nonatomic, strong)UIView * pickerView;
@property (nonatomic, strong)NSArray * pickerArray;
@property (nonatomic, strong)NSManagedObject* priorSelectedStat;

@end
