//
//  landingPageViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "landingPageViewController.h"

@interface landingPageViewController ()

@end

@implementation landingPageViewController

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
	[[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(showCharacterCreator)
                                                name:kShowCharacterCreator
                                              object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showCharacterCreator{
    [self performSegueWithIdentifier:@"toCharacterSheet" sender:self];
}

@end
