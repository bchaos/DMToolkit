//
//  mapDescriptionViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/29/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "mapDescriptionViewController.h"

@interface mapDescriptionViewController ()

@end

@implementation mapDescriptionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
     [self reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    _gridInfo[@"mapName"] = [_noteView stringByEvaluatingJavaScriptFromString:@"document.getElementById('Title').innerHTML"];
  _gridInfo[@"mapDescription"] = [_noteView stringByEvaluatingJavaScriptFromString:@"document.getElementById('Content').innerHTML"];
    [_delegate newGrid:_gridInfo];

}

-(void)reloadData{
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"map" ofType:@"html"];
    NSString * string = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    if (_gridInfo[@"mapName"])
    string= [string stringByReplacingOccurrencesOfString:@"{{MapName}}" withString: _gridInfo[@"mapName"]];
    if ( _gridInfo[@"mapDescription"])
    string= [string stringByReplacingOccurrencesOfString:@"{{MapDescription}}" withString:_gridInfo[@"mapDescription"]];
    if(_hasViewButton){
        _viewButton.enabled=YES;
        string= [string stringByReplacingOccurrencesOfString:@"{{HowToDisplay}}" withString:@"inline-block"];
    }

    else{
        _viewButton.enabled=NO;
          string= [string stringByReplacingOccurrencesOfString:@"{{HowToDisplay}}" withString:@"none"];
    }
    
    _noteView.delegate=self;
    NSLog( @"%@",[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]);
    [_noteView loadHTMLString:string baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
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
        _gridInfo[@"mapName"]=host;
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [_delegate done];
}

- (IBAction)view:(id)sender {
    [_delegate go:_filename];

}



@end
