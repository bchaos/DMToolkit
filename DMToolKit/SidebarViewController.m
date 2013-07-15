//
//  SidebarViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "SidebarViewController.h"
#import "DuegonMasterSingleton.h"
#import "AssetDataMiner.h"
static NSString * nameKey= @"name";
static NSString * functionKey=@"function";
static int textTag=1001;
@interface SidebarViewController (){
    NSString * actionFunction;
    NSString * writeToFunction;
    NSString * filterFunction;

}
@end

static NSString *const kKeychainItemName = @"Google Drive Quickstart";
static NSString *const kClientID = @"438117934368-6lbqvsfggi8892vcscmeec28cm974k12.apps.googleusercontent.com";
static NSString *const kClientSecret = @"88d5A5wJUtWa7zp9TTxQaYyh";

@implementation SidebarViewController
-(NSManagedObjectContext *)context{
    return [[AssetDataMiner sharedInstance]mainObjectContext];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setStartingContnet];
    actionFunction=nil;
    writeToFunction=nil;
    [_editableTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_editableTextField addTarget:self  action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
      
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return [_SelectionFields count];
}


-(TextFieldCell* )addDetailsToCell:(TextFieldCell *)cell forObject:(NSManagedObject*)Object{
      cell.detailTextLabel.text=@"";
    if([self atNoteMenu]){
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat: @"MM-dd-yyyy HH:mm:ss"];
        NSString *stringFromDate = [dateFormat stringFromDate:[Object valueForKey:@"date" ]];
        cell.detailTextLabel.text=stringFromDate;
        
    }else if([self atPlayermenu]){
        Character *character = [[Object valueForKey:@"characters"]anyObject];
        if (character)
            if(character.name)
            cell.detailTextLabel.text= [@"Character: " stringByAppendingString: character.name];
            
    }
       
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // Identify cell
    static NSString *CellIdentifier = @"cell";
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Create cell
    if (cell == nil)
    {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Set Text to cell

    if(![self atMainMenu] && ![self atReferenceMenu]){
        cell=[self configureCell:cell];
        cell.textLabel.text=[[_SelectionFields objectAtIndex:indexPath.row]valueForKey:nameKey];
        cell.tag= indexPath.row;
        cell.delegate=self;
        UILongPressGestureRecognizer * press= [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(editCell:)];
        [cell addGestureRecognizer:press];
        //[cell setTextFieldText:[[_SelectionFields objectAtIndex:indexPath.row]valueForKey:nameKey]];
        
               
    }else{
            cell= [self configureCell:cell];
            cell.textLabel.text= [[_SelectionFields objectAtIndex:indexPath.row]objectForKey:nameKey];

    }
    cell=[self addDetailsToCell:cell forObject:[_SelectionFields objectAtIndex:indexPath.row]];
    
    cell.tag=indexPath.row;

    //Add image background to cell
          
    
    
    return cell;
}
#pragma mark - write functions
-(void)playerName:(NSString *)name{
    _currentPlayer.name=name;
   
}
-(void)encounterName:(NSString *)name{
    [DuegonMasterSingleton sharedInstance].currentEncounter.name=name;
}
-(void)npcName:(NSString *)name{
    [DuegonMasterSingleton sharedInstance].currentCharacter.name=name;
}
-(void)noteName:(NSString *)name{
    _currentNote.name=name;
}
-(void)campaignName:(NSString *)name{
    [DuegonMasterSingleton sharedInstance].currentCampaign.name=name;
}

-(void)editingDidStart:(int)editingIndex{
    if([self atPlayermenu])
        _currentPlayer= [_SelectionFields objectAtIndex:editingIndex];
    [self sectionSelected:editingIndex resignResponder:NO];
}

#pragma mark- TableView Updating functions
-(void)save:(NSString *)name{
    
    SEL appSelector =NSSelectorFromString(writeToFunction);
    [self performSelector:appSelector withObject:name];
    [[DuegonMasterSingleton sharedInstance]save];
    

}
#pragma  mark -filtering functions


-(int)getFilteredPlayers:(NSString*)filter{
    [_SelectionFields removeAllObjects];
      NSArray * players= [[DuegonMasterSingleton sharedInstance]allPlayers:filter];
    if (players != nil && players.count>0){
        [_SelectionFields addObjectsFromArray: players];
        return players.count;
    }
    return 0;
    
}

-(int)getFilteredFeats:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * feats=[[DuegonMasterSingleton sharedInstance]AllFeats:filter];
    if (feats != nil && feats.count>0){
        [_SelectionFields addObjectsFromArray: feats];
        return feats.count;
    }
    return 0;
    
}

-(int)getFilteredItems:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * items=[[DuegonMasterSingleton sharedInstance]AllItems:filter];
    if (items != nil && items.count>0){
        [_SelectionFields addObjectsFromArray: items];
        return items.count;
    }
    return 0;
    
}


-(int)getFilteredNPCs:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * npcs=[[DuegonMasterSingleton sharedInstance]AllNPC:filter];
    if (npcs != nil && npcs.count>0){
        [_SelectionFields addObjectsFromArray: npcs];
        return npcs.count;
    }
    return 0;
}

