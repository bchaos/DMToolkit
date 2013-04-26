//
//  CharacterViewController.m
//  DMToolKit
//
//  Created by Bradford Rodgers-Farmer on 4/25/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CharacterViewController.h"

@interface CharacterViewController ()

@end
static NSString * nameKey= @"name";
static NSString * functionKey=@"function";
static NSString * rowKey= @"row";
static NSString * textKey= @"text";
static NSString * placeHolderKey=@"placeHolder";
@implementation CharacterViewController

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
    
    NSArray * characterNameDefaultData = [NSArray arrayWithObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Enter Name", @"placeHolder", nil]];
    
	self.sectionTable=[NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Character Name",nameKey, characterNameDefaultData, rowKey, nil], nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pullingdown:(UIPanGestureRecognizer *)sender {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


}



@end
