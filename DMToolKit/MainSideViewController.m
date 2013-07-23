//
//  MainViewController.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "MainSideViewController.h"
#import "SidebarController1.h"
#import "FlatTheme.h"
#import "Utils.h"
#import "fontsAndColourConstants.h"
@interface MainSideViewController (){
    UIStoryboard *mainStoryBoard;
}

@end

@implementation MainSideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)setupSidebars{
    UIStoryboard* diceRoller = [UIStoryboard storyboardWithName:@"dicerolleriphone" bundle:nil];
    self.diceBar = [diceRoller instantiateViewControllerWithIdentifier:@"dice"];
    UIStoryboard* sidebarStoryboard = [UIStoryboard storyboardWithName:@"SidebarStoryboard" bundle:nil];
    self.normalSideBar = [sidebarStoryboard instantiateViewControllerWithIdentifier:@"SidebarController1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setupSidebars ];
   mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard@iphone" bundle:nil];
    
    UIViewController* frontController =  [mainStoryBoard instantiateViewControllerWithIdentifier:@"campaignsmain"];
    frontController.view.backgroundColor = [fontsAndColourConstants MentorLightBlue];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:frontController];
    
    frontController= [self setUpbarItems:frontController];
  
    self.contentViewController = nav;
    
    [self setupObservers];

}
-(void)setupObservers{
    [JE_ notifyObserver:self selector:@selector(openCampaignViewer) name:@"toCampaign"];
    
     [JE_ notifyObserver:self selector:@selector(openNoteTaker) name:@"toNoteTaker"];
    
    [JE_ notifyObserver:self selector:@selector(openComdendiumViewer) name:@"toReferenceViewer"];
    
    [JE_ notifyObserver:self selector:@selector(openEncounterViewer) name:@"toEncounterViewer"];
    
    [JE_ notifyObserver:self selector:@selector(openCharacterViewer) name:kShowCharacterCreator];
    
     [JE_ notifyObserver:self selector:@selector(showNPCCharacterCreator) name:kShowCharacterCreatorNPC];
   
}

-(UIViewController *)setUpbarItems:(UIViewController *)frontController{
    [FlatTheme styleNavigationBarWithFontName:@"ApexSans-Light" andColor:[fontsAndColourConstants MentorBlueGray]];
    
    [FlatTheme styleToolbarWithFontName:@"ApexSans-Light" andColor:[fontsAndColourConstants MentorBlueGray]];
    [FlatTheme styleTabBar:@"" andColor:[fontsAndColourConstants MentorBlueGray] ];
    UIButton* menuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 14)];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"259-list-white.png"] forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rollDiceButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 28)];
    [rollDiceButton setBackgroundImage:[UIImage imageNamed:@"130-dice-white.png"] forState:UIControlStateNormal];
    [rollDiceButton addTarget:self action:@selector(revealDiceToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem* menuItem = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    UIBarButtonItem* rollItem = [[UIBarButtonItem alloc] initWithCustomView:rollDiceButton];
    
    frontController.navigationItem.leftBarButtonItems= @[menuItem];
    frontController.navigationItem.rightBarButtonItems= @[rollItem];
    return frontController;
}

-(void)closeSide{
    if(self.sidebarShowing)
         [super toggleSidebar:!self.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}


-(void)openCampaignViewer{
 
     [self openViewer:@"campaignViewer"];
}

-(void)openNoteTaker{

     [self openViewer:@"notetaking"];
  
}


-(void)openComdendiumViewer{
     [self openViewer:@"compendium"];
}

-(void)openEncounterViewer{

    [self openViewer:@"encounter"];
    
}

-(void)openCharacterViewer{
    [dungeonMasterSingleton sharedInstance].toNPCPage=NO;
    [self openViewer:@"character"];
}

-(void)openViewer:(NSString *)name{
    [self closeSide];
    [(UINavigationController *)self.contentViewController popToRootViewControllerAnimated:NO];
    UIViewController* compView= [mainStoryBoard instantiateViewControllerWithIdentifier:name];
    compView = [self setUpbarItems:compView];
    [(UINavigationController *)self.contentViewController  pushViewController:compView animated:YES];

}
-(void)showNPCCharacterCreator{
    [dungeonMasterSingleton sharedInstance].toNPCPage=YES;
    [self openViewer:@"character"];
    
    
}
-(void)addCampainInfo{

    
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.title = self.contentViewController.title;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)revealDiceToggle:(id)sender{
    self.sidebarViewController=self.diceBar;
    [super toggleSidebar:!self.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}

- (void)revealToggle:(id)sender {
   
    self.sidebarViewController=self.normalSideBar;
    [super toggleSidebar:!self.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}

- (void)revealGesture:(UIPanGestureRecognizer *)recognizer {
    
    [super dragContentView:recognizer];
}



@end

