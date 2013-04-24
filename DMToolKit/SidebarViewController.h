//
//  SidebarViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideBarBaseViewController.h"
#import "tempSideCellView.h"
@interface SidebarViewController : SideBarBaseViewController<UITableViewDelegate , UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate, UIAlertViewDelegate>

@property ( nonatomic, strong)NSMutableArray * SelectionFields;
@property (strong, nonatomic) IBOutlet UITableView *selectionTable;
@property (strong, nonatomic) IBOutlet UIButton *backbutton;
- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet UILabel *PulldownToAddLabel;
@property (strong, nonatomic) tempSideCellView * tempCell;
@property (nonatomic, assign) BOOL newObjectAdded;
@property (nonatomic, assign) BOOL isEditing;
- (IBAction)filterCurrentSection:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *editableTextField;
@property(nonatomic, assign)int selectedCellIndex;
- (IBAction)addNew:(UIPanGestureRecognizer *)sender;

@end
