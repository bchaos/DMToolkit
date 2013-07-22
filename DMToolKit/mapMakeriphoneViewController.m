//
//  mapMakeriphoneViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 7/21/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "mapMakeriphoneViewController.h"
#import <MBProgressHUD.h>
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define WIDTH 32
#define HEIGHT 32
#define PADDING 0
#define NUMBEROFBUTTONSINAROW (IS_IPAD ? 15 : 8)
#define X 0
#define Y 0


#define TOTALBUTTONS (IS_IPAD ? 225 : 64)
#define TileMapSizeWidth 512
#define TileMapSizeHeight 384
#define tilesInARow 16
#define tilesGroupWidth 2
#define TilesGroupHeight 3
#define TotalTiles 192
@interface mapMakeriphoneViewController(){
    ToolSelectorViewController * tool;
}

@end

@implementation mapMakeriphoneViewController

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
    if(!self.hasbackbutton) self.backbutton.image=nil;
 
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIStoryboard * mainStoryBoard = [UIStoryboard storyboardWithName:@"MainStoryboard@iphone" bundle:nil];
    tool= [mainStoryBoard instantiateViewControllerWithIdentifier:@"tools"];
    tool.delegate=self;
    tool.tileList= self.toolsDic;
    [tool setupButtons];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clearTints{
    _openMapEditingMenu.tintColor=[UIColor clearColor];
    _openPlaceAnObjectMenu.tintColor=[UIColor clearColor];
}

- (IBAction)placeAnObject:(UIBarButtonItem*)sender {
    [self clearTints];
    sender.tintColor= [UIColor blueColor];
}
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toggleEditMode:(id)sender {
}

-(void)setupTools{
    [self createToolsDictionary];
}

-(void)createSidebar{
    
}

-(void)setupPreviousButton{
    if(self.previousMap.count >0){
        self.PreviousMapButton.hidden=NO;
    }else{
         self.PreviousMapButton.hidden=YES;
    }
}
- (IBAction)email:(id)sender {
    [[dungeonMasterSingleton sharedInstance]save];
    self.mail=[[PCMailHandler alloc]init];
    self.mail.delegate=self;
    [self.mail composeEmailForSession];
}

- (IBAction)mapmaking:(UIBarButtonItem * )sender {
    [self clearTints];
    sender.tintColor=[UIColor blueColor];
    [self presentViewController:tool animated:YES completion:nil];
    
}

-(void)done{
    [self dismissViewControllerAnimated:YES completion:nil];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

- (IBAction)openMapDetails:(id)sender {
    mapDescriptionViewController * map= [self createMapWithGridInfo:self.Dic.last andFileName:self.currentMap.gridInfomation];
    map.hasViewButton=NO;
    map.delegate=self;
    [self presentViewController:map animated:YES completion:nil];
}

-(void)createToolsDictionary{
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    __block int subGroup=0;
    __block int  group= 0;
    [@TotalTiles timesWithIndex:^(int i) {
        CGRect  frame= CGRectMake(((WIDTH ) * (i%tilesInARow)),  (HEIGHT )*(i/tilesInARow), WIDTH, HEIGHT);
        int arrayCount = tempArray.count-1;
        int currentArrayindex=group+tilesInARow/2*subGroup;
        if (currentArrayindex==-1){
            currentArrayindex =0;
        }
        
            NSMutableArray * newGroup= [[NSMutableArray alloc]init];
       
            [newGroup addObject:@{  @"image" : [self.map crop:frame],
             @"mode" : [NSNumber numberWithInt:0],
             @"frame" : NSStringFromCGRect(frame)}  ];
            [tempArray insertObject:newGroup atIndex:group];
   
     
        if ((i+1)%2==0)
            group++;
        if ( group >= tilesInARow/2){
            group=0;
        }
        if((i+1)%48 ==0){
            subGroup++;
        }
    }];
    
    self.toolsDic = [[NSArray alloc]initWithArray:tempArray];
}

@end
