//
//  CharacterViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/25/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
@interface CharacterViewController : BaseTableViewController<UITableViewDataSource, UITableViewDelegate>

- (IBAction)pullingdown:(UIPanGestureRecognizer *)sender;

@end
