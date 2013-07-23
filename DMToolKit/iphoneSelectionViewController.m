//
//  iphoneSelectionViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 7/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "iphoneSelectionViewController.h"

@interface iphoneSelectionViewController ()

@end

@implementation iphoneSelectionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_filteredList count];
}
-(void)setList:(NSArray *)list{
    
    self.listToShow=list;
    [self updateFilteredList];
}
-(void)updateFilteredList{
    if(![_search.text isEqualToString:@""] && _search.text){
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@", _search.text];
        _filteredList=[_listToShow filteredArrayUsingPredicate:bPredicate];}
    else{
        _filteredList=_listToShow;
    }
    [_selectiontable reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[_listToShow objectAtIndex:indexPath.row]valueForKey:@"name"];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return  @"add";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate ItemSelected:[_filteredList objectAtIndex:indexPath.row]];
}

- (IBAction)update:(id)sender {
    [self updateFilteredList];
    
}
- (IBAction)done:(id)sender {
    [_delegate done];
}

@end
