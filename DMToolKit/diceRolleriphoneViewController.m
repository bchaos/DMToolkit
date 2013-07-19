//
//  diceRolleriphoneViewController.m
//  DMToolKit
//
//  Created by Bradford Farmer on 7/18/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "diceRolleriphoneViewController.h"

@interface diceRolleriphoneViewController ()

@end

@implementation diceRolleriphoneViewController

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
    [self configureIphone];
    self.view.backgroundColor= [fontsAndColourConstants MentorBlueGray];
    self.SelectionTable.backgroundColor= [fontsAndColourConstants MentorBlueGray];
    
	// Do any additional setup after loading the view.
}
-(void)configureIphone{
    NSString* boldFontName = @"Avenir-Black";
    self.selectedTotal.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.selectedTotal.font= [UIFont fontWithName:boldFontName size:14.0f];
    self.selectedTotal.layer.cornerRadius = 3.0f;
    self.selectedTotal.backgroundColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    
    self.diceNumber.titleLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.diceNumber.titleLabel.font= [UIFont fontWithName:boldFontName size:14.0f];
    self.mutliplier.titleLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.mutliplier.titleLabel.font= [UIFont fontWithName:boldFontName size:14.0f];
    self.modifiers.titleLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.modifiers.titleLabel.font= [UIFont fontWithName:boldFontName size:14.0f];
    self.dx.titleLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.dx.titleLabel.font= [UIFont fontWithName:boldFontName size:14.0f];
    self.toplabel.font= [UIFont fontWithName:boldFontName size:14.0f];
    self.toplabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    
}

-(UITableViewCell *)configureCellSection :(UITableViewCell *)cell{
    NSString* boldFontName = @"Avenir-Black";
    cell.textLabel.textColor= [UIColor whiteColor];
    cell.textLabel.font= [UIFont fontWithName:boldFontName size:13.0f];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(UITableViewCell *)configureCell :(UITableViewCell *)cell{
   NSString* boldFontName = @"Avenir-Black";
    CGRect frame= CGRectMake(0, 0, self.resultsTable.frame.size.width-20,  40);
    cell =[super configureCell:cell];
    cell.textLabel.textColor= [UIColor whiteColor];
    cell.textLabel.font= [UIFont fontWithName:boldFontName size:13.0f];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
