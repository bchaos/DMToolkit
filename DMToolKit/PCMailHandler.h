//
//  PCMailHandler.h
//  WoundClosure
//
//  Created by Joshua Kaden on 4/2/12.
//  Copyright (c) 2012 Propeller Communications, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageUI/MFMailComposeViewController.h"

@class MFMailComposeViewController;
@class PCMailHandler,Notes;

@protocol PCMailHandlerDelegate <NSObject>

- (void)presentModalMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController forMailHandler:(PCMailHandler *)mailHandler;
- (void)dismissModalMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController forMailHandler:(PCMailHandler *)mailHandler;

@end


@interface PCMailHandler : NSObject <MFMailComposeViewControllerDelegate>

@property (assign, nonatomic) id <PCMailHandlerDelegate> delegate;
@property (readonly) MFMailComposeResult mailComposeResult;

- (void)composeEmailForSession;
- (void)composeEmailWithNote:(Notes*)note;


@end