-(int)getFilteredMonsters:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * monsters=[[DuegonMasterSingleton sharedInstance]AllMonsters:filter];
    if (monsters != nil && monsters.count>0){
        [_SelectionFields addObjectsFromArray: monsters];
        return monsters.count;
    }
    return 0;
}

-(int)getFilteredEncounters:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * encounters=[[DuegonMasterSingleton sharedInstance]AllEncounter:filter];
    if (encounters != nil && encounters.count>0){
        [_SelectionFields addObjectsFromArray: encounters];
        return encounters.count;
    }
    return 0;
}

-(int)getFilteredCampaigns:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * campaigns=[[DuegonMasterSingleton sharedInstance]AllCampaigns:filter];
    if (campaigns != nil && campaigns.count>0){
        [_SelectionFields addObjectsFromArray: campaigns];
        return campaigns.count;
    }
    return 0;
}


-(int)getFilteredSkills:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * skills=[[DuegonMasterSingleton sharedInstance]AllSkills:filter];
    if (skills != nil && skills.count>0){
        [_SelectionFields addObjectsFromArray: skills];
        return skills.count;
    }
    return 0;
}

-(int)getFilteredNotes:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * notes=[[DuegonMasterSingleton sharedInstance]AllNotes:filter];
    if (notes != nil && notes.count>0){
        [_SelectionFields addObjectsFromArray: notes];
        return notes.count;
    }
    return 0;
}

-(int)getFilteredPowers:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * powers=[[DuegonMasterSingleton sharedInstance]AllPowers:filter];
    if (powers != nil && powers.count>0){
        [_SelectionFields addObjectsFromArray: powers];
        return powers.count;
    }
    return 0;
}

-(int)getFilteredDomains:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * domains=[[DuegonMasterSingleton sharedInstance]AllDomains:filter];
    if (domains != nil && domains.count>0){
        [_SelectionFields addObjectsFromArray: domains];
        return domains.count;
    }
    return 0;
}

-(int)getFilteredClasses:(NSString*)filter{
    [_SelectionFields removeAllObjects];
    NSArray * domains=[[DuegonMasterSingleton sharedInstance]AllCharacterClasses:filter];
    if (domains != nil && domains.count>0){
        [_SelectionFields addObjectsFromArray: domains];
        return domains.count;
    }
    return 0;
}


#pragma mark- tableViewingFunctions
-(void)showCharacterTableView:(NSDictionary *)dic{
    actionFunction= kShowCharacterCreator;
    writeToFunction=@"playerName:";
    
   
    
    int allPlayersCount =[self getFilteredPlayers:nil];
    if (allPlayersCount >0){
        
         [[DuegonMasterSingleton sharedInstance] updateCurrentPlayer: [_SelectionFields objectAtIndex:0]];
    }
}

-(void)showItemsTable:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredItems:nil];
    filterFunction=@"getFilteredItems:";
    actionFunction=@"toReferenceViewer";
}


-(void)showNPCSTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredNPCs:nil];
    filterFunction= @"getFilteredNPCs:";
    actionFunction= kShowCharacterCreatorNPC;
    writeToFunction=@"npcName:";

}

-(void)showMonstersTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredMonsters:nil];
     actionFunction=@"toReferenceViewer";
    filterFunction= @"getFilteredMonsters:";
}


-(void)showEncountersTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredEncounters:nil];
    filterFunction= @"getFilteredEncounters:";
    writeToFunction=@"encounterName:";
     actionFunction=@"toEncounterViewer";
}

-(void)showCampaignTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredCampaigns:nil];
    filterFunction= @"getFilteredCampaigns:";
    actionFunction=@"toCampaign";
    writeToFunction =@"campaignName";
}

-(void)showNotesTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredNotes:nil];
    actionFunction= @"toNoteTaker";
    writeToFunction=@"noteName:";
    filterFunction= @"getFilteredNotes:";
}


-(void)showFeatsTableView:(NSDictionary *)dic{
     [_SelectionFields removeAllObjects];
    [self getFilteredFeats:nil];
     actionFunction=@"toReferenceViewer";
     filterFunction= @"getFilteredFeats:";
   
}
-(void)showSkillsTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredSkills:nil];
     actionFunction=@"toReferenceViewer";
    filterFunction= @"getFilteredSkills:";
    
}
-(void)showPowersTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredPowers:nil];
     actionFunction=@"toReferenceViewer";
    filterFunction= @"getFilteredPowers:";
    
}
-(void)showDomainsTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredDomains:nil];
     actionFunction=@"toReferenceViewer";
    filterFunction= @"getFilteredDomains:";
}

-(void)showClassesTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
    [self getFilteredClasses:nil];
    actionFunction=@"toReferenceViewer";
    filterFunction= @"getFilteredClasses:";
}

