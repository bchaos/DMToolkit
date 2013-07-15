//
//  webViewPopoverViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol webPopoverDelegate <NSObject>
-(void)done;
@end

@interface webViewPopoverViewController : UIViewController<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property (nonatomic, strong)NSString * content;
- (IBAction)done:(id)sender;
- (IBAction)view:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *viewbutton;
@property (nonatomic, strong) NSString * openFileNamed;
@property (nonatomic, strong)NSString * type;
@property (nonatomic, assign) id <webPopoverDelegate> delegate;
@end
