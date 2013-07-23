//
//  iphoneSelectionViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 7/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol iphoneselectionViewControllerDelegate

-(void)ItemSelected:(NSManagedObject*)object;
-(void)done;
@end

@interface iphoneSelectionViewController : UITableViewController
@property (nonatomic, assign) id <iphoneselectionViewControllerDelegate> delegate;
@property  (nonatomic, strong) NSArray *listToShow;
@property (strong, nonatomic) IBOutlet UITextField *search;
- (IBAction)update:(id)sender;
-(void)setList:(NSArray *)list;
@property (strong, nonatomic) IBOutlet UITableView *selectiontable;

- (IBAction)done:(id)sender;

@property  (nonatomic, strong) NSArray *filteredList;
@end