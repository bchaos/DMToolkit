//
//  CampaigninfoViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 5/8/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "masterBaseViewController.h"

@interface CampaigninfoViewController : masterBaseViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *campaignWebview;

@end
