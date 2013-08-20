//
//  MapMakerViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/7/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "MapMakerViewController.h"
#import "fontsAndColourConstants.h"
#import <NSString+FontAwesome.h>
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
static NSString *  idKey=@"ID";
static NSString * buttonKey =@"button";
static NSString * NPCkey=@"NPC";
static NSString *  MapKey=@"Map";
static NSString * ItemKey =@"Item";
static NSString * NoteKey =@"Note";
static NSString * EncounterKey =@"Encounter";
static NSString *playerKey= @"Player";
static NSString * monsterKey =@"Monster";
typedef enum {
    kImageChange =0,
    kAddNote,
    kSetPlayerLocation,
    kAddNpcLocation,
    kAddEncounterLocation,
    kAddItem,
    kAddTreasure,
} modes;


@interface MapMakerViewController (){
    
    
    buttonWithFrameData * currentSelection;
    UIButton * currentlyEditing;
    BOOL buttonEdited;
    NSMutableDictionary * mapInfoDic;
    NSString *keyToEdit;
    
}

@end

@implementation MapMakerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //self.trackedViewName = @"Map Maker Viewed";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _groupSelectionTable.layer.borderWidth=2.0;
    _toolkit.delegate=self;
    _loaded=NO;
    _mode=-1;
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    _mapDataString= @"BasicMapText";
     }
     else{
         _mapDataString= @"BasicMapTextiphone";
     }
    

}

-(void)createDefaultDic{
    NSString * fileName= [NSString stringWithFormat:@"%@.txt",[JE_ GetUUID]];
    assert( [JE_ createFileinDocDirectory:fileName]);
     NSString * filePath=[NSString stringWithFormat:@"%@/%@", [JE_ docs], fileName ];
    _currentMap.gridInfomation=filePath;
   
    
    [self setupDictWithGridPath:filePath];
}

-(void)setupDictWithGridPath:(NSString *)filePath{
    
    _Dic= [[NSMutableArray alloc]init];
    for(int i=0 ; i<TOTALBUTTONS;i++)
    {
        NSArray * objects= @[NSStringFromCGRect(CGRectMake(0, 0, 40, 40)), @"", @"",@"",@"",@"",@"",@""];
        NSArray * keys= @[buttonKey,NPCkey,MapKey,ItemKey,NoteKey,EncounterKey , playerKey, monsterKey];
        
        NSMutableDictionary* newItem = [[ NSMutableDictionary  alloc]initWithObjects:objects
                                                                             forKeys:keys];
        [_Dic addObject:newItem];
    }
    
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:_mapDataString ofType:@"html"];
    NSString * basicMapDescriptionString = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    mapInfoDic = [[NSMutableDictionary alloc]initWithDictionary:@{
                  @"mapName":@"New Map" ,
                  @"mapDescription" : basicMapDescriptionString
                  }];
    [_Dic addObject:mapInfoDic];
    if([_Dic writeToFile:filePath atomically:YES]){
        NSLog(@"wroteTOpath");
    }else{
        NSLog(@"failed");
    }

}

