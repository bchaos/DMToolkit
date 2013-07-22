//
//  EncounterViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/30/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "EncounterViewController.h"
#import <MBProgressHUD.h>
@interface EncounterViewController (){
    Encounter *currentEncounter;
}

@end

@implementation EncounterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  //self.trackedViewName = @"Encounter Viewer Viewed";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	currentEncounter = [dungeonMasterSingleton sharedInstance].currentEncounter;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    [self reloadData];
     [JE_ notifyObserver:self selector:@selector(updateName) name:@"updateHeader"];
   
}
-(void)updateName{
    NSString * string =[NSString stringWithFormat:@"document.getElementById('sampleTitle').innerHTML='%@'",currentEncounter.name] ;
    [_campaignWebview stringByEvaluatingJavaScriptFromString: string];
}
-(void)reloadData{
    NSString * name=currentEncounter.name;
    NSString * fullText= currentEncounter.about;
    if(fullText ==nil || [fullText isEqualToString: @""]){
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"basicEncounter" ofType:@"html"];
        fullText = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    }
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"campaign" ofType:@"html"];
    NSString * string = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    if(name){
        string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:name];
    }else{
        string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:@"Suprise Encounter"];
    }
    string= [string stringByReplacingOccurrencesOfString:@"{{NoteText}}" withString:fullText];
       string= [string stringByReplacingOccurrencesOfString:@"{{hasEngageButton}}" withString:@""];
    _campaignWebview.delegate=self;
    [_campaignWebview loadHTMLString:string baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSURL *url = [request URL];
    if([self handleLink:url]){
        return  NO;
    }
    
    return YES;
}


-(Boolean)handleLink:(NSURL*)url{
    NSString * protocol = url.scheme;
    NSString * host= url.host;
    if([protocol hasSuffix:@"save"]){
        currentEncounter.about=host;
        [[dungeonMasterSingleton sharedInstance]save];
        return YES;
    }
    return NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    if(currentEncounter){
        [currentEncounter setValue:[_campaignWebview stringByEvaluatingJavaScriptFromString:@"document.getElementById('Content').innerHTML" ] forKey:@"about"];
         //[currentEncounter setValue:[_campaignWebview stringByEvaluatingJavaScriptFromString:@"document.getElementById('sampleTitle').innerHTML" ] forKey:@"name"];
    }
    [[dungeonMasterSingleton sharedInstance]save];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
