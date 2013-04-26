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

@interface SidebarViewController (){
    NSString * actionFunction;

}
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
    actionFunction=nil;
    
    
      
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
    cell.tag=indexPath.row;
    UILongPressGestureRecognizer * press= [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(editCell:)];
    [cell addGestureRecognizer:press];
    //Add image background to cell
    cell.textLabel.text= [[_SelectionFields objectAtIndex:indexPath.row]objectForKey:nameKey];
        
    
    
    return cell;
}
#pragma mark- TableView Updating functions

-(void)showCharacterTableView:(NSDictionary *)dic{
    actionFunction= kShowCharacterCreator;
 [_SelectionFields removeAllObjects];
}

-(void)showItemsTable:(NSDictionary *)dic{
 [_SelectionFields removeAllObjects];
}


-(void)showNPCSTableView:(NSDictionary *)dic{
 [_SelectionFields removeAllObjects];
}

-(void)showMonstersTableView:(NSDictionary *)dic{
 [_SelectionFields removeAllObjects];
}


-(void)showEncountersTableView:(NSDictionary *)dic{
 [_SelectionFields removeAllObjects];
}

-(void)showCampaignTableView:(NSDictionary *)dic{
 [_SelectionFields removeAllObjects];
}

-(void)showNotesTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
}
-(void)addCharacter{
    
}

-(void)editCell:(UILongPressGestureRecognizer*)press{
   _selectedCellIndex= press.view.tag;
     if(![self.sectionLabel.text isEqualToString:@"Main Menu"]){
         [self startEditing:_editableTextField];
     }
}

-(void)setStartingContnet{
    self.sectionLabel.text= @"Main Menu";
    _SelectionFields = [NSMutableArray arrayWithObjects:
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Players" ,nameKey, @"showCharacterTableView:", functionKey, nil],  [NSDictionary dictionaryWithObjectsAndKeys:@"Items" ,nameKey, @"showItemsTable:", functionKey, nil] , [NSDictionary dictionaryWithObjectsAndKeys:@"NPCs" ,nameKey, @"showNPCSTableView:", functionKey, nil] ,
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Monsters" ,nameKey, @"showMonstersTableView:", functionKey, nil] ,  [NSDictionary dictionaryWithObjectsAndKeys:@"Encounters" ,nameKey, @"showEncountersTableView:", functionKey, nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Campaigns" ,nameKey, @"showCampaignTableView:", functionKey, nil] ,  [NSDictionary dictionaryWithObjectsAndKeys:@"Notes" ,nameKey, @"showNotesTableView:", functionKey, nil] ,nil];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedCellIndex=indexPath.row;
    [self textFieldDidEndEditing: _editableTextField];
    NSDictionary * currentSelectionDictionary =[_SelectionFields objectAtIndex:indexPath.row];
    NSString *functionString = [currentSelectionDictionary objectForKey:functionKey];
    SEL appSelector = NSSelectorFromString(functionString);
    NSString * nameToShow=[currentSelectionDictionary objectForKey:nameKey];
    self.sectionLabel.text = nameToShow;
    [self performSelector:appSelector withObject:currentSelectionDictionary];
    _backbutton.alpha=1.0;
    _searchField.alpha=1.0;
 
       [_searchField resignFirstResponder];
    if(_SelectionFields.count==0){
        _PulldownToAddLabel.alpha=1.0;
        _PulldownToAddLabel.text= [NSString stringWithFormat:@"Pull down to add a %@", [nameToShow substringToIndex:nameToShow.length-1]];
    }
    if(actionFunction !=nil){
        [JE_ notifyName:actionFunction object:nil];
    }
    [self.selectionTable reloadData];

   
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
     if(![self.sectionLabel.text isEqualToString:@"Main Menu"]){
         return YES;
     }
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _selectedCellIndex = indexPath.row;
        [self deleteRow];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if((int)buttonIndex==1 )
        [self deleteRow];
}
-(void)nothing:(id)sender{
    
}
- (IBAction)goBack:(id)sender {
    [self textFieldDidEndEditing: _editableTextField];
    [_searchField resignFirstResponder];

    [self setStartingContnet];
    [self.selectionTable reloadData];
    _backbutton.alpha=0.0;
    _searchField.alpha=0.0;
       _PulldownToAddLabel.alpha=0.0;
    actionFunction=nil;
    [JE_ notifyName:@"goBack" object:nil];
    }