-(void)setupDic{
    _currentMap=[dungeonMasterSingleton sharedInstance].currentMap;
    NSString * gridInfo= _currentMap.gridInfomation;
    if(gridInfo){
        _Dic =[NSMutableArray arrayWithContentsOfFile:gridInfo];
        if(!_Dic){
            [self setupDictWithGridPath:gridInfo];
        }
    }else{
        [self createDefaultDic];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [_spinner stopAnimating];
    hud=nil;
}

-(void)viewDidAppear:(BOOL)animated{
    if(!_loaded){
            [self setupDic];
            [self.TitleButton setTitle:_Dic.last[@"mapName"] forState:UIControlStateNormal];
            [self setupGrid];
            [self setupTools];
            [self createSideBar];
            [self setupPreviousButton];
            _loaded=YES;
            _canEdit=YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self openMapDetails:self];
    }
    else{
         [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
}

-(void)setupPreviousButton{
    if(self.previousMap.count >0){
        _PreviousMapButton.hidden=NO;
    }else{
        _PreviousMapButton.hidden=YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
     [_Dic writeToFile:_currentMap.gridInfomation atomically:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)cleargrid{
   [ self.scrollAbleMap.subviews each:^(id object){
        if([object isKindOfClass:[UIButton class]]){
            [((UIButton *)object) setImage:nil forState:UIControlStateNormal];
              [((UIButton *)object) setBackgroundImage:nil forState:UIControlStateNormal];
            [object removeFromSuperview];
            object=nil;
        }
   }];
}
-(void)setupGrid{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tilea2" ofType:@"png"];
    _map=[[tileMap alloc]initWithContentsOfFile:path];
    @autoreleasepool {
        
    
    [_Dic eachWithIndex:^(id object, int i) {
        if( object!=_Dic.last){
        
        UIImage * baseImage= [_map crop: CGRectFromString([object objectForKey:buttonKey])];
        UIButton *btnClick = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnClick setBackgroundImage:baseImage forState:UIControlStateNormal];
        
        if(![[object objectForKey:NPCkey] isEqual:@""]){
            [btnClick setImage:[UIImage imageNamed:@"145-persondot.png"] forState:UIControlStateNormal];
        }else if(![[object objectForKey:EncounterKey] isEqual:@""]){
            [btnClick setImage:[UIImage imageNamed:@"sword.png"] forState:UIControlStateNormal];
        }else if(![[object objectForKey:NoteKey]isEqual:@""]){
            [btnClick setImage:[UIImage imageNamed:@"179-notepad.png"] forState:UIControlStateNormal];
        }else if(![[object objectForKey:MapKey]isEqual:@""]){
            [btnClick setImage:[UIImage imageNamed:@"53-house.png"] forState:UIControlStateNormal];
        }else if(![[object objectForKey:ItemKey]isEqual:@""]){
            [btnClick setImage:[UIImage imageNamed:@"chest.png"] forState:UIControlStateNormal];
        }else if(![[object objectForKey:playerKey]isEqual:@""]){
            [btnClick setImage:[UIImage imageNamed:@"111-user.png"] forState:UIControlStateNormal];
        }else if(![[object objectForKey:monsterKey]isEqual:@""]){
            [btnClick setImage:[UIImage imageNamed:@"132-ghost.png"] forState:UIControlStateNormal];
        }
        [btnClick setFrame:CGRectMake(X+((WIDTH*1.3 + PADDING) * (i%NUMBEROFBUTTONSINAROW)), Y + (HEIGHT*1.3 + PADDING)*(i/NUMBEROFBUTTONSINAROW), WIDTH*1.3, HEIGHT*1.3)];
        [btnClick addTarget:self action:@selector(btnTapped:) forControlEvents:UIControlEventTouchUpInside];
        btnClick.tag=i;
        btnClick.layer.borderWidth=1.0f;
        btnClick.layer.borderColor= [[fontsAndColourConstants EthiconCoolGray8]CGColor];
        [self.scrollAbleMap addSubview:btnClick];
        }
    }];
    }
 
    self.scrollAbleMap.contentSize=CGSizeMake(WIDTH*1.3*NUMBEROFBUTTONSINAROW+60, HEIGHT*1.3*(TOTALBUTTONS/NUMBEROFBUTTONSINAROW)+60);
       [_spinner stopAnimating];
}

-(UIButton *)createBaseButton:(UIImage*)image withMode:(int)tag offset:(int)offset{
    UIButton * baseButton = [[UIButton alloc]initWithFrame:CGRectMake(3, offset, 50, 50)];
    baseButton.backgroundColor= [UIColor whiteColor];
    baseButton.layer.borderWidth=1.0;
    [baseButton addTarget:self action:@selector(setMode2:) forControlEvents:UIControlEventTouchUpInside];
    baseButton.tag=tag;
    [baseButton setImage:image forState:UIControlStateNormal];
    return baseButton;
}

- (IBAction)previousMapSelected:(id)sender {
    Map * prevMap =[self.previousMap  pop];
    [dungeonMasterSingleton sharedInstance].currentMap=prevMap;
    [self reloadMap:NO];
    
}

-(void)createSideBar{
    [_sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"145-persondot.png"]    withMode:2 offset:10]];
    [_sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"sword.png"]            withMode:3 offset:63]];
    [_sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"53-house.png"]         withMode:4 offset:116]];
    [_sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"chest.png"]            withMode:5 offset:169]];
    [_sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"179-notepad.png"]   withMode:6 offset:222]];
    [_sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"22-skull-n-bones.png"] withMode:7 offset:275]];
	[_sideMenu addSubview:[self createBaseButton:[UIImage imageNamed:@"18-envelope.png"] withMode:12 offset:328]];
}



