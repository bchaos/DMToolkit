//
//  SelectionViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/16/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol selectionViewControllerDelegate
    
    -(void)ItemSelected:(NSManagedObject*)object;
    -(void)done;
@end

@interface SelectionViewController : UITableViewController
    @property (nonatomic, assign) id <selectionViewControllerDelegate> delegate;
    @property  (nonatomic, strong) NSArray *listToShow;
@property (strong, nonatomic) IBOutlet UITextField *search;
- (IBAction)update:(id)sender;
-(void)setList:(NSArray *)list;
@property (strong, nonatomic) IBOutlet UITableView *selectiontable;


    @property  (nonatomic, strong) NSArray *filteredList;
@end
