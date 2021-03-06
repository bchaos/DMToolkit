//
//  SidebarController1.h
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SidebarViewController.h"
#import "SidebarCell1.h"
#import "panableview.h"
@interface SidebarController1 : SidebarViewController <UITableViewDataSource, UITableViewDelegate,sideCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView* tableView;

@property (nonatomic, weak) IBOutlet UILabel* profileNameLabel;

@property (nonatomic, weak) IBOutlet UILabel* profileLocationLabel;
@property (strong, nonatomic) IBOutlet panableview *panableview;

@property (nonatomic, weak) IBOutlet UIImageView* profileImageView;
@property (nonatomic, strong)SidebarCell1 * tempCelliphone;
@end