-(void)createToolsDictionary{
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];
    __block int subGroup=0;
    __block int  group= 0;
    [@TotalTiles timesWithIndex:^(int i) {
        CGRect  frame= CGRectMake(((WIDTH ) * (i%tilesInARow)),  (HEIGHT )*(i/tilesInARow), WIDTH, HEIGHT);
        int arrayCount = tempArray.count-1;
        int currentArrayindex=group+tilesInARow/2*subGroup;
        if (arrayCount<currentArrayindex){
            NSMutableArray * newGroup= [[NSMutableArray alloc]init];
            [newGroup addObject:@{  @"image" : [_map crop:frame],
                                    @"mode" : [NSNumber numberWithInt:kImageChange],
                                    @"frame" : NSStringFromCGRect(frame)} ];
            [tempArray addObject:newGroup];
        }else{
            [[tempArray objectAtIndex:group+tilesInARow/2*subGroup]addObject:
             @{@"image" : [_map crop:frame],
               @"mode" :[NSNumber numberWithInt:kImageChange]}];
        }
        if ((i+1)%2==0)
            group++;
        if ( group >= tilesInARow/2){
            group=0;
        }
        if((i+1)%48 ==0){
            subGroup++;
        }
    }];
 
    _toolsDic = [[NSArray alloc]initWithArray:tempArray];
}


-(void)setupTools{
    int toolsize=50;
    [self createToolsDictionary];
    [_toolsDic eachWithIndex:^(NSArray * array, int i) {
        NSDictionary * my_Dic= [array objectAtIndex:0];
        buttonWithFrameData * greenButton = [buttonWithFrameData buttonWithType:UIButtonTypeCustom];
        greenButton.frame= CGRectMake(toolsize *i+2*i, 2, toolsize, toolsize);
        [greenButton addTarget:self action:@selector(showToolSubMenu:) forControlEvents:UIControlEventTouchUpInside];
        greenButton.tag=i;
        greenButton.frameValue=[my_Dic objectForKey:@"frame"];
        [greenButton setImage:[my_Dic objectForKey:@"image"] forState:UIControlStateNormal];
        greenButton.layer.borderWidth=1.0f;
        greenButton.backgroundColor=[UIColor whiteColor];
        [_toolkit addSubview:greenButton];

    }];
    
    _toolkit.contentSize=CGSizeMake(toolsize*_toolsDic.count + 2* _toolsDic.count, 59);
    CALayer *bottomBorder = [CALayer layer];
    
    bottomBorder.frame = CGRectMake(0.0f, 0.0f, _toolkit.frame.size.width, 1.0f);
    
    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    
    [_toolkit.layer addSublayer:bottomBorder];
    //_toolsDic=nil;
    _map=nil;
}
-(void)addButtonGlow:(buttonWithFrameData *)sender{
    if (currentSelection){
        currentSelection.imageView.layer.shadowColor = [[UIColor clearColor]CGColor];
        currentSelection.imageView.layer.shadowRadius = 0;
        currentSelection.imageView.layer.shadowOpacity =0;
        currentSelection.imageView.layer.shadowOffset = CGSizeZero;
        currentSelection.imageView.layer.masksToBounds = YES;
    }

    currentSelection=sender;
    UIColor *color = [UIColor blueColor];
    sender.imageView.layer.shadowColor = [color CGColor];
    sender.imageView.layer.shadowRadius = 5.0f;
    sender.imageView.layer.shadowOpacity = .9;
    sender.imageView.layer.shadowOffset = CGSizeZero;
    sender.imageView.layer.masksToBounds = NO;
}