-(void)showReferenceTableView:(NSDictionary *)dic{
    [_SelectionFields removeAllObjects];
     self.sectionLabel.text= @"Compendium";
    _SelectionFields= [NSMutableArray arrayWithObjects: [NSDictionary dictionaryWithObjectsAndKeys:@"Items" ,nameKey, @"showItemsTable:", functionKey, nil] , 
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Monsters" ,nameKey, @"showMonstersTableView:", functionKey, nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Feats" ,nameKey, @"showFeatsTableView:", functionKey, nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Skills" ,nameKey, @"showSkillsTableView:", functionKey, nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Powers" ,nameKey, @"showPowersTableView:", functionKey, nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Domains" ,nameKey, @"showDomainsTableView:", functionKey, nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:@"Classes" ,nameKey, @"showClassesTableView:", functionKey, nil],
                       nil];
    actionFunction= nil;
}

-(void)showExternalNotes:(NSDictionary*)dic{
    [_SelectionFields removeAllObjects];
    self.sectionLabel.text= @"External Notes";
    _SelectionFields= [NSMutableArray arrayWithObjects: [NSDictionary dictionaryWithObjectsAndKeys:@"Google Drive" ,nameKey, @"GoogleDrive:", functionKey, nil] ,
                       [NSDictionary dictionaryWithObjectsAndKeys:@"Evernote" ,nameKey, @"EverNote:", functionKey, nil],
                       nil];
    actionFunction= nil;
}
//---- external notes-----

-(void)GoogleDrive:(NSDictionary*)dic{
    
    
    self.driveService = [[GTLServiceDrive alloc] init];
    
    self.driveService.authorizer = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                                                         clientID:kClientID
                                                                                     clientSecret:kClientSecret];
   

    if (![self isAuthorized])
    {
         [self presentViewController:[self createAuthController] animated:YES completion:nil];
    }else{
        [self loadDriveFiles];
    }
}


// Helper to check if user is authorized
- (BOOL)isAuthorized
{
    return [((GTMOAuth2Authentication *)self.driveService.authorizer) canAuthorize];
}

// Creates the auth controller for authorizing access to Google Drive.
- (GTMOAuth2ViewControllerTouch *)createAuthController
{
    GTMOAuth2ViewControllerTouch *authController;
    authController = [[GTMOAuth2ViewControllerTouch alloc] initWithScope:kGTLAuthScopeDrive
                                                                clientID:kClientID
                                                            clientSecret:kClientSecret
                                                        keychainItemName:kKeychainItemName
                                                                delegate:self
                                                        finishedSelector:@selector(viewController:finishedWithAuth:error:)];
    return authController;
}

// Handle completion of the authorization process, and updates the Drive service
// with the new credentials.
- (void)viewController:(GTMOAuth2ViewControllerTouch *)viewController
      finishedWithAuth:(GTMOAuth2Authentication *)authResult
                 error:(NSError *)error
{
    if (error != nil)
    {
        [JE_ okWithTitle:@"Authentication Error" message:error.localizedDescription];
        self.driveService.authorizer = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        self.driveService.authorizer = authResult;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self loadDriveFiles];
    }
}

-(void)loadDriveFiles{
    [_networkactivity startAnimating];
    GTLQueryDrive *query = [GTLQueryDrive queryForFilesList];
    query.q  = @"mimeType = 'application/pdf' OR mimeType = 'text/html'";
    [self.driveService executeQuery:query completionHandler:^(GTLServiceTicket *ticket,
                                                              GTLDriveFileList *files,
                                                              NSError *error) {

        if (error == nil) {
            if (self.driveFiles == nil) {
                self.driveFiles = [[NSMutableArray alloc] init];
            }
            [self.driveFiles removeAllObjects];
            [self.driveFiles addObjectsFromArray:files.items];
            [_SelectionFields removeAllObjects];
            for ( GTLDriveFile *file in self.driveFiles){
                
                [_SelectionFields addObject:  [NSDictionary dictionaryWithObjectsAndKeys:file.title ,nameKey, @"loadDriveFileContent:", functionKey, file.downloadUrl, @"guid",nil]];
            }
            
            [_selectionTable reloadData];
     
        } else {
            [JE_ okWithTitle:@"Unable to load files"
                     message:[error description]
             ];
        
        
        }
        [_networkactivity stopAnimating];
        
    }];
    
}

