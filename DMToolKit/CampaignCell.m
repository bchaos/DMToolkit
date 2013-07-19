//
//  CampaignCell.m
//  DMToolKit
//
//  Created by Bradford Farmer on 7/19/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "CampaignCell.h"

@implementation CampaignCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)awakeFromNib{
    
    NSString* boldFontName = @"Avenir-Black";
    UIColor* mainColor = [fontsAndColourConstants MentorBlueGray];
    self.campaignContainer.backgroundColor = [UIColor whiteColor];
    self.campaignContainer.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.campaignContainer.layer.cornerRadius = 4.0f;
    self.CampainNameView.layer.cornerRadius=3.0f;
    self.CampainNameView.backgroundColor=mainColor;
    self.campname.textColor=  [UIColor whiteColor];

    self.campname.font=  [UIFont fontWithName:boldFontName size:14.0f];
}


@end
