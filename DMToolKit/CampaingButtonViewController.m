//
//  CampaingButtonViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 6/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CampaingButtonViewController.h"

@interface CampaingButtonViewController ()

@end

@implementation CampaingButtonViewController

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
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [self setupTitle];
    
}
-(void)setupTitle{
    self.CampainTitle.text=self.campaign.name;
    self.CampainTitle.font=[fontsAndColourConstants DNDFont:20];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToCampaing:(id)sender {
    [DuegonMasterSingleton sharedInstance].currentCampaign=self.campaign;
    [DuegonMasterSingleton sharedInstance].currentMap=self.campaign.map;
    [JE_ notifyName:@"toCampaign" object:nil];
}
@end