-(void)loadDriveFileContent:(NSDictionary *)dic {
    self.sectionLabel.text= @"Google Drive";
    GTMHTTPFetcher *fetcher =
    [self.driveService.fetcherService fetcherWithURLString:[dic objectForKey:@"guid"]];
    
    [fetcher beginFetchWithCompletionHandler:^(NSData *data, NSError *error) {

        if (error == nil) {
            if([[dic objectForKey:nameKey] hasSuffix:@"pdf"]){
                NSString  *pdfPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/temp.pdf"];
                [data writeToFile:pdfPath atomically:YES];
                ReaderDocument* document =[[ReaderDocument alloc]initWithFilePath:pdfPath password:nil];
                PDFWidget * reader = [[PDFWidget alloc]initWithReaderDocument:document];
                reader.delegate=self;
                [self presentViewController:reader animated:YES completion:nil];
            }else{
                NSString* fileContent = [[NSString alloc] initWithData:data
                                                          encoding:NSUTF8StringEncoding];
                
                Notes *GoogleDoc = [[DuegonMasterSingleton sharedInstance]findNoteWithExternalID:[dic objectForKey:@"guid"]];
                if(GoogleDoc==nil)
                    GoogleDoc =[[DuegonMasterSingleton sharedInstance]createNotes];
                GoogleDoc.date= [NSDate date];
                GoogleDoc.group = @"GoogleDoc";
                GoogleDoc.externalid= [dic objectForKey:@"guid"];
                GoogleDoc.text=fileContent;
                [DuegonMasterSingleton sharedInstance].currentNote= GoogleDoc;
                [JE_ notifyName: @"toNoteTaker" object:nil];

            }
        } else {
            [JE_ okWithTitle:@"Unable to load files"
                     message:[error description]
             ];

        }
    }];

    
}

-(void)dismissReaderViewController:(ReaderViewController *)viewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//--------evernotes 

-(void)EverNote:(NSDictionary*)dic{
    EvernoteSession *session = [EvernoteSession sharedSession];
    NSLog(@"Session host: %@", [session host]);
    NSLog(@"Session key: %@", [session consumerKey]);
    NSLog(@"Session secret: %@", [session consumerSecret]);
    [session authenticateWithViewController:self completionHandler:^(NSError *error) {
        if (error || !session.isAuthenticated){
            if (error) {
                NSLog(@"Error authenticating with Evernote Cloud API: %@", error);
            }
            if (!session.isAuthenticated) {
                NSLog(@"Session not authenticated");
            }
        } else {
            // We're authenticated!
            EvernoteUserStore *userStore = [EvernoteUserStore userStore];
            [userStore getUserWithSuccess:^(EDAMUser *user) {
                [self listNoteBooks];
                
                           } failure:^(NSError *error) {
                // failure
                NSLog(@"Error getting user: %@", error);
            } ];
        }
    }];
}

-(void)listNoteBooks{
    [_SelectionFields removeAllObjects];
    [_networkactivity startAnimating];
    [[EvernoteNoteStore noteStore]listNotebooksWithSuccess:^(NSArray *notebooks) {
        [_SelectionFields removeAllObjects];
        self.sectionLabel.text= @"Evernote notebooks";
        for (EDAMNotebook * notebook in notebooks){
            [_SelectionFields addObject:  [NSDictionary dictionaryWithObjectsAndKeys:notebook.name ,nameKey, @"OpenEvernoteNotebook:", functionKey, notebook.guid, @"guid",nil]];
        }
        _PulldownToAddLabel.text=@"";
        [_selectionTable reloadData];
        [_networkactivity stopAnimating];
    } failure:^(NSError *error) {
        NSLog(@"no notebooks found getting user: %@", error);
         [_selectionTable reloadData];
        [self showOfflineNotification];
         [_networkactivity stopAnimating];
    }];
   

    
}
-(void)showOfflineNotification{
    [JE_ okWithTitle:@"offline" message:@"Can not connect at this time please check you internet connection and try again"];
}

-(void)OpenEvernoteNotebook:(NSDictionary*)dic{
    [_SelectionFields removeAllObjects];
    [_networkactivity startAnimating];
    EDAMNoteFilter *notefilter=[[EDAMNoteFilter alloc]initWithOrder:0 ascending:YES words:nil notebookGuid:[dic objectForKey:@"guid"] tagGuids:nil timeZone:nil inactive:NO emphasized:nil];
    
    [[EvernoteNoteStore noteStore]findNotesWithFilter:notefilter offset:0 maxNotes:30 success:^(EDAMNoteList *list) {
        [_SelectionFields removeAllObjects];
        self.sectionLabel.text= @"Evernote notes";
        for (EDAMNote * note in list.notes){
           
            [_SelectionFields addObject:[NSDictionary dictionaryWithObjectsAndKeys:note.title ,nameKey, @"OpenEvernoteNote:", functionKey, note.guid, @"guid",nil]];
        }
        
        [_networkactivity stopAnimating];
         _PulldownToAddLabel.text=@"";
        [_selectionTable reloadData];
    } failure:^(NSError *error) {
         NSLog(@"no notes found");
         [_selectionTable reloadData];
    }];
}

