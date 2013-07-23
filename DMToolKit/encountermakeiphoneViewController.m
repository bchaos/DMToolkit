//
//  encountermakeiphoneViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 7/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "encountermakeiphoneViewController.h"

@interface encountermakeiphoneViewController ()

@end

@implementation encountermakeiphoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.tool setUpActionButtonsEncounter];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
