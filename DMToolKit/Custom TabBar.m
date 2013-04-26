//
//  Custom TabBar.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "Custom TabBar.h"

@interface Custom_TabBar ()

@end

@implementation Custom_TabBar

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
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar.png"]];
    self.tabBar.selectedImageTintColor= [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(goBack)
                                                name:@"goBack"
                                              object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
