//
//  BaseTableViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/25/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "panableTable.h"
#import "textfieldWithEdgeInset.h"
#import "DuegonMasterSingleton.h"
#import "webViewPopoverViewController.h"
#import "masterBaseViewController.h"
@interface BaseTableViewController : masterBaseViewController<UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate,UIPopoverControllerDelegate>
- (IBAction)pulledDown:(id)sender;
-(UITableViewCell*)configureHeaderCell:(UITableViewCell*)cell;
-(UITableViewCell*)configureBodyCell:(UITableViewCell*)cell;
-(void)addPleaseAdd:(NSString *)nameToBegin;
-(void)editingChanged:(UITextField*)text;
-(NSString * )valueToUpdate:(int)index inSection:(int)sectionIndex;
-(void)setClass:(CharacterClass *)class;
-(void)setRace:(Race *)race;
-(void)setItem:(Items *)item;
-(void)setSkill:(Skills *)skill;
-(void)setFeat:(Feats*)feat;

@property (nonatomic, strong)NSMutableArray * sectionTable;
@property (nonatomic, strong)UITextField * editField;
@property (weak, nonatomic) IBOutlet panableTable *table;
@property (nonatomic, assign)int selectedCell;
@property (nonatomic, assign)BOOL resized;
@property (nonatomic, strong)UIPickerView * picker;
@property (nonatomic, strong)UITextField * pickerSearch;
@property (nonatomic, strong)UIView * pickerView;
@property (nonatomic, strong)NSArray * pickerArray;
@property (nonatomic, strong)UIPopoverController * popover;
@end