-(void)showToolSubMenu:(buttonWithFrameData*)sender{
    [self addButtonGlow:sender];
     _groupSelectionTable.hidden=NO;
    
    [self updateSelectionTableRect];
    [_groupSelectionTable reloadData];
    _isToolBarTable=YES;
    
}
-(void)updateSelectionTableRect{
   
        CGRect rect = _groupSelectionTable.frame;
 
        rect.size= CGSizeMake(32, 200);
        rect.origin = CGPointMake(currentSelection.frame.origin.x+10-_toolkit.contentOffset.x
                              , _toolkit.frame.origin.y-_groupSelectionTable.frame.size.height+8);
        _groupSelectionTable.frame=rect;
}

-(void)setMode2:(buttonWithFrameData*)sender{
    [self setModeWithInt:sender.tag];
    [self addButtonGlow:sender];
}
-(void)setModeWithInt:(NSInteger)newmode{
    
    _mode=newmode;
}

-(void)addSelectionContorller:(NSArray* )initalList inButton:(UIButton *)button{
    
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    SelectionViewController * selection = [[SelectionViewController alloc]init];
    [selection setList:initalList];
    selection.delegate=self;
    _popover= [[UIPopoverController alloc]initWithContentViewController:selection];
    _popover.delegate=self;
    [_popover presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
     }
}
#pragma mark map Popover


-(void)showMapPopOverControllerForMap:(mapDescriptionViewController *)map{
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    _popover= [[UIPopoverController alloc]initWithContentViewController:map];
    _popover.delegate=self;
    [_popover setPopoverContentSize:CGSizeMake(500, 500)];
    [_popover presentPopoverFromRect:CGRectMake(300, 400, 25, 25) inView:self.view permittedArrowDirections:0 animated:YES];
     }

}
-(void)go:(NSString *)fileName{
    [_popover dismissPopoverAnimated:NO];
    
    [dungeonMasterSingleton sharedInstance].currentMap = [[dungeonMasterSingleton sharedInstance]findMapNamed:fileName];
    [NSTimer scheduledTimerWithTimeInterval:.06 target:self selector:@selector(reloadMap:) userInfo:nil repeats:NO];
   
}
-(mapDescriptionViewController *)createMapWithGridInfo:(NSMutableDictionary *)gridInfo andFileName:(NSString*)filename{
    mapDescriptionViewController *map= [[mapDescriptionViewController alloc]initWithNibName:@"mapDescriptionViewController" bundle:[NSBundle mainBundle]];
    map.delegate=self;
    map.filename= filename;
    map.gridInfo=gridInfo;
    return map;
}

-(void)showMapInfo: (Map *)mapToShow{
    NSMutableArray * temp_Dic =[NSMutableArray arrayWithContentsOfFile:mapToShow.gridInfomation];
    mapDescriptionViewController * map= [self createMapWithGridInfo:temp_Dic.last andFileName:mapToShow.gridInfomation];
    map.hasViewButton=YES;
    [self showMapPopOverControllerForMap:map];
}

#pragma mark item selection

-(void)ItemSelected:(NSManagedObject *)object{
    buttonEdited=YES;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [_popover dismissPopoverAnimated:YES];
    }
    [[_Dic objectAtIndex:currentlyEditing.tag] setObject:[object valueForKey:@"name"] forKey:keyToEdit];
     [_Dic writeToFile:_currentMap.gridInfomation atomically:YES];
}
-(void)reloadMap :(BOOL)foward{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    [self cleargrid];
    _map=nil;
    MapMakerViewController *newMap;
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    newMap= [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"mapMaker"];
     }else{
         newMap= [[UIStoryboard storyboardWithName:@"MainStoryboard@iphone" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"mapMaker"];
     }
    if(self.previousMap==nil){
        self.previousMap =[[NSMutableArray alloc]init]; 
    }
    newMap.previousMap= self.previousMap;
    if(foward){
        [newMap.previousMap push:_currentMap];
    }
        
        
  
    NSMutableArray *tabbarViewControllers = [self.tabBarController.viewControllers mutableCopy];
    
    [tabbarViewControllers replaceObjectAtIndex:1 withObject:newMap];
    
    self.tabBarController.viewControllers = tabbarViewControllers;

}
-(void)addZone:(UIButton *)button{
    if([self dicIsEmpty]){
        [button setImage:[UIImage imageNamed:@"53-house.png"] forState:UIControlStateNormal];
        Map *newMap = [[dungeonMasterSingleton sharedInstance]createMap];
        [_currentMap addSubMapsObject:newMap];
        [newMap addSubMapsObject:_currentMap];
        NSString * fileName= [NSString stringWithFormat:@"%@.txt",[JE_ GetUUID]];
        assert( [JE_ createFileinDocDirectory:fileName]);
        NSString * filePath=[NSString stringWithFormat:@"%@/%@", [JE_ docs], fileName ];
        newMap.gridInfomation=filePath;
        [dungeonMasterSingleton sharedInstance].currentMap=newMap;
        [[dungeonMasterSingleton sharedInstance]save];
        [[_Dic objectAtIndex:currentlyEditing.tag] setObject:newMap.gridInfomation forKey:keyToEdit];
        [_Dic writeToFile:_currentMap.gridInfomation atomically:YES];
        //_spinner.hidden=NO;
        [self reloadMap :YES];
    }
    else{
        [self showNeedToClearAlert];
    }
}