-(void)OpenEvernoteNote:(NSDictionary*)dic{
    Notes *Evernote = [[DuegonMasterSingleton sharedInstance]findNoteWithExternalID:[dic objectForKey:@"guid"]];
    if(Evernote==nil)
        Evernote =[[DuegonMasterSingleton sharedInstance]createNotes];
    Evernote.date= [NSDate date];
    Evernote.group = @"Evernote";
    Evernote.externalid= [dic objectForKey:@"guid"];
    ENMLUtility *utltility = [[ENMLUtility alloc] init];
    Evernote.name =[dic objectForKey:nameKey];
    [[EvernoteNoteStore  noteStore]getNoteWithGuid:[dic objectForKey:@"guid"] withContent:YES withResourcesData:YES withResourcesRecognition:YES withResourcesAlternateData:YES success:^(EDAMNote *note) {
        [utltility convertENMLToHTML:note.content withResources:note.resources completionBlock:^(NSString *html, NSError *error) {
            if(error == nil) {
                Evernote.text=html;
                [DuegonMasterSingleton sharedInstance].currentNote= Evernote;
                [JE_ notifyName: @"toNoteTaker" object:nil];
            }else{
                [JE_ okWithTitle:@"can not display" message:@"we are unable to display this note"];
                [[DuegonMasterSingleton sharedInstance]deleteItem:Evernote];
            }
  
        }];
     
   
    } failure:^(NSError *error) {
        [self showOfflineNotification];
    
    }];
}

-(void)DropBox:(NSDictionary*)dic{
    
}

-(void)addCharacter{
    
}

-(void)editCell:(UILongPressGestureRecognizer*)press{
   _selectedCellIndex= press.view.tag;
     if(![self atMainMenu] && ![self atReferenceMenu]){
         [self startEditing:_editableTextField];
     }
}

