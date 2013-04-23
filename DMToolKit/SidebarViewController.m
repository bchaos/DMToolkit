//
//  SidebarViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "SidebarViewController.h"
static NSString * nameKey= @"name";
static NSString * functionKey=@"function";
static NSString * fuctionObject=@"functionObject";
@interface SidebarViewController ()

@end

@implementation SidebarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setStartingContnet];
    
      
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return [_SelectionFields count];
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

    
    cell= [self confgureCell:cell];
    
    //Add image background to cell
    cell.textLabel.text= [[_SelectionFields objectAtIndex:indexPath.row]objectForKey:nameKey];
        
    
    
    return cell;
}
#pragma mark- TableView Updating functions

-(void)showCharacterTableView{
     self.sectionLabel.text= @"Characters";
    _SelectionFields = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"New Character" ,nameKey, @"addCharacter", functionKey, nil],nil ];
}

-(void)showItemsTable{
    self.sectionLabel.text= @"Items";
    _SelectionFields = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"New Item" ,nameKey, @"addItem", functionKey, nil],nil ];
}


-(void)showNPCSTableView{
    self.sectionLabel.text= @"NPCs";
    _SelectionFields = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"New NPC" ,nameKey, @"addNPC", functionKey, nil],nil ];
}

-(void)showMonstersTableView{
    self.sectionLabel.text= @"NPCs";
    _SelectionFields = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"New Monster" ,nameKey, @"addMonster", functionKey, nil],nil ];
}


-(void)showEncountersTableView{
    self.sectionLabel.text= @"Encounters";
    _SelectionFields = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"New Encounter" ,nameKey, @"addEncounter", functionKey, nil],nil ];
}

-(void)showCampaignTableView{
    self.sectionLabel.text= @"Campaigns";
    _SelectionFields = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"New Campaign" ,nameKey, @"addCampaign", functionKey, nil],nil ];
}


-(void)setStartingContnet{
    self.sectionLabel.text= @"Main Menu";
    _SelectionFields = [NSArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Characters" ,nameKey, @"showCharacterTableView", functionKey, nil],  [NSDictionary dictionaryWithObjectsAndKeys:@"Items" ,nameKey, @"showItemsTable", functionKey, nil] , [NSDictionary dictionaryWithObjectsAndKeys:@"NPCs" ,nameKey, @"showNPCSTableView", functionKey, nil] ,
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Monsters" ,nameKey, @"showMonstersTableView", functionKey, nil] ,  [NSDictionary dictionaryWithObjectsAndKeys:@"Encounters" ,nameKey, @"showEncountersTableView", functionKey, nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Campaign" ,nameKey, @"showCampaignTableView", functionKey, nil] ,nil];
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary * currentSelectionDictionary =[_SelectionFields objectAtIndex:indexPath.row];
    NSString *functionString = [currentSelectionDictionary objectForKey:functionKey];
    SEL appSelector = NSSelectorFromString(functionString);
    if([currentSelectionDictionary objectForKey:fuctionObject] ){
        [self performSelector:appSelector withObject:[currentSelectionDictionary objectForKey:fuctionObject]];
    }else{
        [self performSelector:appSelector];
    }
    _backbutton.alpha=1.0;
    _searchField.alpha=1.0;
       [_searchField resignFirstResponder];
    [self.selectionTable reloadData];

   
}


- (IBAction)goBack:(id)sender {
    [self setStartingContnet];
    [self.selectionTable reloadData];
    _backbutton.alpha=0.0;
    _searchField.alpha=0.0;
    [_searchField resignFirstResponder];
}
- (IBAction)filterCurrentSection:(id)sender {
}
@end
