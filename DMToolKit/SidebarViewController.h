//
//  SidebarViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarBaseViewController.h"
@interface SidebarViewController : SideBarBaseViewController<UITableViewDelegate , UITableViewDataSource>

@property ( nonatomic, strong)NSArray * SelectionFields;
@property (strong, nonatomic) IBOutlet UITableView *selectionTable;
@property (strong, nonatomic) IBOutlet UIButton *backbutton;
- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *searchField;
- (IBAction)filterCurrentSection:(id)sender;

@end