-(void)setStartingContnet{
    self.sectionLabel.text= @"Main Menu";
    _SelectionFields = [NSMutableArray arrayWithObjects:
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Campaigns" ,nameKey, @"showCampaignTableView:", functionKey, nil] ,
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Players" ,nameKey, @"showCharacterTableView:", functionKey, nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"NPCs" ,nameKey, @"showNPCSTableView:", functionKey, nil],
                         [NSDictionary dictionaryWithObjectsAndKeys:@"Encounters" ,nameKey, @"showEncountersTableView:", functionKey, nil],
                        [NSDictionary dictionaryWithObjectsAndKeys:@"Notes" ,nameKey, @"showNotesTableView:", functionKey, nil] ,
                        [NSDictionary dictionaryWithObjectsAndKeys:@"External Notes" ,nameKey, @"showExternalNotes:", functionKey, nil],

                        [NSDictionary dictionaryWithObjectsAndKeys:@"Compendium" ,nameKey, @"showReferenceTableView:", functionKey, nil],
                        
                       nil];
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
#pragma mark menu location functions

-(BOOL)atMenuNamed:(NSString *) MenuName{
    
    if([self.sectionLabel.text isEqualToString:MenuName]){
        return YES;
    }
    return NO;
}
-(BOOL)atMainMenu{
    return  [self atMenuNamed:@"Main Menu"];
}
-(BOOL)atNoteMenu{
    return  [self atMenuNamed:@"Notes"];
}
-(BOOL)atNPCMenu{
    return [self atMenuNamed:@"NPCs"];
}

-(BOOL)atEncounterMenu{
    return [self atMenuNamed:@"Encounters"];
}
-(BOOL)atItemsMenu{
    return [self atMenuNamed:@"Items"];
}
-(BOOL)atMonstersMenu{
    return [self atMenuNamed:@"Monsters"];
}

-(BOOL)atFeatsMenu{
    return [self atMenuNamed:@"Feats"];
}

-(BOOL)atSkillsMenu{
    return [self atMenuNamed:@"Skills"];
}

-(BOOL)atPowersMenu{
    return [self atMenuNamed:@"Powers"];
}

-(BOOL)atDomainsMenu{
    return [self atMenuNamed:@"Domains"];
}

-(BOOL)atClassesMenu{
    return [self atMenuNamed:@"Classes"];
}

-(BOOL)atEvernoteNoteMenu{
    return [self atMenuNamed:@"Evernote notes"];
}

-(BOOL)atDriveMenu{
    return [self atMenuNamed:@"Google Drive"];
}


-(BOOL)atCompendiumSubMenu{
    return ( [self atMenuNamed:@"Items"] ||[self atMenuNamed:@"Monsters"]||[self atMenuNamed:@"Feats"]||[self atMenuNamed:@"Skills"]||[self atMenuNamed:@"Powers"]||[self atMenuNamed:@"Domains"]||[self atMenuNamed:@"Classes"]  );
}
-(BOOL)atExternalNoteSubMenu{
    return [self atMenuNamed:@"External Notes"];

}

-(BOOL)atEverNoteBook{
    return [self atMenuNamed:@"Evernote notebooks"];
}

-(BOOL)atReferenceMenu{
    return [self atMenuNamed:@"Compendium"];
}
-(BOOL)atPlayermenu{
     return  [self atMenuNamed:@"Players"];
}
-(BOOL)atCampaignMenu{
    return  [self atMenuNamed:@"Campaigns"];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [JE_ notifyName:@"deselect" object:nil];
  
    if([actionFunction isEqualToString:@"toReferenceViewer"]){
        [DuegonMasterSingleton sharedInstance].currentObject=[_SelectionFields objectAtIndex:indexPath.row];
    }if ([self atNoteMenu]){
        [DuegonMasterSingleton sharedInstance].currentNote=  [_SelectionFields objectAtIndex:indexPath.row];
    }else if([self atNPCMenu]){
        [DuegonMasterSingleton sharedInstance].currentCharacter =  [_SelectionFields objectAtIndex:indexPath.row];
    }else if([self atCampaignMenu]){
        [DuegonMasterSingleton sharedInstance].currentCampaign =  [_SelectionFields objectAtIndex:indexPath.row];
        Map * map= [DuegonMasterSingleton sharedInstance].currentCampaign.map;
        [DuegonMasterSingleton sharedInstance].currentMap=map;
    }else if ([self atPlayermenu]){
        [DuegonMasterSingleton sharedInstance].currentCharacter =  [[[[_SelectionFields objectAtIndex:indexPath.row] valueForKey:@"characters"]allObjects] objectAtIndex:0];
    }
    else if ([self atEncounterMenu]){
        [DuegonMasterSingleton sharedInstance].currentEncounter=  [_SelectionFields objectAtIndex:indexPath.row];
        [DuegonMasterSingleton sharedInstance].currentMap= [DuegonMasterSingleton sharedInstance].currentEncounter.map;

    }
    if(actionFunction !=nil && ![self atMainMenu] && ! [self atReferenceMenu]){
        [JE_ notifyName:actionFunction object:nil];
    }

    [((TextFieldCell *)[_selectionTable cellForRowAtIndexPath:indexPath]) select];
    if([self atMainMenu] || [self atReferenceMenu] || [self atExternalNoteSubMenu] || [self atEverNoteBook] || [self atEvernoteNoteMenu] | [self atDriveMenu]){
    _selectedCellIndex=indexPath.row;
        [self loadMenu:_selectedCellIndex];
    }
    
 
    

       
    
}
-(void)loadMenu:(int)index{
    BOOL refMenu=NO;
    if([self atReferenceMenu])refMenu=YES;
    [self textFieldDidEndEditing: _editableTextField];
    NSDictionary * currentSelectionDictionary =[_SelectionFields objectAtIndex:index];
    NSString *functionString = [currentSelectionDictionary objectForKey:functionKey];
    SEL appSelector = NSSelectorFromString(functionString);
    NSString * nameToShow=[currentSelectionDictionary objectForKey:nameKey];
    self.sectionLabel.text = nameToShow;
    [self performSelector:appSelector withObject:currentSelectionDictionary];
    _backbutton.alpha=1.0;
    _searchField.alpha=1.0;
    [_searchField resignFirstResponder];
    if(_SelectionFields.count==0){
        _PulldownToAddLabel.alpha=1.0;
        _PulldownToAddLabel.text= [NSString stringWithFormat:@"Pull down to add a %@", [nameToShow substringToIndex:nameToShow.length-1]];
    }
    if(refMenu &&_SelectionFields.count>0){
        [DuegonMasterSingleton sharedInstance].currentfulltext=[_SelectionFields objectAtIndex:0] ;
    }
   
    [self.selectionTable reloadData];
}

-(void)sectionSelected:(int)selectionIndex resignResponder:(BOOL)resign{
    [JE_ notifyName:@"deselect" object:nil];
    if([self atPlayermenu]){
        
        [[DuegonMasterSingleton sharedInstance] updateCurrentPlayer: [_SelectionFields objectAtIndex:selectionIndex]];
        
    }
    else if ([self atNPCMenu]){
        [DuegonMasterSingleton sharedInstance].currentCharacter= [_SelectionFields objectAtIndex:selectionIndex];
    }
    else if ([self atNoteMenu]){
        [DuegonMasterSingleton sharedInstance].currentNote=  [_SelectionFields objectAtIndex:selectionIndex];
    }else if ([self atCampaignMenu]){
        [DuegonMasterSingleton sharedInstance].currentCampaign=[_SelectionFields objectAtIndex:selectionIndex];
        [DuegonMasterSingleton sharedInstance].currentMap=[DuegonMasterSingleton sharedInstance].currentCampaign.map;
    }else if ([self atEncounterMenu]){
        [DuegonMasterSingleton  sharedInstance].currentEncounter=  [_SelectionFields objectAtIndex:selectionIndex];

    }
    else if([self atMainMenu]  || [self atReferenceMenu]){
        [self loadMenu:selectionIndex ];
    }
    if(actionFunction !=nil){
        [JE_ notifyName:actionFunction object:nil];
    }
    if(resign)
    [JE_ notifyName:@"resignFirstResponder" object:nil];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return (![self atMainMenu] && ![self atReferenceMenu]);
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        _selectedCellIndex = indexPath.row;
        [self deleteRow];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if((int)buttonIndex==1 )
        [self deleteRow];
}
-(void)nothing:(id)sender{
    
}
- (IBAction)goBack:(id)sender {
        [_searchField resignFirstResponder];
    
    if(![self atCompendiumSubMenu]){
        [self textFieldDidEndEditing: _editableTextField];
        [self setStartingContnet];
        _backbutton.alpha=0.0;
        _searchField.alpha=0.0;
       _PulldownToAddLabel.alpha=0.0;
        actionFunction=nil;
        writeToFunction=nil;
        //[JE_ notifyName:@"goBack" object:nil];
        [[self context]save:nil];
    }else{
        [self showReferenceTableView:nil];
    }
     [self.selectionTable reloadData];
    }
- (IBAction)filterCurrentSection:(UITextField*)sender {
    SEL appSelector =NSSelectorFromString(filterFunction);
    [self performSelector:appSelector withObject:sender.text];
    [self.selectionTable reloadData];
}

#pragma  mark adding and updating menus

-(void)createNewObjectBasedOnCurrentmenu{
    if([self atPlayermenu]){
        _currentPlayer = [[DuegonMasterSingleton sharedInstance]createPlayerNamed:@""];
        [ _SelectionFields insertObject:_currentPlayer atIndex:0];
    }
    if([self atNoteMenu]){
        _currentNote= [[DuegonMasterSingleton sharedInstance]createNotes];
        _currentNote.name=@"New Note";
        _currentNote.date=[NSDate date];
        _currentNote.text=@"Click here to begin editing your new note.";
        [DuegonMasterSingleton sharedInstance].currentNote=_currentNote;
       
        [ _SelectionFields insertObject:_currentNote atIndex:0];
    }if([self atNPCMenu]){
        _currentCharacter= [[DuegonMasterSingleton sharedInstance]createNPC];
        [ _SelectionFields insertObject:_currentCharacter atIndex:0];
    }else if ([self atCampaignMenu]){
        Campaign * newCampaing = [[DuegonMasterSingleton sharedInstance]createCampaign];
        Map * map= [[DuegonMasterSingleton sharedInstance]createMap];
        newCampaing.map=map;
        map.campain=newCampaing;
        [_SelectionFields insertObject:newCampaing atIndex:0];
        [DuegonMasterSingleton sharedInstance].currentCampaign=newCampaing;
        [DuegonMasterSingleton sharedInstance].currentMap=map;
    }else if ([self atEncounterMenu]){
        Encounter * newEncounter= [[DuegonMasterSingleton sharedInstance]createEncounter];
        Map * map= [[DuegonMasterSingleton sharedInstance]createMap];
        newEncounter.map= map;
        map.encounter=newEncounter;
        [DuegonMasterSingleton sharedInstance].currentMap=map;
        [DuegonMasterSingleton sharedInstance].currentEncounter=newEncounter;
        
        [ _SelectionFields insertObject:newEncounter atIndex:0];
    }else if ( [self atItemsMenu]){
        Items * newItem = [[DuegonMasterSingleton sharedInstance]createItems];
         [DuegonMasterSingleton sharedInstance].currentItem=newItem;
         [ _SelectionFields insertObject:newItem atIndex:0];
    }else if ( [self atFeatsMenu]){
         Feats * newFeat = [[DuegonMasterSingleton sharedInstance]createFeat];
        [DuegonMasterSingleton sharedInstance].currentFeat=newFeat;
        [ _SelectionFields insertObject:newFeat atIndex:0];
    }else if ( [self atSkillsMenu]){
        Skills * newSkill = [[DuegonMasterSingleton sharedInstance]createSkill];
        [DuegonMasterSingleton sharedInstance].currentSkill=newSkill;
        [ _SelectionFields insertObject:newSkill atIndex:0];
    }else if ( [self atPowersMenu]){
        Powers * newPower = [[DuegonMasterSingleton sharedInstance]createPower];
        [DuegonMasterSingleton sharedInstance].currentPower=newPower;
        [ _SelectionFields insertObject:newPower atIndex:0];
    }else if ( [self atClassesMenu]){
        CharacterClass * newClass = [[DuegonMasterSingleton sharedInstance]createCharacterClass];
        [DuegonMasterSingleton sharedInstance].currentCharacterClass=newClass;
        [ _SelectionFields insertObject:newClass atIndex:0];
    }else if ( [self atDomainsMenu]){
        Domain * newDomain = [[DuegonMasterSingleton sharedInstance]createDomain];
        [DuegonMasterSingleton sharedInstance].currentDomain=newDomain;
        [ _SelectionFields insertObject:newDomain atIndex:0];
    }else if ( [self atMonstersMenu]){
        NPC * newmonster = [[DuegonMasterSingleton sharedInstance]createMonster];
        [DuegonMasterSingleton sharedInstance].currentMonster=newmonster;
        [ _SelectionFields insertObject:newmonster atIndex:0];
    }
    
     [[DuegonMasterSingleton sharedInstance]save];
    
}


- (IBAction)addNew:(UIPanGestureRecognizer *)sender {
    UITableViewCell * topCell;
    NSArray * visibleCells=[self.selectionTable visibleCells];
    if(visibleCells.count > 0) topCell = [visibleCells objectAtIndex:0];
    else {
        topCell= [[UITableViewCell alloc]init];
        topCell.tag=0;
    }
       
    if(_newObjectAdded && _isEditing){
        [self textFieldDidEndEditing: _editableTextField];
            }
    [_searchField resignFirstResponder];
    if(![self atMainMenu] && ![self atReferenceMenu]&&  topCell.tag ==0){
    if (_tempCell==nil){
        _tempCell =[[tempSideCellView alloc]initWithFrame:CGRectMake(0, 93, 320, 0)];
        _tempCell.alpha=0.0;
        [self.view addSubview:_tempCell];
    }
 
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _newObjectAdded=NO;
            [_tempCell upateCellWithFrame:CGRectMake(0, 93, 320, [sender translationInView:self.selectionTable].y/2)];
            break;
        case UIGestureRecognizerStateChanged:
            if ( [sender translationInView:self.selectionTable].y /2> 0 && [sender translationInView:self.selectionTable].y/2 < 70 && !_newObjectAdded){
                [_tempCell upateCellWithFrame:CGRectMake(0, 93, 320, [sender translationInView:self.selectionTable].y/2)];
            }
            else if ([sender translationInView:self.selectionTable].y/2 > 70 && !_newObjectAdded ){
                [self createNewObjectBasedOnCurrentmenu];
                _newObjectAdded=YES;
                _tempCell.alpha=0.0;
                [_selectionTable reloadData];
                
                [UIView animateWithDuration:.3
                                      delay: 0.0
                                    options: UIViewAnimationOptionAllowUserInteraction
                                 animations:^{
                                        _PulldownToAddLabel.alpha=0.0;
                                 }
                                 completion:^(BOOL finished){
                                     
                                 }];

           
            }
            else{
                _tempCell.alpha=0.0;
            }
            
            break;
        case UIGestureRecognizerStateEnded:
          
            [_tempCell upateCellWithFrame:CGRectMake(0, 93, 320, [sender translationInView:self.selectionTable].y/2)];
            [_tempCell removeFromSuperview];
            _tempCell=nil;
            if(_newObjectAdded){
                if(actionFunction !=nil){
                    [JE_ notifyName:actionFunction object:nil];
                }
               
                 _selectedCellIndex=0;
                if(![self atNoteMenu]) [self startEditing:_editableTextField];
                _isEditing=true;
            
              
               
            }
            break;
        default:
            break;
    }
    }
}

