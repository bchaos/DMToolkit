//
//  CharacterStatViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/29/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CharacterStatViewController.h"

@interface CharacterStatViewController ()

@end
static NSString * nameKey= @"name";
static NSString * functionKey=@"function";
static NSString * rowKey= @"row";
static NSString * textKey= @"text";
static NSString * placeHolderKey=@"placeHolder";
@implementation CharacterStatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // //self.trackedViewName = @"Character Stats";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _myCharacter =[dungeonMasterSingleton sharedInstance].currentCharacter;
    if(_myCharacter !=nil){
        NSMutableDictionary * characterStrengthDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Strength", placeHolderKey, @"45", @"rowHeight" ,@"strength", @"key",  [_myCharacter valueForKey:@"strength"], textKey,nil];
        
        NSMutableDictionary * characterStrengthDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character Strength",nameKey, characterStrengthDefaultData, rowKey, nil];
        
        
        NSMutableDictionary * characterconstitutionDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Constitution", placeHolderKey, @"45", @"rowHeight" ,@"constitution", @"key",  [_myCharacter valueForKey:@"constitution"], textKey,nil];
        
        NSMutableDictionary * characterconstitutionDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character constitution",nameKey, characterconstitutionDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterdexterityDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Dexterity", placeHolderKey, @"45", @"rowHeight" ,@"dexterity", @"key",  [_myCharacter valueForKey:@"dexterity"], textKey,nil];
        
        NSMutableDictionary * characterdexterityDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character dexterity",nameKey, characterdexterityDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterintelligenceDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"intelligence", placeHolderKey, @"45", @"rowHeight" ,@"intelligence", @"key",  [_myCharacter valueForKey:@"intelligence"], textKey,nil];
        
        NSMutableDictionary * characterintelligenceDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character intelligence",nameKey, characterintelligenceDefaultData, rowKey, nil];
        
        
        NSMutableDictionary * characterwisdomDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Wisdom", placeHolderKey, @"45", @"rowHeight" ,@"wisdom", @"key",  [_myCharacter valueForKey:@"wisdom"], textKey,nil];
        
        NSMutableDictionary * characterwisdomDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character wisdom",nameKey, characterwisdomDefaultData, rowKey, nil];
        
        
        NSMutableDictionary * charactercharismaDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Charisma", placeHolderKey, @"45", @"rowHeight" ,@"charisma", @"key",  [_myCharacter valueForKey:@"charisma"], textKey,nil];
        
        NSMutableDictionary * charactercharismaDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character charisma",nameKey, charactercharismaDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterinitiativeDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Initiative", placeHolderKey, @"45", @"rowHeight" ,@"initiative", @"key",  [_myCharacter valueForKey:@"initiative"], textKey,nil];
        
        NSMutableDictionary * characterinitiativeDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character initiative",nameKey, characterinitiativeDefaultData, rowKey, nil];
        
        NSMutableDictionary * characteracDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Armor Class", placeHolderKey, @"45", @"rowHeight" ,@"ac", @"key",  [_myCharacter valueForKey:@"ac"], textKey,nil];
        
        NSMutableDictionary * characteracDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character Armor Class",nameKey, characteracDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterfortitudeDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Fortitude", placeHolderKey, @"45", @"rowHeight" ,@"fortitude", @"key",  [_myCharacter valueForKey:@"fortitude"], textKey,nil];
        
        NSMutableDictionary * characterfortiitudeDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character fortiitude",nameKey, characterfortitudeDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterwillDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Will", placeHolderKey, @"45", @"rowHeight" ,@"will", @"key",  [_myCharacter valueForKey:@"will"], textKey,nil];
        
        NSMutableDictionary * characterwillDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character will",nameKey, characterwillDefaultData, rowKey, nil];
        
        
        NSMutableDictionary * characterreflexDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Reflex", placeHolderKey, @"45", @"rowHeight" ,@"reflex", @"key",  [_myCharacter valueForKey:@"reflex"], textKey,nil];
        
        NSMutableDictionary * characterreflexDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character reflex",nameKey, characterreflexDefaultData, rowKey, nil];
        
        
        NSMutableDictionary * characteractionPointsDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Action Points", placeHolderKey, @"45", @"rowHeight" ,@"actionPoints", @"key",  [_myCharacter valueForKey:@"actionPoints"], textKey,nil];
        
        NSMutableDictionary * characteractionPointsDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character actionPoints",nameKey, characteractionPointsDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterspeedDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Speed", placeHolderKey, @"45", @"rowHeight" ,@"speed", @"key",  [_myCharacter valueForKey:@"speed"], textKey,nil];
        
        NSMutableDictionary * characterspeedDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character speed",nameKey, characterspeedDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterinsightDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Passive insight", placeHolderKey, @"45", @"rowHeight" ,@"insight", @"key",  [_myCharacter valueForKey:@"insight"], textKey,nil];
        
        NSMutableDictionary * characterinsightDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character insight",nameKey, characterinsightDefaultData, rowKey, nil];
        
        NSMutableDictionary * characterperceptionDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Passive Perception", placeHolderKey, @"45", @"rowHeight" ,@"perception", @"key",  [_myCharacter valueForKey:@"perception"], textKey,nil];
        
        NSMutableDictionary * characterperceptionDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character perception",nameKey, characterperceptionDefaultData, rowKey, nil];
        
        
        NSMutableDictionary * charactercurrentXPDefaultData = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"Current XP", placeHolderKey, @"45", @"rowHeight" ,@"currentXP", @"key",  [_myCharacter valueForKey:@"currentXP"], textKey,nil];
        
        NSMutableDictionary * charactercurrentXPDic= [NSDictionary dictionaryWithObjectsAndKeys:@"Character currentXP",nameKey, charactercurrentXPDefaultData, rowKey, nil];
        
        
        self.sectionTable=[NSArray arrayWithObjects: characterStrengthDic, characterconstitutionDic, characterdexterityDic,characterintelligenceDic , characterwisdomDic, charactercharismaDic,characterinitiativeDic,characteracDic, characterfortiitudeDic, characterwillDic,characterreflexDic,characteractionPointsDic,characterspeedDic,characterinsightDic,characterperceptionDic,charactercurrentXPDic,nil];
        
    }else{
        [self addPleaseAdd:@"player" ];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)editingChanged:(UITextField*)text{
    [super editingChanged:text];
    [_myCharacter setValue:text.text forKey: [self valueToUpdate:0 inSection:text.tag]];
}
@end
