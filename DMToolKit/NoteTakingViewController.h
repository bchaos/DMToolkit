//
//  NoteTakingViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/6/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "masterBaseViewController.h"
#import "PCMailHandler.h"
#import <EvernoteSDK.h>
#import "EvernoteSession.h"
#import "EvernoteUserStore.h"
#import <ENMLUtility.h>
@interface NoteTakingViewController : masterBaseViewController<UIWebViewDelegate,PCMailHandlerDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *noteView;

- (IBAction)toggleNoteTakingMode:(UIButton *)sender;
@property (nonatomic, strong)Notes * myNote;
@property (strong, nonatomic) IBOutlet UIImageView *signatureImageView;

- (IBAction)sendnote:(id)sender;



- (IBAction)changeColourToUse:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *blackbutton;
@property (strong, nonatomic) IBOutlet UIButton *bluebutton;
@property (strong, nonatomic) IBOutlet UIButton *redbutton;
@property (strong, nonatomic) IBOutlet UIButton *greenbutton;
@property (strong, nonatomic) IBOutlet UIButton *orangebutton;
@property (strong, nonatomic) IBOutlet UIButton *purple;
@property (strong, nonatomic) IBOutlet UIButton *clearbutton;
@property (strong, nonatomic) IBOutlet UILabel *addLabel;
@property (strong,  nonatomic) PCMailHandler *mail;
@end
