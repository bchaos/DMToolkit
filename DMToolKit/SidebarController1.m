//
//  SidebarController1.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "SidebarController1.h"

#import <QuartzCore/QuartzCore.h>

@interface SidebarController1 ()

@property (nonatomic, strong) NSArray* items;

@end
static NSString *const kKeychainItemName = @"Google Drive Quickstart";
static NSString *const kClientID = @"438117934368-6lbqvsfggi8892vcscmeec28cm974k12.apps.googleusercontent.com";
static NSString *const kClientSecret = @"88d5A5wJUtWa7zp9TTxQaYyh";

@implementation SidebarController1

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
    
    self.selectionTable.dataSource = self;
    self.selectionTable.delegate = self;
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.selectionTable.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.selectionTable.separatorColor = [UIColor clearColor];
    
    NSString* boldFontName = @"Avenir-Black";
    NSString* fontName = @"Avenir-BlackOblique";
    
    self.profileNameLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.profileNameLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    self.profileNameLabel.text = @"Lena Llellywyngot";
    
    self.profileLocationLabel.textColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    self.profileLocationLabel.font = [UIFont fontWithName:fontName size:12.0f];
    self.profileLocationLabel.text = @"London, UK";
    
    self.profileImageView.image = [UIImage imageNamed:@"profile.jpg"];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 4.0f;
    self.profileImageView.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.5f].CGColor;
    self.profileImageView.layer.cornerRadius = 35.0f;

	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.SelectionFields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *CellIdentifier = @"SidebarCell1";
    
    SidebarCell1* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Create cell
    if (cell == nil)
    {
        cell = [[SidebarCell1 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    if(![self atMainMenu] && ![self atReferenceMenu]){
        NSManagedObject*item = self.SelectionFields[indexPath.row];
        cell.textLabel.text=[item valueForKey:@"name"];
        
        cell.countLabel.alpha = 0;
        
    }else{
        NSDictionary* item = self.SelectionFields[indexPath.row];
        cell.titleLabel.text = item[@"name"];
        cell.iconImageView.image = [UIImage imageNamed:item[@"icon"]];
        NSString* count = item[@"count"];
        if(![count isEqualToString:@"0"]){
            cell.countLabel.text = count;
        }
        else{
            cell.countLabel.alpha = 0;
        }
    }
   

    cell.tag= indexPath.row;
    
    return cell;
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
