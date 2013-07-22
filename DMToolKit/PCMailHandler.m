//
//  PCMailHandler.m
//  WoundClosure


#import "PCMailHandler.h"

#import "NSString+HTML.h"


@interface PCMailHandler ()
@property (assign, nonatomic) MFMailComposeResult result;
@end



@implementation PCMailHandler

@synthesize delegate = m_delegate;
@synthesize result = m_result;

//------------------------------------------------------------------------------
- (void)composeEmailForSession{
    	
    if (![MFMailComposeViewController canSendMail]) {
        NSString *cannotSendMessage = @"This device needs to be set up to send email. Please enter your email account information in Settings, under 'Mail, Contacts, Calendars'.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:cannotSendMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *opening = NSLocalizedString(@"<p>Here is an update of the great adventure we had this evening.</p>\n", @"email header");
    
    NSString *closing = NSLocalizedString(@"<p class='disclaimer'>Sent via DMKeeper", @"email disclaimer");
    
    NSString *messageBody = [NSString stringWithFormat:@"%@%@", opening, closing];
    
	MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    vc.mailComposeDelegate = self;
    [vc setSubject:NSLocalizedString(@"Session recap", @"email subject")];
    [vc setMessageBody:messageBody isHTML:YES];
    
    [self.delegate presentModalMailComposeViewController:vc forMailHandler:self];

}

//------------------------------------------------------------------------------
-(void)composeEmailWithNote:(Notes*)note{
    if (![MFMailComposeViewController canSendMail]) {
        NSString *cannotSendMessage = @"This device needs to be set up to send email. Please enter your email account information in Settings, under 'Mail, Contacts, Calendars'.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:cannotSendMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }

    NSString *opening = NSLocalizedString(@"<p>Here is a message from your dungeon Master.</p>\n", @"email header");
    
  
    NSString *closing = NSLocalizedString(@"<p class='disclaimer'>Sent via DMKeeper", @"email disclaimer");
    
    NSString *messageBody = [NSString stringWithFormat:@"%@%@%@", opening,  note.text, closing];
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    vc.mailComposeDelegate = self;
    [vc setSubject:NSLocalizedString(@"A note from your DM ", @"email subject")];
    [vc setMessageBody:messageBody isHTML:YES];
    
    [self.delegate presentModalMailComposeViewController:vc forMailHandler:self];

}

-(void)mailComposeController:(MFMailComposeViewController *)controller 
		 didFinishWithResult:(MFMailComposeResult)result 
					   error:(NSError *)error {
	   
     
    NSString *alertMessage = nil;
    
    switch (result) {
            
        case MFMailComposeResultSent:
            alertMessage = NSLocalizedString(@"Your email was sent.", 
                                             @"Your email was sent. -- alert message for new email result: sent");
            break;
            
        case MFMailComposeResultCancelled:
            alertMessage = NSLocalizedString(@"Email cancelled; the message was not sent.", 
                                             @"Email cancelled; the message was not sent. -- alert message for new email result: cancelled");
            break;
            
        case MFMailComposeResultSaved:
            alertMessage = NSLocalizedString(@"Your email was saved as a draft. Please use your Mail app to update and send the message.", 
                                             @"Your email was saved as a draft. Please use your Mail app to update and send the message. -- alert message for new email result: saved");
            break;
            
        case MFMailComposeResultFailed:
            if (error) {
                NSString *alertPrefix = NSLocalizedString(@"Your email failed to send with an error code", 
                                                          @"Your email failed to send with an error code -- alert message prefix for new email result: failed");
                alertMessage = [NSString stringWithFormat:@"%@ %d (%@).", alertPrefix, error.code, error.description];
            }
            else {
                alertMessage = NSLocalizedString(@"Your email failed to send.", 
                                                 @"Your email failed to send. -- alert message for new email result: failed");
            }
            break;
            
        default:
            break;
    }
    
    if (alertMessage) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:alertMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    self.result = result;
    [self.delegate dismissModalMailComposeViewController:controller forMailHandler:self];
}

//------------------------------------------------------------------------------
- (MFMailComposeResult)mailComposeResult {
    
    return self.result;
}

@end
