//
//  campaignNoteTakerViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/17/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "campaignNoteTakerViewController.h"

@interface campaignNoteTakerViewController ()

@end

@implementation campaignNoteTakerViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
          [_delegate done];
}
@end
