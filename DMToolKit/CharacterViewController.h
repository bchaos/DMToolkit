//
//  CharacterViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/25/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"
@class Character;
@interface CharacterViewController : BaseTableViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Character * myCharacter;
@property (nonatomic, assign)NSString * racesTOUse;

@end
