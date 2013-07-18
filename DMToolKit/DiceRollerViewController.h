//
//  DiceRollerViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/6/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "masterBaseViewController.h"
#import "panableTable.h"
#import "FeatAndSkillsCell.h"

@interface DiceRollerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *diceloader;
@property (strong, nonatomic) IBOutlet UIButton *modifiers;
@property (strong, nonatomic) IBOutlet UIButton *mutliplier;
@property (strong, nonatomic) IBOutlet UIButton *dx;
@property (nonatomic, strong)FeatAndSkillsCell * tempCell;
@property (strong, nonatomic) IBOutlet UIButton *diceNumber;
@property (strong, nonatomic) IBOutlet panableTable *resultsTable;
@property (strong, nonatomic)NSMutableArray * results;
@property (strong, nonatomic)NSMutableArray * seletedItems;
@property (strong, nonatomic)NSArray * selectionList;
@property (strong, nonatomic) UIButton* selectedButton;
@property (strong, nonatomic) IBOutlet UILabel *shakeToRollLabel;
@property (strong, nonatomic) IBOutlet UIButton *clearhistory;
@property (strong, nonatomic) IBOutlet UILabel *selectedTotal;
@property (nonatomic, assign)BOOL newObjectAdded;
- (IBAction)diceNumberSelected:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UITableView *SelectionTable;

- (IBAction)loadDice:(id)sender;
- (IBAction)saveDice:(id)sender;
-(UITableViewCell *)configureCell :(UITableViewCell *)cell;
- (IBAction)dxSelected:(UIButton *)sender;
- (IBAction)mutiplierSelected:(UIButton *)sender;
- (IBAction)modifierSelected:(UIButton *)sender;
- (IBAction)clearHistory:(id)sender;
- (IBAction)didpan:(UIPanGestureRecognizer *)sender;

@end
