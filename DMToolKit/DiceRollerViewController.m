//
//  DiceRollerViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/6/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "DiceRollerViewController.h"
#import "fontsAndColourConstants.h"
#import  <AudioToolbox/AudioToolbox.h>
@interface DiceRollerViewController (){
    NSMutableArray* saveddice;
}

@end

@implementation DiceRollerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  //self.trackedViewName = @"Dice Roller";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _results= [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"diceRolls"];
    saveddice= [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"saveddice"];
    if (_results==nil)_results= [[NSMutableArray alloc]init];
    else _shakeToRollLabel.hidden=YES;
    if(_results.count ==0){
         _shakeToRollLabel.hidden=NO;
    }
    _seletedItems=[[NSMutableArray alloc]init];
    _SelectionTable.layer.borderWidth=1.0f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelectionTableLocation:(CGRect)frame{
    
    _SelectionTable.frame= CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+2, _SelectionTable.frame.size.width ,  _SelectionTable.frame.size.height);
    [UIView animateWithDuration:.5
                          delay: 0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         _SelectionTable.hidden=NO;
                     }completion:^(BOOL finished){
                     }];
    [_SelectionTable reloadData];

}

- (IBAction)diceNumberSelected:(UIButton *)sender {
    _selectedButton= sender;
    _selectionList = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15];
    [self setSelectionTableLocation:sender.frame];
}

- (IBAction)loadDice:(UIButton *)sender {
    _selectedButton=sender;
    NSMutableArray * temparray =[[NSMutableArray alloc]init];
    for (NSDictionary * adice in saveddice){
        [temparray addObject:[adice objectForKey:@"dicenotation"]];
    }
    _selectionList=temparray;
    [self setSelectionTableLocation:sender.frame];
}

- (IBAction)saveDice:(id)sender {
    _SelectionTable.hidden=YES;
    NSString * diceNotation = [NSString stringWithFormat:@"%dd%d",_diceNumber.tag, _dx.tag];
    if(_mutliplier.tag > 1){
        diceNotation= [diceNotation stringByAppendingFormat:@" x %d",_mutliplier.tag];
    }
    if(_modifiers.tag > 0){
        diceNotation= [diceNotation stringByAppendingFormat:@" + %d",_modifiers.tag];
    }
    
    
    NSDictionary* dic = [[NSDictionary alloc]initWithObjects:@[diceNotation,[NSNumber numberWithInt:_diceNumber.tag],[NSNumber numberWithInt:_dx.tag], [NSNumber numberWithInt:_mutliplier.tag],[NSNumber numberWithInt:_modifiers.tag] ] forKeys:@[@"dicenotation", @"diceamount",@"dvalue", @"dicemutiplier", @"addition"]];
    [saveddice addObject:dic];
    [[NSUserDefaults standardUserDefaults]setObject:saveddice forKey:@"saveddice"];
    
}

- (IBAction)dxSelected:(UIButton *)sender {
    _selectedButton= sender;
    _selectionList = @[@2,@4,@6,@8,@10,@12,@20,@100];
    [self setSelectionTableLocation:sender.frame];
}

- (IBAction)mutiplierSelected:(UIButton *)sender {
    _selectedButton= sender;
    _selectionList = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    [self setSelectionTableLocation:sender.frame];
}

- (IBAction)modifierSelected:(UIButton *)sender {
    _selectedButton= sender;
    _selectionList = @[@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,@26,@27,@28,@29,@30];
    [self setSelectionTableLocation:sender.frame];
}

- (IBAction)clearHistory:(id)sender {
    [_results removeAllObjects];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"diceRolls"];
    [_resultsTable reloadData];
    [_seletedItems removeAllObjects];
    _selectedTotal.text =@"0";
}

