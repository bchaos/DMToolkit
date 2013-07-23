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
@implementation BaseTableViewController{
    int pickedTag;
}

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
    [JE_ notifyObserver:self selector:@selector(keyboardShown) name:UIKeyboardWillShowNotification];
    [JE_ notifyObserver:self selector:@selector(keyboardHidden) name:UIKeyboardWillHideNotification];

}
-(void)viewWillDisappear:(BOOL)animated{
    [[dungeonMasterSingleton sharedInstance]save];
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return 1;
}



#pragma mark - Table view data source

-(NSMutableDictionary *)rowForIndex:(int)index inSection:(int)sectionIndex{
    return  [[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey];
}

-(void)setText:(NSString*)text forRowAtIndex:(int)index inSection:(int)sectionIndex{

    [[[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey] setObject:text forKey:textKey];

}
-(NSString * )placeHolderForRowAtIndex:(int)index inSection:(int)sectionIndex{
    
    return [[[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey]  objectForKey:placeHolderKey];
    
}


-(NSString * )valueToUpdate:(int)index inSection:(int)sectionIndex{
    
    return [[[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey]  objectForKey:@"key"];
    
}

-(int)heightAtIndexInSection:(int) sectionIndex andRow:(int)rowIndex{
    
    return  [[[[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey]  objectForKey:@"rowHeight"] integerValue];

}

-(NSString *) textForRowAtIndex:(int)index inSection:(int)sectionIndex{
    return [[[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey]  objectForKey:textKey];
}

-(NSManagedObject *) selectorForSection:(int)index inSection:(int)sectionIndex{
    return [[[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey]  objectForKey:@"selector"];
}

-(BOOL)isSelectorAtIndex:(int)sectionIndex{

    if([[[self.sectionTable objectAtIndex:sectionIndex]objectForKey:rowKey]objectForKey:@"isSelector"]){
        return YES;
    }
    return NO;
}
#pragma mark textField modifiers
-(UITableViewCell *)addFieldTextToCell:(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect frame= CGRectMake(50, 10, cell.frame.size.width,  [self heightAtIndexInSection:indexPath.section andRow:indexPath.row]);

    UITextField * fieldText= [[UITextField alloc]initWithFrame:frame];
    [cell addSubview:fieldText];
    fieldText.placeholder= [self placeHolderForRowAtIndex:indexPath.row inSection:indexPath.section];
    fieldText.text= [ self textForRowAtIndex:indexPath.row inSection:indexPath.section];
    [fieldText addTarget:self action:@selector(editingChanged:) forControlEvents:UIControlEventEditingChanged];
    [fieldText addTarget:self action:@selector(editingBegan:) forControlEvents:UIControlEventEditingDidBegin];
    fieldText.tag= indexPath.section;
    return cell;
}

-(UITableViewCell *)addSelectorButtonToCell :(UITableViewCell *)cell cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGRect frame= CGRectMake(0, 0, cell.frame.size.width,  [self heightAtIndexInSection:indexPath.section andRow:indexPath.row]);

    UIButton * seletorButton =[[UIButton alloc]initWithFrame:frame];
    [cell addSubview:seletorButton];
    [seletorButton addTarget:self action:@selector(showSelector:) forControlEvents:UIControlEventTouchUpInside];
    seletorButton.tag=indexPath.section;
    [seletorButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSManagedObject * object =[self selectorForSection:indexPath.row inSection:indexPath.section];
    if(object){
        [seletorButton setTitle:[object valueForKey:nameKey] forState:UIControlStateNormal];
    }else{
         [seletorButton setTitle: [ self placeHolderForRowAtIndex:indexPath.row inSection:indexPath.section] forState:UIControlStateNormal];
    }
    
    return cell;
}

#pragma mark textfield datasource
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
    cell= [self configureBodyCell:cell];
    CGRect frame= CGRectMake(50, 10, cell.frame.size.width,  [self heightAtIndexInSection:indexPath.section andRow:indexPath.row]);
    
    if (![self isSelectorAtIndex:indexPath.section]){
       cell=[self addFieldTextToCell:cell cellForRowAtIndexPath:indexPath];
    }else{
        cell=[self addSelectorButtonToCell:cell cellForRowAtIndexPath:indexPath];
    }
    
    cell.textLabel.frame= frame;
    cell.backgroundView.frame=frame;
    cell.frame=frame;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
 
    cell.tag=indexPath.row;
    if (cell.tag == _selectedCell){
        cell.selected=YES;
    }
    //Add image background to cell
    
   // cell.textLabel.text= [self textForRowAtIndex:indexPath.row];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightAtIndexInSection:indexPath.section andRow:indexPath.row];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
 return [[self.sectionTable objectAtIndex:section] objectForKey:nameKey];
}


-(void)editingChanged:(UITextField*)text{
    [self setText:text.text forRowAtIndex:0 inSection:text.tag];
    
}

-(void)resetSelectedCell{
    _selectedCell= -1;
    [self.table reloadData];
}
-(void)editingBegan:(UITextField*)text{
      if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
     [self resetPicker];
    
    CGRect startingRect=[_table rectForSection:text.tag] ;
    startingRect.origin.y+= 400;

    if(!_resized)
    _table.contentSize= CGSizeMake(_table.frame.size.width, _table.contentSize.height+600);
    [_table scrollRectToVisible:startingRect animated:YES];
      }
   

}
-(void)addPleaseAdd:(NSString *)nameToBegin{
    UILabel  * label= [[UILabel alloc]initWithFrame:CGRectMake(200, 200, 500, 400)];
    label.numberOfLines=0;
    label.text= [NSString stringWithFormat:@"Please add a %@ to begin.", nameToBegin];
    label.backgroundColor=[UIColor clearColor];
    [self.view addSubview:label];
}


#pragma mark selector
-(void)resetPicker{
    if(_pickerView){
        [_picker removeFromSuperview];
        _picker=nil;
        [_pickerSearch removeFromSuperview];
        _pickerSearch= nil;
        [_pickerView removeFromSuperview];
        _pickerView=nil;
    }
}

-(void)addPickerToView:(int)tag{
    pickedTag=tag;
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    [self.view endEditing:YES];
    _pickerView = [[UIView alloc]initWithFrame:CGRectMake(20, 520, 280, 179)];
 
    _pickerView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_pickerView];
    _picker =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 35, 280, 179)];
    
    _picker.delegate=self;
    _picker.dataSource=self;
    _picker.showsSelectionIndicator=YES;
    [_pickerView addSubview:_picker];
    _pickerSearch= [[textfieldWithEdgeInset alloc]initWithFrame:CGRectMake(0, 0, 280, 35)];
    _pickerSearch.background= [UIImage imageNamed:@"enter_cc.png"];
    _pickerSearch.placeholder=@"Filter list";

    [_pickerSearch addTarget:self  action:@selector(updatePickerFilter) forControlEvents:UIControlEventEditingChanged];
    [_pickerView addSubview:_pickerSearch];
    [self updatePickerFilter];
  }
  else{
      NSString * value = [self valueToUpdate:0 inSection:pickedTag];
      NSArray * initalList;
      if([value isEqualToString:@"class"]){
           initalList= [[ dungeonMasterSingleton sharedInstance]AllCharacterClasses:nil];
      }else if ([value isEqualToString:@"playerRace"]){
           initalList= [[ dungeonMasterSingleton sharedInstance]allPlayerRaces:nil];
      }else if ([value isEqualToString:@"items"]){
           initalList= [[ dungeonMasterSingleton sharedInstance]AllItems:nil];
      }else if ([value isEqualToString:@"skills"]){
           initalList= [[ dungeonMasterSingleton sharedInstance]AllSkills:nil];
      }else if ([value isEqualToString:@"feats"]){
           initalList= [[ dungeonMasterSingleton sharedInstance]AllFeats:nil];
      }else if ([value isEqualToString:@"race"]){
           initalList= [[ dungeonMasterSingleton sharedInstance]AllRace:nil];
      }

      
      iphoneSelectionViewController * selection = [[iphoneSelectionViewController alloc]init];
      [selection setList:initalList];
      selection.delegate=self;
      [self presentViewController:selection animated:YES completion:nil];

      
  }
}
-(void)ItemSelected:(NSManagedObject *)object{
    [self done];
    NSString * value = [self valueToUpdate:0 inSection:pickedTag];
    if([value isEqualToString:@"class"]){
        [self setClass: (CharacterClass*)object];
    }else if ([value isEqualToString:@"race"]){
        [self setRace:(Race *) object];
    }else if ([value isEqualToString:@"items"]){
        [self setItem: (Items *) object];
    }else if ([value isEqualToString:@"skills"]){
        [self setSkill:(Skills *) object];
    }else if ([value isEqualToString:@"feats"]){
        [self setFeat:(Feats *) object];
    }else if ([value isEqualToString:@"playerRace"]){
        [self setRace:(Race *) object];
    }
}
-(void)done{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)showSelector:(UIButton*)button{
     [self resetPicker];
    CGRect startingRect=[_table rectForSection:button.tag] ;
    startingRect.origin.y+= 400;
    if(!_resized)
        _table.contentSize= CGSizeMake(_table.frame.size.width, _table.contentSize.height+600);
    
    [self addPickerToView:button.tag];

}
#pragma mark picker filterData

-(void)updatePickerFilter{
    NSString * value = [self valueToUpdate:0 inSection:pickedTag];
    if([value isEqualToString:@"class"]){
        _pickerArray= [[ dungeonMasterSingleton sharedInstance]AllCharacterClasses:_pickerSearch.text];
    }else if ([value isEqualToString:@"playerRace"]){
         _pickerArray= [[ dungeonMasterSingleton sharedInstance]allPlayerRaces:_pickerSearch.text];
    }else if ([value isEqualToString:@"items"]){
        _pickerArray= [[ dungeonMasterSingleton sharedInstance]AllItems:_pickerSearch.text];
    }else if ([value isEqualToString:@"skills"]){
        _pickerArray= [[ dungeonMasterSingleton sharedInstance]AllSkills:_pickerSearch.text];
    }else if ([value isEqualToString:@"feats"]){
        _pickerArray= [[ dungeonMasterSingleton sharedInstance]AllFeats:_pickerSearch.text];
    }else if ([value isEqualToString:@"race"]){
        _pickerArray= [[ dungeonMasterSingleton sharedInstance]AllRace:_pickerSearch.text];
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
    [(UILabel *)[view.subviews objectAtIndex:0] setText:[[_pickerArray objectAtIndex:row]valueForKey:nameKey] ];
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
    NSString * value = [self valueToUpdate:0 inSection:pickedTag];
    if([value isEqualToString:@"class"]){
        [self setClass: [_pickerArray objectAtIndex:row]];
    }else if ([value isEqualToString:@"race"]){
         [self setRace: [_pickerArray objectAtIndex:row]];
    }else if ([value isEqualToString:@"items"]){
        [self setItem: [_pickerArray objectAtIndex:row]];
    }else if ([value isEqualToString:@"skills"]){
         [self setSkill: [_pickerArray objectAtIndex:row]];
    }else if ([value isEqualToString:@"feats"]){
         [self setFeat: [_pickerArray objectAtIndex:row]];
    }else if ([value isEqualToString:@"playerRace"]){
        [self setRace: [_pickerArray objectAtIndex:row]];
    }
}



#pragma mark keyboard notifcations

-(void)keyboardShown{
    if(_pickerView){
        [UIView animateWithDuration:.2
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             _pickerView.frame= CGRectMake(20,
                                                           220,
                                                          280,
                                                          179);
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
                             _pickerView.frame= CGRectMake(20, 520, 280, 179);
                         }
                         completion:^(BOOL finished){
                         }];
        
    }
}

@end
