//
//  EncounterViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//
#import "masterBaseViewController.h"
#import <UIKit/UIKit.h>

@interface EncounterViewController : masterBaseViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *campaignWebview;

@end