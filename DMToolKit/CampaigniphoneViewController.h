//
//  CampaigniphoneViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 7/19/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampaigniphoneViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *campaignsTable;
@property(nonatomic, strong)NSArray  *campaigns;
@end
