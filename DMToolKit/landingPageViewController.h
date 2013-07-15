//
//  landingPageViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "masterBaseViewController.h"
#import "CampaingButtonViewController.h"
#import "PCButtonStack.h"
@interface landingPageViewController : masterBaseViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet PCButtonStack *topStack;
@property (strong, nonatomic) IBOutlet PCButtonStack *bottomStack;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (nonatomic, strong)NSMutableArray * buttons;
@end
