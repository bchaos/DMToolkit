//
//  NoteTakingViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/6/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "NoteTakingViewController.h"
#import "DuegonMasterSingleton.h"
@interface NoteTakingViewController (){
    CGPoint lastPoint;
    //	UIImageView *drawImage;
	BOOL mouseSwiped;
	int mouseMoved;
    BOOL Notemode;
    UIColor* colourtouse;
    UIButton * currentSelection;
    float linewidth;
}

@end

@implementation NoteTakingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      //  //self.trackedViewName = @"Note Taker Viewed";
    }
    return self;
}

-(void)addButtonGlow: (UIButton *)button{
    
    if (currentSelection){
        currentSelection.layer.shadowColor = [[UIColor clearColor]CGColor];
        currentSelection.layer.shadowRadius = 0;
        currentSelection.layer.shadowOpacity =0;
        currentSelection.layer.shadowOffset = CGSizeZero;
        currentSelection.layer.masksToBounds = YES;
    }
    
    currentSelection=button;
    UIColor *color = [UIColor blueColor];
    button.layer.shadowColor = [color CGColor];
    button.layer.shadowRadius = 5.0f;
    button.layer.shadowOpacity = .8;
    button.layer.shadowOffset = CGSizeZero;
    button.layer.masksToBounds = NO;
}

-(void)setupColourButtons{
    [_blackbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _blackbutton.backgroundColor = [UIColor blackColor];
    _blackbutton.layer.borderColor = [UIColor blackColor].CGColor;
    _blackbutton.layer.borderWidth = 0.5f;
    _blackbutton.layer.cornerRadius = 10.0f;
    
    [_bluebutton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _bluebutton.backgroundColor = [UIColor blueColor];
    _bluebutton.layer.borderColor = [UIColor blueColor].CGColor;
    _bluebutton.layer.borderWidth = 0.5f;
    _bluebutton.layer.cornerRadius = 10.0f;
    
    [_redbutton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _redbutton.backgroundColor = [UIColor redColor];
    _redbutton.layer.borderColor = [UIColor redColor].CGColor;
    _redbutton.layer.borderWidth = 0.5f;
    _redbutton.layer.cornerRadius = 10.0f;
    
    [_greenbutton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    _greenbutton.backgroundColor = [UIColor greenColor];
    _greenbutton.layer.borderColor = [UIColor greenColor].CGColor;
    _greenbutton.layer.borderWidth = 0.5f;
    _greenbutton.layer.cornerRadius = 10.0f;
    
    [_orangebutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _orangebutton.backgroundColor = [UIColor orangeColor];
    _orangebutton.layer.borderColor = [UIColor orangeColor].CGColor;
    _orangebutton.layer.borderWidth = 0.5f;
    _orangebutton.layer.cornerRadius = 10.0f;
    
    [_purple setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    _purple.backgroundColor = [UIColor purpleColor];
    _purple.layer.borderColor = [UIColor purpleColor].CGColor;
    _purple.layer.borderWidth = 0.5f;
    _purple.layer.cornerRadius = 10.0f;
    
    
    _blackbutton.hidden=YES;
    _bluebutton.hidden=YES;
    _greenbutton.hidden=YES;
    _purple.hidden=YES;
    _orangebutton.hidden=YES;
    _redbutton.hidden=YES;
    _clearbutton.hidden=YES;
    _clearbutton.backgroundColor= [UIColor clearColor];
    [self addButtonGlow:_blackbutton];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupColourButtons];
    Notemode=NO;
    _myNote= [[DuegonMasterSingleton sharedInstance]currentNote];
    
    if(_myNote){
        [self reloadData];
        NSURL *myid=[_myNote.objectID URIRepresentation];
           NSString *string =[myid.host stringByAppendingString:myid.pathComponents.lastObject];
         NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.png",string]];
        if([[NSFileManager defaultManager]fileExistsAtPath:pngPath]){
           self.signatureImageView.image = [UIImage imageWithContentsOfFile:pngPath];
        }
    }
    else _addLabel.hidden=NO;
    
    
    [JE_ notifyObserver:self selector:@selector(updateName) name:@"updateHeader"];
    
}
-(void)updateName{
    [_noteView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.getElementById('sampleTitle').innerHTML=%@",_myNote.name]  ];
}

-(void)reloadData{
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"editor" ofType:@"html"];
    NSString * string = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    string= [string stringByReplacingOccurrencesOfString:@"{{NoteName}}" withString:_myNote.name];
    
    string= [self replaceDate:string];
    if(_myNote.text){
        string= [string stringByReplacingOccurrencesOfString:@"{{NoteText}}" withString:_myNote.text];
    }else{
         string= [string stringByReplacingOccurrencesOfString:@"{{NoteText}}" withString:@"Enter your note here"];
    }
    _noteView.delegate=self;
  
    [_noteView loadHTMLString:string baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];

}

-(NSString *)replaceDate :(NSString*)webText{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat: @"MM-dd-yyyy HH:mm:ss"];
    NSString *stringFromDate = [dateFormat stringFromDate:_myNote.date];
    webText= [webText stringByReplacingOccurrencesOfString:@"{{NoteDate}}" withString:stringFromDate];
    return webText;
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
        _myNote.text=host;
        [[DuegonMasterSingleton sharedInstance]save];
        return YES;
    }
    return NO;
}
-(void)viewWillDisappear:(BOOL)animated{
    if(_myNote){
        _myNote.text= [_noteView stringByEvaluatingJavaScriptFromString:@"document.getElementById('Content').innerHTML"];
        _myNote.name= [_noteView stringByEvaluatingJavaScriptFromString:@"document.getElementById('Title').innerHTML"];
    }if([_myNote.group isEqualToString:@"Evernote"]){
        [[DuegonMasterSingleton sharedInstance]saveEvernote:_myNote];
    }
    
    [[DuegonMasterSingleton sharedInstance]save];
    NSURL *myid=[_myNote.objectID URIRepresentation];
    NSString *string =[myid.host stringByAppendingString:myid.pathComponents.lastObject];
    NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.png",string]];
    [UIImagePNGRepresentation( self.signatureImageView.image  ) writeToFile:pngPath atomically:YES];
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleNoteTakingMode:(UIButton *)sender {
    Notemode = !Notemode;
    sender.selected=!sender.selected;
    self.signatureImageView.userInteractionEnabled=Notemode;
    self.noteView.userInteractionEnabled=!Notemode;
    _blackbutton.hidden=!Notemode;
    _bluebutton.hidden=!Notemode;
    _greenbutton.hidden=!Notemode;
    _purple.hidden=!Notemode;
    _orangebutton.hidden=!Notemode;
    _redbutton.hidden=!Notemode;
    _clearbutton.hidden=!Notemode;
}


//------------------------------------------------------------------------------
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (Notemode){
        mouseSwiped = NO;
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint =[touch locationInView:self.signatureImageView];
        CGRect sigRect= self.signatureImageView.frame;
        if(CGRectContainsPoint(sigRect, currentPoint) && [touch tapCount] == 2){
          
        }
        lastPoint = [touch locationInView:self.signatureImageView];
        lastPoint.y -= 10;
    }
}

//------------------------------------------------------------------------------
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (Notemode){
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.signatureImageView];
	currentPoint.y -= 20;
	
	
    CGRect mainFrame = self.signatureImageView.frame;
	UIGraphicsBeginImageContext(mainFrame.size);
	[self.signatureImageView.image drawInRect:CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), linewidth);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [colourtouse CGColor]);
    if (currentSelection==_clearbutton){
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
        }
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	self.signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
    
	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
    }
    
}

