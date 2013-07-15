//
//  CompendiumViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 5/1/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CompendiumViewController.h"
#import "DuegonMasterSingleton.h"
@interface CompendiumViewController (){
    NSManagedObject * mananaged;
}

@end

@implementation CompendiumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  //self.trackedViewName = @"Compendium Item Viewed";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mananaged= [DuegonMasterSingleton sharedInstance].currentObject;
    if(mananaged)
    [self reloadData];
   
}
-(void)reloadData{
     NSString * fullText= [mananaged valueForKey:@"fulltext"];
     NSString * name= [mananaged valueForKey:@"name"];
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"ItemViewer" ofType:@"html"];
    NSString * string = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    if(name){
        string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:name];
    }else{
         string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:@"Unknown"];
    }
    string= [string stringByReplacingOccurrencesOfString:@"{{NoteText}}" withString:fullText];
    _webView.delegate=self;
    NSLog(@"%@",[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]);
    [_webView loadHTMLString:string baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
   
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
        [mananaged setValue:host forKey:@"fulltext"];
        [[DuegonMasterSingleton sharedInstance]save];
        return YES;
    }
    return NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    if(mananaged){
   
        [mananaged setValue:[_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('Content').innerHTML" ] forKey:@"fulltext"];
    }
    [[DuegonMasterSingleton sharedInstance]save];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
