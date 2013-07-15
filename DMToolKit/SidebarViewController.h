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
#import "Player.h"
#import "Character.h"
#import "DiceRollerViewController.h"
#import <EvernoteSDK.h>
#import "EvernoteSession.h"
#import "EvernoteUserStore.h"
#import <ENMLUtility.h>
#import "webViewPopoverViewController.h"
#import "GTMOAuth2ViewControllerTouch.h"
#import "GTLDrive.h"
#import "PDFWidget.h"
@interface SidebarViewController : SideBarBaseViewController<UITableViewDelegate , UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate, UIAlertViewDelegate, textCellDelegate, UIPopoverControllerDelegate, webPopoverDelegate,PDFWidgetDelegate>

- (IBAction)importpdf:(id)sender;
@property ( nonatomic, strong)NSMutableArray * SelectionFields;
@property (strong, nonatomic) IBOutlet UITableView *selectionTable;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *networkactivity;
@property (strong, nonatomic) IBOutlet UIButton *backbutton;
- (IBAction)goBack:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *searchField;
@property (strong, nonatomic) IBOutlet UILabel *PulldownToAddLabel;
@property (strong, nonatomic) tempSideCellView * tempCell;
@property (nonatomic, assign) BOOL newObjectAdded;
@property (nonatomic, assign) BOOL isEditing;
- (IBAction)filterCurrentSection:(UITextField *)sender;
@property (strong, nonatomic) IBOutlet UITextField *editableTextField;
@property(nonatomic, assign)int selectedCellIndex;
- (IBAction)addNew:(UIPanGestureRecognizer *)sender;
- (IBAction)showInfo:(id)sender;
@property (nonatomic,strong)Player * currentPlayer;
@property (nonatomic,strong)Notes * currentNote;
@property (nonatomic,strong)Character * currentCharacter;
@property (nonatomic, strong) UIPopoverController * pop;
@property (nonatomic, retain) GTLServiceDrive *driveService;
@property (nonatomic, strong) NSMutableArray * driveFiles;

- (IBAction)showDemBones:(UIButton *)sender;
@end