-(void)done{
    [_pop dismissPopoverAnimated:YES];
}
- (IBAction)showInfo:(id)sender {
      webViewPopoverViewController *webView= [[webViewPopoverViewController alloc]initWithNibName:@"webViewPopoverViewController" bundle:[NSBundle mainBundle]];
    webView.delegate=self;
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"toolkitCopyInfo" ofType:@"html"];
    NSString * fullText = [NSString stringWithContentsOfFile:fullPath encoding:NSStringEncodingConversionAllowLossy error:nil];
    webView.content=fullText;
    _pop = [[UIPopoverController alloc]initWithContentViewController:webView];
    _pop.delegate=self;
    [_pop setPopoverContentSize:CGSizeMake(500, 500)];
    [_pop presentPopoverFromRect:CGRectMake(300, 150, 500, 500) inView:self.view permittedArrowDirections:0 animated:YES];

}


-(void)deleteRow{
        [_editableTextField resignFirstResponder];
        NSManagedObject *object = [_SelectionFields objectAtIndex:_selectedCellIndex];
        if ([object isKindOfClass:[Notes class]]){
            NSURL *myid=[object.objectID URIRepresentation];
            NSString *string =myid.host;
            NSString  *pngPath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@.png",string]];
            [[NSFileManager defaultManager]removeItemAtPath:pngPath error:nil];
        }
        [[DuegonMasterSingleton sharedInstance]deleteItem:object];
        [_SelectionFields removeObjectAtIndex:_selectedCellIndex];
        [_selectionTable reloadData];

}
#pragma mark textfield delegate


