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
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(goBack)
                                                name:@"goBack"
                                              object:nil];

}
-(void)viewDidAppear:(BOOL)animated{

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
