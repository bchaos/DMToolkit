//
//  BaseTableViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/25/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end
static NSString * nameKey= @"name";
static NSString * functionKey=@"function";
static NSString * rowKey= @"row";
static NSString * textKey= @"text";
static NSString * placeHolderKey=@"placeHolder";
@implementation BaseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _selectedCell=-1;
    [self addEditFieldToScreen];
}
-(void)addEditFieldToScreen{
    _editField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    [self.view addSubview:_editField];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pulledDown:(id)sender {
}

-(UITableViewCell*)configureHeaderCell:(UITableViewCell*)cell{
    
}

-(UITableViewCell*)configureBodyCell:(UITableViewCell*)cell{
    return cell;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.sectionTable.count;
}

-(NSArray *)rowsInSection:(int)sectionIndex{
    return [[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return [self rowsInSection:section].count;
}



#pragma mark - Table view data source
-(void)setText:(NSString*)text forRowAtIndex:(int)index{
    int j=0;
    for(int i =0 ; i < self.sectionTable.count ; i++){
        NSArray * rowForSection = [self rowsInSection:i];
        j+= rowForSection.count;
        if ( j > index){
            [[rowForSection objectAtIndex:j-index-1 ]setObject:text forKey:textKey];
        }
    }

}
-(NSString * )placeHolderForRowAtIndex:(int)index{
    int j=0;
    for(int i =0 ; i < self.sectionTable.count ; i++){
        NSArray * rowForSection = [self rowsInSection:i];
        j+= rowForSection.count;
        if ( j > index){
            return [[rowForSection objectAtIndex:j-index-1 ]objectForKey:placeHolderKey];
        }
    }
    return @"unknown";
}

-(NSString *) textForRowAtIndex:(int)index{
    int j=0;
    for(int i =0 ; i < self.sectionTable.count ; i++){
        NSArray * rowForSection = [self rowsInSection:i];
        j+= rowForSection.count;
        if ( j > index){
            return [[rowForSection objectAtIndex:j-index-1 ]objectForKey:textKey];
        }
    }
    return @"unknown";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Identify cell
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Create cell
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Set Text to cell
    cell= [self configureBodyCell:cell];
    UITextField * fieldText= [[UITextField alloc]initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    [cell addSubview:fieldText];
    fieldText.placeholder= [self placeHolderForRowAtIndex:indexPath.row];
    fieldText.text= [ self textForRowAtIndex:indexPath.row];
     [fieldText addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventValueChanged];    fieldText.tag= indexPath.row;
    cell.tag=indexPath.row;
    if (cell.tag == _selectedCell){
        cell.selected=YES;
    }
    //Add image background to cell
    
   // cell.textLabel.text= [self textForRowAtIndex:indexPath.row];
    
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
 return [[self.sectionTable objectAtIndex:section] objectForKey:nameKey];
}

-(void)editingChanged:(UITextField*)text{
    [self setText:text.text forRowAtIndex:text.tag];
    [self.table reloadData];
}

-(void)resetSelectedCell{
    _selectedCell= -1;
    [self.table reloadData];
}
@end
