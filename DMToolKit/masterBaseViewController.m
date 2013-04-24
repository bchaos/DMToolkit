//
//  masterBaseViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "masterBaseViewController.h"

@interface masterBaseViewController ()

@end

@implementation masterBaseViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation ==UIInterfaceOrientationLandscapeRight){
        _backgroundImage.image= [UIImage imageNamed:@"backgroundBlank.png"];
        _backgroundImage.frame=CGRectMake(0, 0, 703, 700);
        _tabbarImage.image= [UIImage imageNamed:@"tabbar.png"];
       
    }
    else{
        _tabbarImage.image= [UIImage imageNamed:@"tabbarPortrait.png"]; 
        _backgroundImage.image= [UIImage imageNamed:@"backgroundTopPort.png"];
        _backgroundImage.frame=CGRectMake(0, 0, 768, 972);


    }
}

@end