-(void)addNote:(UIButton *)button{
    if([self dicIsEmpty]){
        [button setImage:[UIImage imageNamed:@"179-notepad.png"] forState:UIControlStateNormal];
        Notes * newNote = [[dungeonMasterSingleton sharedInstance] createNotes];
        newNote.name= @"New Note";
        newNote.date= [NSDate date];
        [[_Dic objectAtIndex:currentlyEditing.tag] setObject:newNote.date forKey:keyToEdit];
        [[dungeonMasterSingleton sharedInstance]save];
        [dungeonMasterSingleton sharedInstance].currentNote=newNote;
        campaignNoteTakerViewController *taker= [[campaignNoteTakerViewController alloc]initWithNibName:@"campaignNoteTakerViewController"bundle:[NSBundle mainBundle]];
        taker.delegate=self;
       if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){ 
        _popover= [[UIPopoverController alloc]initWithContentViewController:taker];
        _popover.delegate=self;
        [_popover setPopoverContentSize:CGSizeMake(500, 500)];
        [_popover presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
       }else{
            [self presentViewController:taker animated:YES completion:nil];
       }
         [_Dic writeToFile:_currentMap.gridInfomation atomically:YES];
    }else{
        [self showNeedToClearAlert];
    }
}
-(void)newGrid:(NSDictionary *)newGrid{
    [_Dic setObject:newGrid atIndexedSubscript:_Dic.count-1];
    [self.TitleButton setTitle:_Dic.last[@"mapName"] forState:UIControlStateNormal];
}
-(void)done{
    [_popover dismissPopoverAnimated:YES];
}

-(void)resetButton:(UIButton *)button{
    if(![self dicIsEmpty]){
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Delete field" message:@"Are you sure you want to clear items at this location." delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert show];
    }
}

-(void)showNeedToClearAlert{
    [JE_ okWithTitle:@"Remove items" message:@"Please clear the items to add new ones."];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        [self clearDic];
    }
}

-(void)clearDic{
    [[_Dic objectAtIndex:currentlyEditing.tag] setObject:@"" forKey:MapKey];
    [[_Dic objectAtIndex:currentlyEditing.tag] setObject:@"" forKey:NPCkey];
    [[_Dic objectAtIndex:currentlyEditing.tag] setObject:@"" forKey:ItemKey];
    [[_Dic objectAtIndex:currentlyEditing.tag] setObject:@"" forKey:NoteKey];
        [[_Dic objectAtIndex:currentlyEditing.tag] setObject:@"" forKey:monsterKey];
        [[_Dic objectAtIndex:currentlyEditing.tag] setObject:@"" forKey:playerKey];
    [[_Dic objectAtIndex:currentlyEditing.tag] setObject:@"" forKey:EncounterKey];
    [currentlyEditing setImage:nil forState:UIControlStateNormal];
}

