//
//  campaignNoteTakerViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/17/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteTakingViewController.h"
@protocol campaignNoteTakerDelegate <NSObject>
-(void)done;
@end

@interface campaignNoteTakerViewController : NoteTakingViewController<UIWebViewDelegate>
- (IBAction)done:(id)sender;
@property (nonatomic,strong)Notes *myNote;
@property (nonatomic, assign) id <campaignNoteTakerDelegate> delegate;
@end
