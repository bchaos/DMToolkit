
//
//  CampaigniphoneViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 7/19/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CampaigniphoneViewController.h"
#import "CampaignCell.h"
@interface CampaigniphoneViewController ()

@end

@implementation CampaigniphoneViewController

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
    self.campaigns= [[DuegonMasterSingleton sharedInstance]AllCampaigns:nil];
    self.campaignsTable.backgroundColor=[fontsAndColourConstants MentorLightBlue];
	
    self.campaignsTable.separatorColor= [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.campaigns.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
CampaignCell* cell = [tableView dequeueReusableCellWithIdentifier:@"campaignCell"];
    NSManagedObject * object =[self.campaigns objectAtIndex:indexPath.row];
    
    cell.campname.text= [object valueForKey:@"name"];
    cell.layer.cornerRadius=3.0f;
    [cell.desWebView loadHTMLString:[object valueForKey:@"briefDescription"] baseURL:nil] ;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [DuegonMasterSingleton sharedInstance].currentCampaign= [self.campaigns objectAtIndex:indexPath.row];
    [JE_ notifyName:@"toCampaign" object:nil];
    
}

@end