-(BOOL)dicIsEmpty{
    NSMutableDictionary * currentIndex= [_Dic objectAtIndex:currentlyEditing.tag];
    if(![[currentIndex objectForKey:NPCkey] isEqual:@""]){
      return NO;
    }else if(![[currentIndex objectForKey:EncounterKey] isEqual:@""]){
     return NO;
    }else if(![[currentIndex objectForKey:NoteKey]isEqual:@""]){
      return NO;
    }else if(![[currentIndex objectForKey:MapKey]isEqual:@""]){
      return NO;
    }else if(![[currentIndex objectForKey:ItemKey]isEqual:@""]){
       return NO;
    }else if(![[currentIndex objectForKey:monsterKey]isEqual:@""]){
        return NO;
    }
    else if(![[currentIndex objectForKey:playerKey]isEqual:@""]){
        return NO;
    }
    return YES;
}

-(void)setCurrentSelection:(buttonWithFrameData*)selection{
    currentSelection=selection;
}
-(void)clearCurrentlyEditing{
    [currentlyEditing setImage:nil forState:UIControlStateNormal];
}
-(void)btnTapped:(UIButton *)sender
{
    currentlyEditing=sender;
    buttonEdited=NO;
    if(_canEdit){
        _groupSelectionTable.hidden=YES;
        switch (_mode) {
            case 0:
                [sender setBackgroundImage:[currentSelection imageForState:UIControlStateNormal] forState:UIControlStateNormal];
                [[_Dic objectAtIndex:currentlyEditing.tag] setObject:currentSelection.frameValue forKey:buttonKey];
                 [_Dic writeToFile:_currentMap.gridInfomation atomically:YES];
            break;
            case 2:
                [self addSelectionContorller:[[dungeonMasterSingleton sharedInstance] AllNPC:nil] inButton:sender];
                [sender setImage:[UIImage imageNamed:@"145-persondot.png"] forState:UIControlStateNormal];
                keyToEdit= NPCkey;
            break;
            case 3:
                [self addSelectionContorller:[[dungeonMasterSingleton sharedInstance] AllEncounter:nil] inButton:sender];
                  [sender setImage:[UIImage imageNamed:@"sword.png"] forState:UIControlStateNormal];
                keyToEdit= EncounterKey;
                break;
            case 4:
                keyToEdit=MapKey;
                [self addZone: sender];
            
                break;
            case 5:
                [self addSelectionContorller:[[dungeonMasterSingleton sharedInstance] AllItems:nil] inButton:sender];
                [sender setImage:[UIImage imageNamed:@"chest.png"] forState:UIControlStateNormal];
                keyToEdit=ItemKey;
                break;
            case 6:
                keyToEdit=NoteKey;
                [self addNote: sender];
                break;
            case 8:
                [self addSelectionContorller:[[dungeonMasterSingleton sharedInstance] AllPlayerCharacters:nil] inButton:sender];
                [sender setImage:[UIImage imageNamed:@"111-user.png"] forState:UIControlStateNormal];
                keyToEdit= playerKey;
                break;
            case 9:
                [self addSelectionContorller:[[dungeonMasterSingleton sharedInstance] AllNPC:nil]  inButton:sender];
                [sender setImage:[UIImage imageNamed:@"132-ghost.png"] forState:UIControlStateNormal];
                keyToEdit= monsterKey;
                break;
            case 7:
                [self resetButton: sender];
                break;
			case 12:
                	 [[dungeonMasterSingleton sharedInstance]save];
					_mail=[[PCMailHandler alloc]init];
					_mail.delegate=self;
					[_mail composeEmailForSession];
                break;
            default:
            break;
        }
        _itemMode=_mode;
    }else{
        // here is show what is currently on a tile or open a zone
        NSMutableDictionary * currentIndex= [_Dic objectAtIndex:currentlyEditing.tag];
        if(![[currentIndex objectForKey:NPCkey] isEqual:@""]){
    
            _currentMangagedObject = [[dungeonMasterSingleton sharedInstance]findNPCNamed:currentIndex[NPCkey]];
            [self infoPopup:sender];
        }else if(![[currentIndex objectForKey:EncounterKey] isEqual:@""]){
            _currentMangagedObject = [[dungeonMasterSingleton sharedInstance]findEncounterNamed:[currentIndex objectForKey:EncounterKey]];
            [self infoPopup:sender];
        }else if(![[currentIndex objectForKey:NoteKey]isEqual:@""]){
            [dungeonMasterSingleton sharedInstance].currentNote= [[dungeonMasterSingleton sharedInstance]findNoteWithTimeStamp:[currentIndex objectForKey:NoteKey]];
            [self notePopup:sender];
        }else if(![[currentIndex objectForKey:MapKey]isEqual:@""]){
            [self showMapInfo:[[dungeonMasterSingleton sharedInstance]findMapNamed:[currentIndex objectForKey:MapKey]]];
        }else if(![[currentIndex objectForKey:ItemKey]isEqual:@""]){
            _currentMangagedObject = [[dungeonMasterSingleton sharedInstance]findItemNamed:[currentIndex objectForKey:ItemKey]];
            [self infoPopup:sender];
        }else if(![[currentIndex objectForKey:monsterKey]isEqual:@""]){
            _currentMangagedObject = [[dungeonMasterSingleton sharedInstance]findNPCNamed:[currentIndex objectForKey:monsterKey]];
            [self infoPopup:sender];
        }else if(![[currentIndex objectForKey:playerKey]isEqual:@""]){
            _currentMangagedObject = [[dungeonMasterSingleton sharedInstance]findPlayerCharacterNamed:[currentIndex objectForKey:playerKey]];
            [self infoPopup:sender];
        }
        
    }
}
-(void)npcPopup :(UIButton*)button{
    webViewPopoverViewController *webView= [[webViewPopoverViewController alloc]initWithNibName:@"webViewPopoverViewController" bundle:[NSBundle mainBundle]];
     
    webView.content= [_currentMangagedObject valueForKey:@"name"] ;
    _popover = [[UIPopoverController alloc]initWithContentViewController:webView];
    _popover.delegate=self;
    [_popover setPopoverContentSize:CGSizeMake(400, 400)];
    [_popover presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
-(void)notePopup:(UIButton *)button{
    campaignNoteTakerViewController *taker= [[campaignNoteTakerViewController alloc]initWithNibName:@"campaignNoteTakerViewController"bundle:[NSBundle mainBundle]];
    taker.delegate=self;
    
 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
     _popover= [[UIPopoverController alloc]initWithContentViewController:taker];
    _popover.delegate=self;
    [_popover setPopoverContentSize:CGSizeMake(500, 500)];
    [_popover presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
 }
 else{
     [self presentViewController:taker animated:YES completion:nil];
 }
}

-(void)presentModalMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController forMailHandler:(PCMailHandler *)mailHandler{
    
    [self presentViewController:mailComposeViewController animated:YES
                     completion:nil];
}

-(void)dismissModalMailComposeViewController:(MFMailComposeViewController *)mailComposeViewController forMailHandler:(PCMailHandler *)mailHandler{
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)infoPopup:(UIButton*)button{
    webViewPopoverViewController *webView= [[webViewPopoverViewController alloc]initWithNibName:@"webViewPopoverViewController" bundle:[NSBundle mainBundle]];
    webView.delegate=self;
    if([_currentMangagedObject isKindOfClass:[Character class]]){
        
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"characterViewer" ofType:@"html"];
        NSString * fullText = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
        NSString * backgroundString = ((Character *)_currentMangagedObject).background;
        if(backgroundString==nil)backgroundString=@"None";
        fullText= [fullText stringByReplacingOccurrencesOfString:@"{{CharacterBackground}}" withString:backgroundString ];
        
        NSString * nameString = ((Character *)_currentMangagedObject).name;
        if(nameString==nil)nameString=@"None";
        
        fullText= [fullText stringByReplacingOccurrencesOfString:@"{{CharacterName}}" withString: nameString];
        
        NSString * className = ((Character *)_currentMangagedObject).characterClass.name;
        if(className==nil)className=@"None";
        fullText= [fullText stringByReplacingOccurrencesOfString:@"{{CharacterClass}}" withString:className];
        
        NSString * raceName = ((Character *)_currentMangagedObject).race.name;
        if(raceName==nil)raceName=@"None";        
        fullText= [fullText stringByReplacingOccurrencesOfString:@"{{CharacterRace}}" withString: raceName];
        if ([[dungeonMasterSingleton sharedInstance]findNPCNamed:nameString]){
         
            webView.type=@"FullNPC";
             fullText= [fullText stringByReplacingOccurrencesOfString:@"{{HostName}}" withString: @"FullNPC"];
        }else{
            webView.type=@"FullPC";
            fullText= [fullText stringByReplacingOccurrencesOfString:@"{{HostName}}" withString: @"FullPC"];
        }
           webView.openFileNamed= nameString;
        webView.content=fullText;

    }else if([_currentMangagedObject isKindOfClass:[Encounter class]]){
        NSString * name=[_currentMangagedObject valueForKey:@"name"];
        NSString * fullText=[_currentMangagedObject valueForKey:@"about"];
        if(fullText ==nil || [fullText isEqualToString: @""]){
            NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"basicEncounter" ofType:@"html"];
            fullText = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
        }
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"encounter" ofType:@"html"];
        NSString * string = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
        if(name){
            string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:name];
        }else{
            string= [string stringByReplacingOccurrencesOfString:@"{{Name}}" withString:@"Suprise Encounter"];
        }
        webView.openFileNamed= name;
        webView.type=@"engage";
         string= [string stringByReplacingOccurrencesOfString:@"{{hasEngageButton}}" withString:[NSString stringWithFormat:@"<button id ='viewMap' type='button' onclick='window.location=\"engage://%@\"'> Engage enemy </button>",name]];
        webView.content= [string stringByReplacingOccurrencesOfString:@"{{NoteText}}" withString:fullText];

        
    }else{
        webView.content= [NSString stringWithFormat:@"%@ <p/> %@",[_currentMangagedObject valueForKey:@"name"], [_currentMangagedObject valueForKey:@"fulltext"] ] ;
    }
