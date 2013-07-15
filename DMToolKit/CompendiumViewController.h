//
//  CompendiumViewController.h
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 5/1/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "masterBaseViewController.h"

@interface CompendiumViewController : masterBaseViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
