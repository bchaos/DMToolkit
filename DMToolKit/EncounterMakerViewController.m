//
//  EncounterMakerViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/31/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "EncounterMakerViewController.h"

@interface EncounterMakerViewController ()

@end

@implementation EncounterMakerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  //self.trackedViewName = @"Encounter map maker viewed";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mapDataString= @"BasicEncounterText"; 
	// Do any additional setup after loading the view.
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)createSideBar{
    [self.sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"111-user.png"]    withMode:8 offset:10]];
    
     [self.sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"132-ghost.png"]    withMode:9 offset:63]];
    
    [self.sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"179-notepad.png"]   withMode:6 offset:116]];
    
    [self.sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"22-skull-n-bones.png"] withMode:7 offset:169]];
}

@end
