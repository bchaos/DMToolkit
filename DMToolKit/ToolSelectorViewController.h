//
//  ToolSelectorViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 7/22/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "buttonWithFrameData.h"
@protocol toolSelectorDelegate <NSObject>
-(void)setupCurrentTool:(buttonWithFrameData*)currentTool;
-(void)setupCurrentAction:(buttonWithFrameData *)currentAction;
-(void)done;
@end
@interface ToolSelectorViewController : UIViewController

- (IBAction)done:(id)sender;
-(void)setupButtons;
-(void)setUpActionButtons;
-(void)setUpActionButtonsEncounter;
@property(nonatomic, strong)NSArray *tileList;
@property(nonatomic, strong)NSArray* actionButtonList;
@property (nonatomic, assign) id <toolSelectorDelegate> delegate;
@end
