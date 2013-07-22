//
//  landingPageViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "landingPageViewController.h"
#import "DefaultData.h"
#import "CharacterViewController.h"
@interface landingPageViewController ()

@end

@implementation landingPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     // //self.trackedViewName = @"Landing Screen";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
	[[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(showCharacterCreator)
                                                name:kShowCharacterCreator
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(showNPCCharacterCreator)
                                                name:kShowCharacterCreatorNPC
                                              object:nil];
    [JE_ notifyObserver:self selector:@selector(showReferenceViewer) name:@"toReferenceViewer"];
    [JE_ notifyObserver:self selector:@selector(toNoteTaker) name:@"toNoteTaker"];
    [JE_ notifyObserver:self selector:@selector(toCampaign) name:@"toCampaign"];
    [JE_ notifyObserver:self selector:@selector(toEncounters) name:@"toEncounterViewer"];

   // self.navigationController.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
}
-(void)addCampaigns{
    [self.topStack removeAllButtons];
    [self.bottomStack removeAllButtons];
    _buttons =[[NSMutableArray alloc]init];
    __block int i =0;
    self.topStack.gutter=10;
    self.topStack.isHorizontal=YES;
    self.bottomStack.gutter=10;
    self.bottomStack.isHorizontal=YES;
    [[[dungeonMasterSingleton sharedInstance]AllCampaigns:nil]each:^(Campaign *camp) {
        CampaingButtonViewController * myButton = [[ CampaingButtonViewController alloc]initWithNibName:@"CampaingButtonViewController" bundle:[NSBundle mainBundle]];
        myButton.campaign= camp;
        [_buttons addObject:myButton];
        if(i % 2==0){
            [self.topStack addButton:myButton.view];
        }else {
            [self.bottomStack addButton:myButton.view];
        }
        i++;
    
    }];

    self.scroller.contentSize=CGSizeMake(205* i/2  , self.scroller.frame.size.height);

}


-(void)viewDidAppear:(BOOL)animated{
    [self addCampaigns];
    [_spinner stopAnimating];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showCharacterCreator{
    [dungeonMasterSingleton sharedInstance].toNPCPage=NO;
     [self.navigationController popToRootViewControllerAnimated:NO];
    [self performSegueWithIdentifier:@"toCharacterSheet" sender:self];
}
-(void)showNPCCharacterCreator{
    [dungeonMasterSingleton sharedInstance].toNPCPage=YES;
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self performSegueWithIdentifier:@"toCharacterSheet" sender:self];
}
-(void)showReferenceViewer{
     [self.navigationController popToRootViewControllerAnimated:NO];
     [self performSegueWithIdentifier:@"toReferenceViewer" sender:self];
}
-(void)toNoteTaker{
     [self.navigationController popToRootViewControllerAnimated:NO];
    [self performSegueWithIdentifier:@"toNoteTakerView" sender:self];
}

-(void)toCampaign{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self performSegueWithIdentifier:@"toCampaign" sender:self];
}
-(void)toEncounters{
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self performSegueWithIdentifier:@"toEncounterViewer" sender:self];
}



@end
