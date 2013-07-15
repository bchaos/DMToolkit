//
//  FeatsAndSkills.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "FeatsAndSkills.h"
#import "fontsAndColourConstants.h"

@interface FeatsAndSkills ()

@end

@implementation FeatsAndSkills

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // //self.trackedViewName = @"Character Feats";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _myCharacter =[DuegonMasterSingleton sharedInstance].currentCharacter;
    [self reloadData];
    [JE_ notifyObserver:self selector:@selector(keyboardShown) name:UIKeyboardWillShowNotification];
    [JE_ notifyObserver:self selector:@selector(keyboardHidden) name:UIKeyboardWillHideNotification];
    
 

	// Do any additional setup after loading the view.
}

-(void)reloadData{
    NSSortDescriptor *nameSort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    _skillsArray=    [[NSMutableArray alloc]initWithArray:[[_myCharacter.characterClass.classSkills allObjects]  sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]]];
    _CharacterSkillCount= _skillsArray.count;
    [_skillsArray addObjectsFromArray:[[_myCharacter.skills allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]]];
    _featsArray = [[NSMutableArray alloc]initWithArray:[[_myCharacter.feats allObjects] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:nameSort, nil]]];
    [_featsTable reloadData];
    [_skillsTable reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark pangesture functions 
- (IBAction)didPan:(UIPanGestureRecognizer *)sender {
    NSArray * visibleCells;
    UITableViewCell * topCell;
    int leftOffset = 0;
    int topOffset=98;
    CGPoint translation;
    if (sender==_featPanner) {
        visibleCells=[_featsTable visibleCells];
        
        leftOffset=341;
        translation= [sender translationInView:_featsTable];
    }
    else {
        visibleCells=[_skillsTable visibleCells];
        leftOffset=20;
        translation= [sender translationInView:_skillsTable];
    }
  
    if(visibleCells.count > 0) topCell = [visibleCells objectAtIndex:0];
    else {
        topCell= [[UITableViewCell alloc]init];
        topCell.tag=0;
    }
    if( topCell.tag != 0 ){
        return;
    }
    if (_tempCell==nil){
        _tempCell =[[FeatAndSkillsCell alloc]initWithFrame:CGRectMake(leftOffset, topOffset, 292, 0)];
        _tempCell.alpha=0.0;
        [self.view addSubview:_tempCell];
    }
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _newObjectAdded=NO;
            [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset, 292, translation.y/2)];
            break;
        case UIGestureRecognizerStateChanged:
            if ( translation.y /2> 0 && translation.y/2 < 50 && !_newObjectAdded){
                [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset, 292, translation.y/2)];
            }
            else if (translation.y/2 > 50 && !_newObjectAdded ){
             
                _newObjectAdded=YES;
                
                if (sender==_featPanner){
                    [self clearUnusedItems];
                    [_featsArray insertObject:@"" atIndex:0];
                    [_featsTable reloadData];
                }else{
                  [self clearUnusedItems];
                    [_skillsArray insertObject:@"" atIndex:0];
                    [_skillsTable reloadData];

                }

            }
            else{
                _tempCell.alpha=0.0;
            }
            
            break;
        case UIGestureRecognizerStateEnded:
            [_tempCell removeFromSuperview];
            _tempCell=nil;
            if(_newObjectAdded){
                [self addPickerToView:leftOffset isSkill:(sender==_skillPanner)];
            }
            break;
        default:
            break;
    }

    
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _featsTable) return self.featsArray.count;
    return self.skillsArray.count;
}

