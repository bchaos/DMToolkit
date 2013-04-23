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


-(UITableViewCell *) confgureCell:(UITableViewCell *)cell{
 
    
    CGRect frame = CGRectMake(0, 0, 320, 70);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    cell.textLabel.font=[fontsAndColourConstants ApexMedium:20];
    imageView.image = [UIImage imageNamed:@"bar.png"];
    cell.backgroundView.frame = frame;
    cell.backgroundView = imageView;
    cell.textLabel.textColor=[UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
 
    return 70;
}

@end