- (IBAction)didpan:(UIPanGestureRecognizer *)sender {
    NSArray * visibleCells=[_resultsTable visibleCells];
    UITableViewCell * topCell;
    CGPoint translation= [sender translationInView:_resultsTable];
    int leftOffset = _resultsTable.frame.origin.x;
    int topOffset=_resultsTable.frame.origin.y;
    
    if(visibleCells.count > 0) topCell = [visibleCells objectAtIndex:0];
    else {
        topCell= [[UITableViewCell alloc]init];
        topCell.tag=0;
    }
    if (_tempCell==nil){
        _tempCell =[[FeatAndSkillsCell alloc]initWithFrame:CGRectMake(leftOffset, topOffset, _resultsTable.frame.size.width, 0)];
        _tempCell.alpha=0.0;
        _tempCell.textLabel.text=@"Roll Dice";
        [self.view addSubview:_tempCell];
    }
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _newObjectAdded=NO;
            _SelectionTable.hidden=YES;
            
            [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset, _resultsTable.frame.size.width, translation.y/2)];
            break;
        case UIGestureRecognizerStateChanged:
            if ( translation.y /2> 0 && translation.y/2 < 50 && !_newObjectAdded){
                [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset, _resultsTable.frame.size.width, translation.y/2)];
            }
            else if (translation.y/2 > 50 && !_newObjectAdded ){
                [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset, _resultsTable.frame.size.width, translation.y/2)];
                _newObjectAdded=YES;
           
                
            }
            else{
                [_tempCell upateCellWithFrame:CGRectMake(leftOffset, topOffset+ translation.y/2-50, _resultsTable.frame.size.width, 50)];
               // _tempCell.alpha=0.0;
            }
            
            break;
        case UIGestureRecognizerStateEnded:
            [_tempCell removeFromSuperview];
            _tempCell=nil;
            if(_newObjectAdded){
                [self rollDemBones];
            }
            break;
        default:
            break;
    }
}

-(void)rollDemBones{
   
    int total=0;
     _shakeToRollLabel.hidden=YES;
    NSMutableArray * diceResults = [[NSMutableArray alloc]init];
    NSString * diceResultsString=@"[";
    NSString * diceNotation = [NSString stringWithFormat:@"%dd%d",_diceNumber.tag, _dx.tag];
    if(_mutliplier.tag > 1){
        diceNotation= [diceNotation stringByAppendingFormat:@" x %d",_mutliplier.tag];
    }
    if(_modifiers.tag > 0){
          diceNotation= [diceNotation stringByAppendingFormat:@" + %d",_modifiers.tag];
    }
    for (int i =0; i <_diceNumber.tag; i++){
        int dieResult= arc4random() % _dx.tag +1;
        [diceResults addObject: [NSNumber numberWithInt:dieResult]];
        total +=dieResult;
    }
    total *=_mutliplier.tag;
    total += _modifiers.tag;
    
    for (NSNumber * number in diceResults){
        diceResultsString=[diceResultsString stringByAppendingFormat:@"%@,",number];
    }
    diceResultsString =[diceResultsString stringByReplacingCharactersInRange:NSMakeRange(diceResultsString.length-1, 1) withString:@"]"];
                         
    NSDictionary * demBonesDictionary= [[NSDictionary alloc]initWithObjectsAndKeys:diceNotation, @"diceNotation", diceResultsString, @"individualDice", [NSNumber numberWithInt: total],@"total" ,[NSNumber numberWithInt:arc4random() %1000] ,  @"object", nil];
    [_results insertObject:demBonesDictionary atIndex:0];
    [[NSUserDefaults standardUserDefaults]setObject:_results forKey:@"diceRolls"];
    [_resultsTable reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _SelectionTable) return self.selectionList.count;
    return self.results.count;
}


