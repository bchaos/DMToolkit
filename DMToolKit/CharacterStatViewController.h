//
//  CharacterStatViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/29/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CharacterStatViewController : BaseTableViewController<UITextViewDelegate>
@property (nonatomic, strong) Character * myCharacter;
@end
