//
//  ToolSelectorViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 7/22/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "ToolSelectorViewController.h"
#import "PCButtonStack.h"

@interface ToolSelectorViewController ()
@property (strong, nonatomic) IBOutlet UIView *actionsItemView;
@property (strong, nonatomic) IBOutlet UIScrollView *tileSelectionScroll;
@property (strong, nonatomic)  PCButtonStack *firstStack;
@property (strong, nonatomic)  PCButtonStack *secondStack;


@end
#define TOTALBUTTONS 24
#define WIDTH 32
#define HEIGHT 32
#define PADDING 0
#define NUMBEROFBUTTONSINAROW 7
#define X 0
#define Y 0

@implementation ToolSelectorViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self.delegate done];
}

-(void)setupButtons{
    _firstStack = [[PCButtonStack alloc]initWithFrame:CGRectMake(14, 55, 306, 50)];

    _firstStack.isHorizontal=YES;
    _secondStack.isHorizontal=YES;
    [self.view addSubview:_firstStack];
    [self.view addSubview:_secondStack];
    [self setUpActionButtons];
    [self setupTileScroll];

}
-(void)setUpActionButtons{
     [self createBaseButton:[UIImage imageNamed:@"145-persondot.png"]   withMode:2 firstStack:YES];
     [self createBaseButton:[UIImage imageNamed:@"sword.png"]   withMode:3 firstStack:YES];
     [self createBaseButton:[UIImage imageNamed:@"53-house.png"]   withMode:4 firstStack:YES];
     [self createBaseButton:[UIImage imageNamed:@"chest.png"]   withMode:5 firstStack:YES];
     [self createBaseButton:[UIImage imageNamed:@"179-notepad.png"]   withMode:6 firstStack:YES];
     [self createBaseButton:[UIImage imageNamed:@"22-skull-n-bones.png"]   withMode:7 firstStack:YES];

}

-(void)createBaseButton:(UIImage*)image withMode:(int)tag firstStack:(BOOL)stack{
    UIButton * baseButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    baseButton.backgroundColor= [UIColor whiteColor];
    baseButton.layer.borderWidth=1.0;
    [baseButton addTarget:self action:@selector(setMode:) forControlEvents:UIControlEventTouchUpInside];
    baseButton.tag=tag;
    [baseButton setImage:image forState:UIControlStateNormal];
    if(stack)
        [_firstStack addButton:baseButton];
    else
        [_secondStack addButton:baseButton];

}


-(void)setupTileScroll{
    [self.tileList eachWithIndex:^(NSArray * array, int i) {
         NSDictionary * Dic= [array objectAtIndex:0];
        buttonWithFrameData *clickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [clickButton setBackgroundImage:[Dic objectForKey:@"image"]
                               forState:UIControlStateNormal];
        
        [clickButton setFrame:CGRectMake(X+((WIDTH*1.3 + PADDING) * (i%NUMBEROFBUTTONSINAROW)), Y + (HEIGHT*1.3 + PADDING)*(i/NUMBEROFBUTTONSINAROW), WIDTH*1.3, HEIGHT*1.3)];
        [clickButton addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        clickButton.tag=i;
        clickButton.layer.borderWidth=1.0f;
        clickButton.layer.borderColor= [[fontsAndColourConstants EthiconCoolGray8]CGColor];
        [self.tileSelectionScroll addSubview:clickButton];

    }];
    self.tileSelectionScroll.contentSize=CGSizeMake(WIDTH*1.3*NUMBEROFBUTTONSINAROW+60, HEIGHT*1.3*(TOTALBUTTONS/NUMBEROFBUTTONSINAROW)+60);
}
@end
