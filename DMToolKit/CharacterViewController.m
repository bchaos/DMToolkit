//
//  CharacterViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/25/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CharacterViewController.h"

@interface CharacterViewController ()

@end
static NSString * nameKey= @"name";
static NSString * functionKey=@"function";
static NSString * rowKey= @"row";
static NSString * textKey= @"text";
static NSString * placeHolderKey=@"placeHolder";
@implementation CharacterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // //self.trackedViewName = @"Character Creator";
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}
-(void)viewDidAppear:(BOOL)animated{
   
    _myCharacter =[dungeonMasterSingleton sharedInstance].currentCharacter;
    if([dungeonMasterSingleton sharedInstance].toNPCPage){
        _racesTOUse = @"race";
        [JE_ notifyObserver:self selector:@selector(reloadData) name:@"updateHeader"];
    }else{
        _racesTOUse = @"playerRace";
        
  
    }
    if(_myCharacter !=nil){
        [self reloadData];
        
    }else{
        [self addPleaseAdd:@"player" ];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reloadData{
    NSMutableDictionary * characterNameDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Enter Name", placeHolderKey, @"45", @"rowHeight" ,@"name", @"key",  [_myCharacter valueForKey:@"name"], textKey,nil];
    
    NSMutableDictionary * characterNameDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character Name",nameKey, characterNameDefaultData, rowKey, nil];
    
    NSMutableDictionary * characterRaceDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Select a race", placeHolderKey, @"45", @"rowHeight" ,_racesTOUse, @"key", @true , @"isSelector",  _myCharacter.race, @"selector" ,nil];
    
    NSMutableDictionary * characterRaceDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character's Race",nameKey, characterRaceDefaultData, rowKey, nil];
    
    
    NSMutableDictionary * characterClassDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Select a class", placeHolderKey, @"45", @"rowHeight" ,@"class", @"key", @true , @"isSelector", _myCharacter.characterClass, @"selector" ,nil];
    
    NSMutableDictionary * characterClassDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character's Class",nameKey, characterClassDefaultData, rowKey, nil];
    
    
    NSMutableDictionary * characterPersonalityDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Enter Personality Traits", placeHolderKey, @"150", @"rowHeight" ,@"personalTraits", @"key" , [_myCharacter valueForKey:@"personalTraits"], textKey,nil];
    
    NSMutableDictionary * characterPersonalityTraits= [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Personality Traits",nameKey, characterPersonalityDefaultData, rowKey, nil];
    
    NSMutableDictionary * characterMannersDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Enter Mannerisms and Apperance ", placeHolderKey, @"150", @"rowHeight" ,@"apperance", @"key"  ,  [_myCharacter valueForKey:@"apperance"], textKey,nil];
    
    NSMutableDictionary * characterManners= [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Mannerisms and Apperance",nameKey, characterMannersDefaultData, rowKey, nil];
    
    NSMutableDictionary * characterBackgroundDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Enter Character Background ", placeHolderKey, @"150", @"rowHeight" ,@"background", @"key",   [_myCharacter valueForKey:@"background"], textKey,nil];
    
    NSMutableDictionary * characterBackground= [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Background",nameKey, characterBackgroundDefaultData, rowKey, nil];
    
	self.sectionTable=[NSArray arrayWithObjects: characterNameDic,characterRaceDic,characterClassDic,characterPersonalityTraits, characterManners,characterBackground, nil];
    

     [self.table reloadData];
}
-(void)editingChanged:(UITextField*)text{
    [super editingChanged:text];
    [_myCharacter setValue:text.text forKey: [self valueToUpdate:0 inSection:text.tag]];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)setRace:(Race *)race{
    if(_myCharacter.race)
       [_myCharacter.race removeCharacterObject:_myCharacter];
    _myCharacter.race=race;
    [race addCharacterObject:_myCharacter];
    [[dungeonMasterSingleton sharedInstance]save];
    [self reloadData];
}

-(void)setClass:(CharacterClass *)class{
    if(_myCharacter.characterClass)
        [_myCharacter.characterClass removeCharacterObject:_myCharacter];
    _myCharacter.characterClass=class;
    [class addCharacterObject:_myCharacter];
    [[dungeonMasterSingleton sharedInstance]save];
    [self reloadData];
}




@end