- (IBAction)filterCurrentSection:(id)sender {
}

- (IBAction)addNew:(UIPanGestureRecognizer *)sender {
    if(_newObjectAdded && _isEditing){
        //[self textFieldDidEndEditing: _editableTextField];
            }
    [_searchField resignFirstResponder];
    if(![self.sectionLabel.text isEqualToString:@"Main Menu"]){
    if (_tempCell==nil){
        _tempCell =[[tempSideCellView alloc]initWithFrame:CGRectMake(0, 93, 320, 0)];
        _tempCell.alpha=0.0;
        [self.view addSubview:_tempCell];
    }
 
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _newObjectAdded=NO;
            [_tempCell upateCellWithFrame:CGRectMake(0, 93, 320, [sender translationInView:self.selectionTable].y/2)];
            break;
        case UIGestureRecognizerStateChanged:
            if ( [sender translationInView:self.selectionTable].y /2> 0 && [sender translationInView:self.selectionTable].y/2 < 70 && !_newObjectAdded){
                [_tempCell upateCellWithFrame:CGRectMake(0, 93, 320, [sender translationInView:self.selectionTable].y/2)];
            }
            else if ([sender translationInView:self.selectionTable].y/2 > 70 && !_newObjectAdded ){
               [ _SelectionFields insertObject:[NSDictionary dictionaryWithObjectsAndKeys:@"New" ,nameKey, @"nothing:", functionKey, nil] atIndex:0];
                _newObjectAdded=YES;
                _tempCell.alpha=0.0;
                [_selectionTable reloadData];
                
                [UIView animateWithDuration:.3
                                      delay: 0.0
                                    options: UIViewAnimationOptionAllowUserInteraction
                                 animations:^{
                                        _PulldownToAddLabel.alpha=0.0;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];

           
            }
            else{
                _tempCell.alpha=0.0;
            }
            
            break;
        case UIGestureRecognizerStateEnded:
          
            [_tempCell upateCellWithFrame:CGRectMake(0, 93, 320, [sender translationInView:self.selectionTable].y/2)];
            [_tempCell removeFromSuperview];
            _tempCell=nil;
            if(_newObjectAdded){
                if(actionFunction !=nil){
                    [JE_ notifyName:actionFunction object:nil];
                }
                 _selectedCellIndex=0;
                [self startEditing:_editableTextField];
                _isEditing=true;
               [_editableTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
              
               
            }
            break;
        default:
            break;
    }
    }
}


-(void)deleteRow{
        [_editableTextField resignFirstResponder];
        [_SelectionFields removeObjectAtIndex:_selectedCellIndex];
        [_selectionTable reloadData];

}
#pragma mark textfield delegate


-(void)textFieldDidChange:(UITextField *)textField {
    NSMutableDictionary * textDic= [NSMutableDictionary dictionaryWithDictionary: [_SelectionFields objectAtIndex:_selectedCellIndex]];
    [textDic setObject:textField.text forKey:nameKey];
    [_SelectionFields replaceObjectAtIndex:_selectedCellIndex withObject:textDic];
    [_selectionTable reloadData];
}


-(void)startEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
      NSMutableDictionary * textDic= [NSMutableDictionary dictionaryWithDictionary: [_SelectionFields objectAtIndex:_selectedCellIndex]];
    NSString * currentName= [textDic objectForKey:nameKey];
    if([currentName isEqualToString:@"New"]){
        textField.text=@"";
    }else{
        textField.text= currentName;
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _isEditing=false;


    textField.text=@"";
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