if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
    _popover = [[UIPopoverController alloc]initWithContentViewController:webView];
    _popover.delegate=self;
    [_popover setPopoverContentSize:CGSizeMake(500, 500)];
    [_popover presentPopoverFromRect:CGRectMake(0, 0, 25, 25) inView:button permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
else{
    [self presentViewController:webView animated:YES completion:nil];
}
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArray=[_toolsDic objectAtIndex:currentSelection.tag];

    return tempArray.count;
}


#pragma mark textfield datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Identify cell
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
    // Create cell
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.imageView.image= [[[_toolsDic objectAtIndex:currentSelection.tag]objectAtIndex:indexPath.row] objectForKey:@"image"];
    
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * selected_Dic= [[_toolsDic objectAtIndex:currentSelection.tag]objectAtIndex:indexPath.row];
    [currentSelection setImage:[selected_Dic objectForKey:@"image"] forState:UIControlStateNormal];
    _mode= [[selected_Dic objectForKey:@"mode"]integerValue];
    _groupSelectionTable.hidden=YES;

}

#pragma mark scrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView ==_toolkit)
        [self updateSelectionTableRect];
}

#pragma mark editing modes

-(void)dismissEditWindows{
    [UIView animateWithDuration:.5
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect toolFrame=_toolkit.frame;
                         toolFrame.origin.y=self.view.frame.size.height;
                         _toolkit.frame=toolFrame;
                         
                         CGRect sideMenuFrame= _sideMenu.frame;
                         sideMenuFrame.origin.x=self.view.frame.size.width;
                         _sideMenu.frame=sideMenuFrame;
                     }
                     completion:^(BOOL finished){
                     }];

}

-(void)showEditWindows{
    [UIView animateWithDuration:.5
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect toolFrame=_toolkit.frame;
                         toolFrame.origin.y=640;
                         _toolkit.frame=toolFrame;
                         
                         CGRect sideMenuFrame= _sideMenu.frame;
                         sideMenuFrame.origin.x=589;
                         _sideMenu.frame=sideMenuFrame;
                     }
                     completion:^(BOOL finished){
                     }];
}
- (IBAction)switchEditingModes:(UIButton *)sender {
    _canEdit=sender.selected;
    sender.selected=!_canEdit;
    if(_canEdit) [self showEditWindows];
    else [self dismissEditWindows];
  
    
}

#pragma mark uipopover delegate
- (BOOL) popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}

- (IBAction)openMapDetails:(id)sender {
    
    mapDescriptionViewController * map= [self createMapWithGridInfo:_Dic.last andFileName:_currentMap.gridInfomation];
    map.hasViewButton=NO;
    [self showMapPopOverControllerForMap:map];
}
@end