-(void)textFieldDidChange:(UITextField *)textField {
    NSManagedObject  * textDic= [_SelectionFields objectAtIndex:_selectedCellIndex];
    [textDic setValue:textField.text forKey:nameKey];
    [_SelectionFields replaceObjectAtIndex:_selectedCellIndex withObject:textDic];
    [[DuegonMasterSingleton sharedInstance]save];
    [JE_ notifyName:@"updateHeader" object:nil];
    [_selectionTable reloadData];
}


-(void)startEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
     NSManagedObject  * textDic= [_SelectionFields objectAtIndex:_selectedCellIndex];
    NSString * currentName= [textDic valueForKey:nameKey];
    if([currentName isEqualToString:@"New"]){
        textField.text=@"";
    }else{
        textField.text= currentName;
    }

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _isEditing=false;


    textField.text=@"";
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)showDemBones:(UIButton * )sender {
    DiceRollerViewController * diceRoller= [[DiceRollerViewController alloc]initWithNibName:@"DiceRollerViewController" bundle:[NSBundle mainBundle]];
    
    _pop= [[UIPopoverController alloc]initWithContentViewController:diceRoller];
    [_pop setPopoverContentSize:CGSizeMake(460, 600)];
    [_pop presentPopoverFromRect:CGRectMake(-20, 10, 100, 100) inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (IBAction)importpdf:(id)sender {
}
@end
