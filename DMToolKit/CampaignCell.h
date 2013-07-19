//
//  CampaignCell.h
//  DMToolKit
//
//  Created by Bradford Farmer on 7/19/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampaignCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *campname;
@property (strong, nonatomic) IBOutlet UIView *CampainNameView;
@property (strong, nonatomic) IBOutlet UIView *campaignContainer;

@property (strong, nonatomic) IBOutlet UIWebView *desWebView;

@end
