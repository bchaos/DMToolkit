//
//  webViewPopoverViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "webViewPopoverViewController.h"

@interface webViewPopoverViewController ()

@end

@implementation webViewPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     //   //self.trackedViewName = @"Web viewer Viewed";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_webview loadHTMLString:_content baseURL:nil];
    _webview.delegate=self;
    
}
-(void)viewDidAppear:(BOOL)animated{
    _viewbutton.enabled=(_type!=nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSURL *url = [request URL];
    return ![self handleLink:url];

}

-(Boolean)handleLink:(NSURL*)url{
    NSString * protocol = url.scheme;
    protocol=[protocol lowercaseString];
    protocol= [protocol lowercaseString];
    NSString * host= url.host;
    if([protocol hasSuffix:@"engage"]){
        [_delegate done];
        [dungeonMasterSingleton sharedInstance].currentEncounter=[[dungeonMasterSingleton sharedInstance]findEncounterNamed:host];
        [dungeonMasterSingleton sharedInstance].currentMap=[dungeonMasterSingleton sharedInstance].currentEncounter.map;
        [JE_ notifyName:@"toEncounterViewer" object:nil];
    return YES;
    }else if([protocol hasSuffix:@"fullpc"]){
           [_delegate done];
         [dungeonMasterSingleton sharedInstance].currentCharacter=[[dungeonMasterSingleton sharedInstance]findPlayerCharacterNamed:host];
        [JE_ notifyName:kShowCharacterCreator object:nil];
            return YES;
    }
    else if([protocol hasSuffix:@"fullnpc"]){
           [_delegate done];
        [dungeonMasterSingleton sharedInstance].currentCharacter=[[dungeonMasterSingleton sharedInstance]findNPCNamed:host];
        [JE_ notifyName:kShowCharacterCreatorNPC object:nil];
            return YES;
    }
    return NO;
}

- (IBAction)done:(id)sender {
    [_delegate done];
}

- (IBAction)view:(id)sender {
        [_delegate done];
    if ([_type isEqualToString:@"enage"] ){
        [dungeonMasterSingleton sharedInstance].currentEncounter=[[dungeonMasterSingleton sharedInstance]findEncounterNamed:_openFileNamed];
        [dungeonMasterSingleton sharedInstance].currentMap=[dungeonMasterSingleton sharedInstance].currentEncounter.map;
        [JE_ notifyName:@"toEncounterViewer" object:nil];
    }else if([_type isEqualToString:@"FullPC"]){
        [_delegate done];
        [dungeonMasterSingleton sharedInstance].currentCharacter=[[dungeonMasterSingleton sharedInstance]findPlayerCharacterNamed:_openFileNamed];
        [JE_ notifyName:kShowCharacterCreator object:nil];
    }else{
        [_delegate done];
        [dungeonMasterSingleton sharedInstance].currentCharacter=[[dungeonMasterSingleton sharedInstance]findNPCNamed:_openFileNamed];
        [JE_ notifyName:kShowCharacterCreatorNPC object:nil];
    }
    
}
@end