-(UITableViewCell *)configureCell :(UITableViewCell *)cell{
    CGRect frame= CGRectMake(0, 0, _resultsTable.frame.size.width,  40);
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
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_selectedButton == _diceloader){
        return YES;
    }
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Identify cell
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    for (UITextField * field in cell.subviews){
        if ([field isKindOfClass:[UILabel class]] ){
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
       
    if(tableView == _SelectionTable) {
        if(_selectedButton !=_diceloader){
            cell.textLabel.text= [[_selectionList objectAtIndex:indexPath.row]stringValue];
        }else{
            cell.textLabel.text= [_selectionList objectAtIndex:indexPath.row];
        }
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
    }
    else{
        cell= [self configureCell:cell];
        UILabel * totalLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 40)];
        totalLabel.font= [fontsAndColourConstants ApexBook:14];
        totalLabel.textColor= [UIColor whiteColor];
         totalLabel.backgroundColor=[UIColor clearColor];
        totalLabel.text= [[[_results objectAtIndex:indexPath.row] valueForKey:@"total"]stringValue];
        [cell addSubview:totalLabel];
        UILabel * individualDiceLabel=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 150, 40)];
        individualDiceLabel.font= [fontsAndColourConstants ApexBook:14];
        individualDiceLabel.textColor= [UIColor whiteColor];
        
        individualDiceLabel.backgroundColor=[UIColor clearColor];
        individualDiceLabel.text = [[_results objectAtIndex:indexPath.row] valueForKey:@"individualDice"];
        [cell addSubview:individualDiceLabel];
        UILabel * diceNotationLabel=[[UILabel alloc]initWithFrame:CGRectMake(320, 0, 150, 40)];
        diceNotationLabel.font= [fontsAndColourConstants ApexBook:14];
        diceNotationLabel.textColor= [UIColor whiteColor];
        diceNotationLabel.backgroundColor=[UIColor clearColor];
        diceNotationLabel.text = [[_results objectAtIndex:indexPath.row] valueForKey:@"diceNotation"];
        [cell addSubview:diceNotationLabel];
        
    }
    
        cell.tag=indexPath.row;
    
    //Add image background to cell
    
    // cell.textLabel.text= [self textForRowAtIndex:indexPath.row];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView ==_resultsTable){
        if( [_seletedItems containsObject:[_results objectAtIndex:indexPath.row]]){
            [_seletedItems removeObject:[_results objectAtIndex:indexPath.row]];
            
            
        }else{
            [_seletedItems addObject:[_results objectAtIndex:indexPath.row]];
            
        }
        _SelectionTable.hidden=YES;
        [self totalSelectedItems];
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        }else{
            
            [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else{
        
        _selectedButton.tag= [[_selectionList objectAtIndex:indexPath.row]integerValue];
        if (_diceloader==_selectedButton)
            [self loadSavedDice:indexPath.row];
        
        else if(_dx != _selectedButton)
            [_selectedButton setTitle:[NSString stringWithFormat:@"%d",_selectedButton.tag] forState:UIControlStateNormal];
        else
             [_selectedButton setTitle:[NSString stringWithFormat:@"d%d",_selectedButton.tag] forState:UIControlStateNormal];
        _SelectionTable.hidden=YES;
    }

}
-(void)loadSavedDice:(int)index{
    
    NSDictionary* loadedDice = [saveddice objectAtIndex:index];
    
    _dx.tag= [[loadedDice objectForKey:@"dvalue"]intValue];
    [_dx setTitle:[[loadedDice objectForKey:@"dvalue"]  stringValue]forState:UIControlStateNormal];
    
    _diceNumber.tag= [[loadedDice objectForKey:@"diceamount"]intValue];
    [_diceNumber setTitle:[[loadedDice objectForKey:@"diceamount"] stringValue] forState:UIControlStateNormal];
    
    _mutliplier.tag= [[loadedDice objectForKey:@"dicemutiplier"]intValue];
    [_mutliplier setTitle:[[loadedDice objectForKey:@"dicemutiplier"] stringValue] forState:UIControlStateNormal];
    
    _modifiers.tag= [[loadedDice objectForKey:@"addition"]intValue];
    [_modifiers setTitle:[[loadedDice objectForKey:@"addition"] stringValue] forState:UIControlStateNormal];
     
    
}

-(void)totalSelectedItems{
    int Total=0;
    for(NSDictionary * number in _seletedItems){
        Total +=[[number objectForKey:@"total"]integerValue];
    }
    _selectedTotal.text= [NSString stringWithFormat:@"%d",Total];
}


@end
