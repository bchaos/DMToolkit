//
//  InventoryViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 5/6/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "InventoryViewController.h"
#import "fontsAndColourConstants.h"

#import "textfieldWithEdgeInset.h"
@interface InventoryViewController ()

@end

@implementation InventoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // //self.trackedViewName = @"Character Inventory";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [JE_ notifyObserver:self selector:@selector(keyboardShown) name:UIKeyboardWillShowNotification];
    [JE_ notifyObserver:self selector:@selector(keyboardHidden) name:UIKeyboardWillHideNotification];
    _myCharacter = [DuegonMasterSingleton sharedInstance].currentCharacter;
    [self reloadData];
	// Do any additional setup after loading the view.
}

-(void)reloadData{
   NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    _inventoryArray= [[NSMutableArray alloc]initWithArray:[[_myCharacter.inventory allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]]];
    [_inventoryTable reloadData];
    
}
-(void)done{
    [_popover dismissPopoverAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (IBAction)BagOfHoldingIsPanning:(UIPanGestureRecognizer *)sender {
    NSArray * visibleCells=[_inventoryTable visibleCells];
    UITableViewCell * topCell;
    CGPoint translation= [sender translationInView:_inventoryTable];
    int leftOffset = _inventoryTable.frame.origin.x;
    int topOffset=_inventoryTable.frame.origin.y;
    
    if(visibleCells.count > 0) topCell = [visibleCells objectAtIndex:0];
    else {
        topCell= [[UITableViewCell alloc]init];
        topCell.tag=0;
    }
    
    if (topCell.tag !=0) {
        return;
    }
    if (_tempCell==nil){
        _tempCell =[[FeatAndSkillsCell alloc]initWithFrame:CGRectMake(leftOffset, topOffset, _inventoryTable.frame.size.width, 0)];
        _tempCell.alpha=0.0;
        [self.view addSubview:_tempCell];
    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _newObjectAdded=NO;
            [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset, _inventoryTable.frame.size.width, translation.y/2)];
            break;
        case UIGestureRecognizerStateChanged:
            if ( translation.y /2> 0 && translation.y/2 < 50 && !_newObjectAdded){
                [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset, 292, translation.y/2)];
            }
            else if (translation.y/2 > 50 && !_newObjectAdded ){
                
                _newObjectAdded=YES;
                [self clearUnusedItems];
                    [_inventoryArray insertObject:@"" atIndex:0];
                    [_inventoryTable reloadData];
                              
            }
            else{
                _tempCell.alpha=0.0;
            }
            
            break;
        case UIGestureRecognizerStateEnded:
            [_tempCell removeFromSuperview];
            _tempCell=nil;
            if(_newObjectAdded){
                [self addPickerToView];
            }
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
    return _inventoryArray.count;
}

-(UITableViewCell *)configureCell :(UITableViewCell *)cell{
    CGRect frame= CGRectMake(0, 0, _inventoryTable.frame.size.width,  50);
    cell.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FeatsAndSkills.png"]];
    cell.textLabel.frame= frame;
    cell.backgroundView.frame=frame;
    cell.frame=frame;
    cell.textLabel.textColor= [UIColor whiteColor];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.textLabel.font= [fontsAndColourConstants ApexBook:14];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Identify cell
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for (UITextField * field in cell.subviews){
        if ([field isKindOfClass:[UITextField class]] ){
            [field removeFromSuperview];
        }
        if ([field isKindOfClass:[UIButton class]] ){
            [field removeFromSuperview];
        }
        
    }
    
    // Create cell
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Set Text to cell
    cell= [self configureCell:cell];
    NSArray * ArrayToUse ;
    ArrayToUse = _inventoryArray;
    if(![[ArrayToUse objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]){
        cell.textLabel.text= [[ArrayToUse objectAtIndex:indexPath.row]valueForKey:@"name"];
    }else{
        cell.textLabel.text= @"NEW";
    }
    cell.tag=indexPath.row;
    
    //Add image background to cell
    
    // cell.textLabel.text= [self textForRowAtIndex:indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    webViewPopoverViewController *webView= [[webViewPopoverViewController alloc]initWithNibName:@"webViewPopoverViewController" bundle:[NSBundle mainBundle]];
    webView.delegate=self;
    if ([[_inventoryArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])return;
     webView.content=[[_inventoryArray objectAtIndex:indexPath.row]valueForKey:@"fulltext"];
    _popover = [[UIPopoverController alloc]initWithContentViewController:webView];
    _popover.delegate=self;
    UIView * presentationView=[tableView cellForRowAtIndexPath:indexPath];
    [_popover presentPopoverFromRect:CGRectMake(-140, -125, 300, 300) inView:presentationView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
-(void)clearUnusedItems{
    __block NSMutableArray * indexesToRemove= [[NSMutableArray alloc]init];
    [_inventoryArray eachWithIndex:^(id object, int index) {
        if ([object isKindOfClass:[NSString class]]){
            [indexesToRemove addObject: [NSNumber numberWithInt:index ]];
        }
    }];
    __block int i=0;
    [indexesToRemove each:^(NSNumber * object) {
        [_inventoryArray removeObjectAtIndex:[object intValue]-i];
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
      return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Items*curItem=[_inventoryArray objectAtIndex:indexPath.row];
        [_myCharacter removeInventoryObject:curItem];
        [curItem removeCharacterObject:_myCharacter];
        [[DuegonMasterSingleton sharedInstance]save];
        [self reloadData];
        
    }
}
#pragma  mark Picker view functions

-(void)removePickers{
    if(_pickerView){
        [_pickerView removeFromSuperview];
        _pickerView= nil;
    }
}

-(void)addPickerToView{
    [self removePickers];
    _priorInventoryItemSelected=nil;
    _pickerView = [[UIView alloc]initWithFrame:CGRectMake(_inventoryTable.frame.origin.x, 464, 292, 280)];
    _pickerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_pickerView];
    _picker =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 35, 292, 200)];
    _picker.delegate=self;
    _picker.dataSource=self;
    _picker.showsSelectionIndicator=YES;
    [_pickerView addSubview:_picker];
    _pickerSearch= [[textfieldWithEdgeInset alloc]initWithFrame:CGRectMake(0, 0, 292, 35)];
    _pickerSearch.background= [UIImage imageNamed:@"enter_cc.png"];
    _pickerSearch.placeholder=@"Filter list";
    [_pickerSearch addTarget:self  action:@selector(updatePickerFilter) forControlEvents:UIControlEventEditingChanged];
    [_pickerView addSubview:_pickerSearch];
    
    
    UIButton* keyboardDoneButtonView	= [[UIButton alloc] initWithFrame:CGRectMake(0, 210, 292, 20)];
    keyboardDoneButtonView.layer.borderWidth=1.0;
    [keyboardDoneButtonView setTitle:@"Done" forState:UIControlStateNormal];
    keyboardDoneButtonView.backgroundColor=[UIColor blackColor];
    [keyboardDoneButtonView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [keyboardDoneButtonView addTarget:self action:@selector(removePickers) forControlEvents:UIControlEventTouchUpInside];
    [_pickerView addSubview:keyboardDoneButtonView];
    
    // Plug the keyboardDoneButtonView into the text field...
    
    [self updatePickerFilter];
}
-(void)updatePickerFilter{
    _pickerArray= [[DuegonMasterSingleton sharedInstance]AllItems:_pickerSearch.text];
    [_picker reloadAllComponents];
    
}

#pragma mark picker datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_pickerArray count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (!view)
    {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 30)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 3, 170, 24)];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        
        UIButton *eyeView = [[UIButton alloc] initWithFrame:CGRectMake(210, 5, 24, 16)];
        [eyeView setImage:[UIImage imageNamed:@"12-eye.png"] forState:UIControlStateNormal];
        
        eyeView.contentMode = UIViewContentModeScaleToFill;
        [eyeView addTarget:self action:@selector(infoPopup:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:eyeView];
    }
    [(UILabel *)[view.subviews objectAtIndex:0] setText:[[_pickerArray objectAtIndex:row]valueForKey:@"name"] ];
    [(UIButton *)[view.subviews objectAtIndex:1] setTag:row];
    return view;
}

-(void)infoPopup:(UIButton*)button{
    webViewPopoverViewController *webView= [[webViewPopoverViewController alloc]initWithNibName:@"webViewPopoverViewController" bundle:[NSBundle mainBundle]];
    webView.content= [[_pickerArray objectAtIndex:button.tag]valueForKey:@"fulltext"];
    _popover = [[UIPopoverController alloc]initWithContentViewController:webView];
    _popover.delegate=self;
    [_popover presentPopoverFromRect:CGRectMake(-140, -4, 300, 300) inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSManagedObject * pickedItem = [_pickerArray objectAtIndex:row];
  
        
        [_inventoryArray setObject:pickedItem atIndexedSubscript:0];
        if(_priorInventoryItemSelected){
            [((Items *)_priorInventoryItemSelected) removeCharacterObject:_myCharacter];
            [_myCharacter removeInventoryObject:((Items *)_priorInventoryItemSelected)];
        }
        [((Items *)pickedItem) addCharacterObject:_myCharacter];
        [_myCharacter addInventoryObject:((Items *)pickedItem)];
        [_inventoryTable reloadData];
       [[DuegonMasterSingleton sharedInstance]save];
    _priorInventoryItemSelected =pickedItem;
}



#pragma mark keyboard notifcations

-(void)keyboardShown{
    if(_pickerView){
        [UIView animateWithDuration:.2
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _pickerView.frame= CGRectMake(_pickerView.frame.origin.x,
                                                           170,
                                                           280,
                                                           200);
                         }
                         completion:^(BOOL finished){
                         }];
        
    }
}

-(void)keyboardHidden{
    if(_pickerView){
        [UIView animateWithDuration:.2
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _pickerView.frame= CGRectMake(_pickerView.frame.origin.x, 464, 280, 200);
                         }
                         completion:^(BOOL finished){
                         }];
        
    }
}

@end