-(UITableViewCell *)configureCell :(UITableViewCell *)cell{
    CGRect frame= CGRectMake(0, 0, 292,  50);
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
    if(tableView == _featsTable) ArrayToUse = _featsArray;
    else  ArrayToUse = _skillsArray;
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

-(void)done{
    [_popover dismissPopoverAnimated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    webViewPopoverViewController *webView= [[webViewPopoverViewController alloc]initWithNibName:@"webViewPopoverViewController" bundle:[NSBundle mainBundle]];
    webView.delegate=self;
    if(tableView == _featsTable  && ![[_featsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]){
     webView.content=[[_featsArray objectAtIndex:indexPath.row]valueForKey:@"fulltext"];   
    }
    else if (![[_skillsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]] ){
      webView.content=[[_skillsArray objectAtIndex:indexPath.row]valueForKey:@"fulltext"];
    }else{
        return;
    }
    _popover = [[UIPopoverController alloc]initWithContentViewController:webView];
    _popover.delegate=self;
    UIView * presentationView=[tableView cellForRowAtIndexPath:indexPath];
    [_popover presentPopoverFromRect:CGRectMake(-140, -125, 300, 300) inView:presentationView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView==_skillsTable && indexPath.row < _CharacterSkillCount)return NO;
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if(tableView == _featsTable){
            Feats*curFeat=[_featsArray objectAtIndex:indexPath.row];
            [_myCharacter removeFeatsObject:curFeat];
            [curFeat removeCharacterObject:_myCharacter];
        }
        else{
            Skills*curSkill=[_skillsArray objectAtIndex:indexPath.row];
            [_myCharacter removeSkillsObject:curSkill];
            [curSkill removeCharacterObject:_myCharacter];
            
        }
        [[DuegonMasterSingleton sharedInstance]save];
        [self reloadData];
       
    }
}


-(void)clearUnusedItems{
    __block NSMutableArray * indexesToRemove= [[NSMutableArray alloc]init];
    [_skillsArray eachWithIndex:^(id object, int index) {
        if ([object isKindOfClass:[NSString class]]){
            [indexesToRemove addObject: [NSNumber numberWithInt:index ]];
        }
    }];
    __block int i=0;
    [indexesToRemove each:^(NSNumber * object) {
        [_skillsArray removeObjectAtIndex:[object intValue]-i];
    }];
    
    __block NSMutableArray * indexesToRemove2= [[NSMutableArray alloc]init];
    [_featsArray eachWithIndex:^(id object, int index) {
        if ([object isKindOfClass:[NSString class]]){
            [indexesToRemove2 addObject: [NSNumber numberWithInt:index ]];
        }
    }];
     i=0;
    [indexesToRemove2 each:^(NSNumber * object) {
        [_featsArray removeObjectAtIndex:[object intValue]-i];
    }];
    
    [_skillsTable reloadData];
    [_featsTable reloadData];
}
#pragma  mark PickerView Functions

-(void)removePickers{
    if(_pickerView){
        [_pickerView removeFromSuperview];
        _pickerView= nil;
        
    }
}

-(void)addPickerToView:(int)leftOffset isSkill :(BOOL)isSkill{
    
    [self removePickers];
    
    _priorSelectedStat=nil;
    _pickerView = [[UIView alloc]initWithFrame:CGRectMake(leftOffset, 464, 292, 280)];
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
   
    [self updatePickerFilter:isSkill];
    
}

-(void)updatePickerFilter:(BOOL)isSkill{
    if(isSkill){
        _pickerArray= [[DuegonMasterSingleton sharedInstance]AllSkills:_pickerSearch.text];
    }else{
          _pickerArray= [[DuegonMasterSingleton sharedInstance]AllFeats:_pickerSearch.text];
    }
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
    
    NSManagedObject * pickedStat = [_pickerArray objectAtIndex:row];
    if([pickedStat isKindOfClass:[Feats class]]){
        
        [_featsArray setObject:pickedStat atIndexedSubscript:0];
        if(_priorSelectedStat){
            [((Feats *)_priorSelectedStat) removeCharacterObject:_myCharacter];
            [_myCharacter removeFeatsObject:((Feats *)_priorSelectedStat)];
        }
        [((Feats *)pickedStat) addCharacterObject:_myCharacter];
        [_myCharacter addFeatsObject:((Feats *)pickedStat)];
        [_featsTable reloadData];
        
    }else{
        [_skillsArray setObject:pickedStat atIndexedSubscript:0];
        if(_priorSelectedStat){
            [((Skills *)_priorSelectedStat) removeCharacterObject:_myCharacter];
            [_myCharacter removeSkillsObject:((Skills *)_priorSelectedStat)];
        }
        [((Skills *)pickedStat) addCharacterObject:_myCharacter];
        [_myCharacter addSkillsObject:((Skills *)pickedStat)];
        [_skillsTable reloadData];
    }
    [[DuegonMasterSingleton sharedInstance]save];
    _priorSelectedStat =pickedStat;
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
