//
//  SideBarBaseViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldCell.h"
@interface SideBarBaseViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;
-(TextFieldCell *) configureCell:(TextFieldCell *)cell;
-(TextFieldCell * )configureCellWithTextField:(TextFieldCell *)cell;
@end
