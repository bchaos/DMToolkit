//
//  SideBarBaseViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/23/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "SideBarBaseViewController.h"
#import "fontsAndColourConstants.h"
@interface SideBarBaseViewController ()

@end

static int textTag=1001;
@implementation SideBarBaseViewController

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
	_sectionLabel.font=[fontsAndColourConstants ApexBold:20];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)removeTextView:(UITableViewCell *)cell{
    for(UIView *sub in cell.subviews){
        if(sub.tag==textTag)
           [sub removeFromSuperview];
    }

}

-(TextFieldCell *) configureCell:(TextFieldCell *)cell{
    [cell removeTextfieldFromCell];
    CGRect frame = CGRectMake(0, 0, 320, 70);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    cell.textLabel.frame= frame;
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.textLabel.numberOfLines=0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font=[fontsAndColourConstants ApexMedium:20];
    imageView.image = [UIImage imageNamed:@"bar.png"];
    cell.backgroundView.frame = frame;
    cell.backgroundView = imageView;
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
-(TextFieldCell * )configureCellWithTextField:(TextFieldCell *)cell{
  
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
 
    return 70;
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
-(BOOL)atRaceMenu{
    return [self atMenuNamed:@"Player Races"];
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



@end
