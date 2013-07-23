//
//  InventoryViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 5/6/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "masterBaseViewController.h"
#import "panableTable.h"
#import "FeatAndSkillsCell.h"
#import "webViewPopoverViewController.h"
#import "iphoneSelectionViewController.h"
@interface InventoryViewController : masterBaseViewController<UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, webPopoverDelegate,iphoneselectionViewControllerDelegate>
@property (strong, nonatomic) IBOutlet panableTable *inventoryTable;
@property (nonatomic, strong)UIPopoverController * popover;
@property (nonatomic, strong) NSMutableArray * inventoryArray;
@property (nonatomic, assign)BOOL newObjectAdded;
@property (nonatomic, strong)FeatAndSkillsCell * tempCell;
- (IBAction)BagOfHoldingIsPanning:(UIPanGestureRecognizer *)sender;

@property (nonatomic, strong) Character * myCharacter;

@property (nonatomic, strong)UIPickerView * picker;
@property (nonatomic, strong)UITextField * pickerSearch;
@property (nonatomic, strong)UIView * pickerView;
@property (nonatomic, strong)NSArray * pickerArray;
@property (nonatomic, strong)NSManagedObject* priorInventoryItemSelected;
@end