//------------------------------------------------------------------------------
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (Notemode){
	UITouch *touch = [touches anyObject];
	
	CGPoint currentPoint =[touch locationInView:self.view];
    CGRect sigRect= self.signatureImageView.frame;
    if(CGRectContainsPoint(sigRect, currentPoint) && [touch tapCount] == 2){
		
		return;
	}
	
	
	if(!mouseSwiped) {
        CGRect mainFrame = self.signatureImageView.frame;
		UIGraphicsBeginImageContext(mainFrame.size);
        [self.signatureImageView.image drawInRect:CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), linewidth);
		CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [colourtouse CGColor]);
        if (currentSelection==_clearbutton){
            CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
        }
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		CGContextFlush(UIGraphicsGetCurrentContext());
		self.signatureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
    }
}



- (IBAction)sendnote:(id)sender {
    [_noteView resignFirstResponder];
    if(_myNote){
        _myNote.text= [_noteView stringByEvaluatingJavaScriptFromString:@"document.getElementById('Content').innerHTML"];
        _myNote.name= [_noteView stringByEvaluatingJavaScriptFromString:@"document.getElementById('Title').innerHTML"];
    }

    
    [[DuegonMasterSingleton sharedInstance]save];
    _mail=[[PCMailHandler alloc]init];
    _mail.delegate=self;
    [_mail composeEmailWithNote:_myNote];
    
    
}

-(void)presentModalMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController forMailHandler:(PCMailHandler *)mailHandler{
    
    [self presentViewController:mailComposeViewController animated:YES
                     completion:nil];
}

-(void)dismissModalMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController forMailHandler:(PCMailHandler *)mailHandler{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)changeColourToUse:(UIButton*)sender {
    [self addButtonGlow:sender];
    colourtouse= sender.backgroundColor;
    if(sender == _clearbutton)
        linewidth=10.0f;
    else
        linewidth=2.5f;
}
@end
