//
//  CampaingButtonViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 6/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampaingButtonViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *CampainTitle;
@property (nonatomic, strong) Campaign * campaign;

- (IBAction)goToCampaing:(id)sender;

@end
