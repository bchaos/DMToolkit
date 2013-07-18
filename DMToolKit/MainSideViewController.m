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
@interface MainSideViewController ()

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
   
    UIViewController* frontController = [[UIViewController alloc] init];
    frontController.view.backgroundColor = [fontsAndColourConstants MentorLightBlue];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:frontController];
    
    [FlatTheme styleNavigationBarWithFontName:@"ApexSans-Light" andColor:[fontsAndColourConstants MentorBlueGray]];
    

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
    self.contentViewController = nav;
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

