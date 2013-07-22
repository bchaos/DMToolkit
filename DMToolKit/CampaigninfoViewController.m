//
//  CampaigninfoViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 5/8/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CampaigninfoViewController.h"
#import <MBProgressHUD.h>
@interface CampaigninfoViewController (){
    Campaign * currentCampaign;
}

@end

@implementation CampaigninfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.trackedViewName = @"Campaign Info Viewed";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Loading";
    currentCampaign= [dungeonMasterSingleton sharedInstance].currentCampaign;
    if (currentCampaign) {
            [self reloadData];
        }
    [JE_ notifyObserver:self selector:@selector(updateName) name:@"updateHeader"];
    
}
-(void)updateName{
    NSString * string =[NSString stringWithFormat:@"document.getElementById('sampleTitle').innerHTML='%@'",currentCampaign.name] ;
    [_campaignWebview stringByEvaluatingJavaScriptFromString:string ];
}
-(void)reloadData{
    NSString * name=currentCampaign.name;
    NSString * fullText= currentCampaign.briefDescription;
    if(fullText ==nil || [fullText isEqualToString: @""]){
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"basicText" ofType:@"html"];
        fullText = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    }
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"campaign" ofType:@"html"];
    NSString * string = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    if(name){
        string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:name];
    }else{
        string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:@"Unnamed"];
    }
        string= [string stringByReplacingOccurrencesOfString:@"{{NoteText}}" withString:fullText];
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
      currentCampaign.briefDescription=host;
        [[dungeonMasterSingleton sharedInstance]save];
        return YES;
    }
    return NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    if(currentCampaign){
        [currentCampaign setValue:[_campaignWebview stringByEvaluatingJavaScriptFromString:@"document.getElementById('Content').innerHTML" ] forKey:@"briefDescription"];
    }
    [[dungeonMasterSingleton sharedInstance]save];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
