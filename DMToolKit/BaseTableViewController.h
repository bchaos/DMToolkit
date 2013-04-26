//
//  BaseTableViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/25/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "panableTable.h"
@interface BaseTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
- (IBAction)pulledDown:(id)sender;
-(UITableViewCell*)configureHeaderCell:(UITableViewCell*)cell;
-(UITableViewCell*)configureBodyCell:(UITableViewCell*)cell;
@property (nonatomic, strong)NSMutableArray * sectionTable;
@property (nonatomic, strong)UITextField * editField;
@property (weak, nonatomic) IBOutlet panableTable *table;
@property (nonatomic, assign)int selectedCell;
@end
