//
//  SidebarCell1.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "SidebarCell1.h"
#import <QuartzCore/QuartzCore.h>

@implementation SidebarCell1

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
    
    self.bgView.backgroundColor= [fontsAndColourConstants MentorBlueGray];
    
    self.topSeparator.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    self.bottomSeparator.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    
    NSString* boldFontName = @"Avenir-Black";
    
    self.titleLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.titleLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    self.textLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.textLabel.font= [UIFont fontWithName:boldFontName size:14.0f];
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.backgroundColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    self.countLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    
    self.countLabel.layer.cornerRadius = 3.0f;
}

-(void)select{
  
}
-(void)deselect{
  
}

-(void)resignResponder{
    [self.textField resignFirstResponder];
}
-(void)save{
    [self.delegate save:self.textField.text];
}
-(void)startedEditing{
    [self.delegate editingDidStart:self.tag];
    [self select];
}
-(void)removeTextfieldFromCell{
    [self.textField removeFromSuperview];
    self.textField=nil;
}
-(void)sectionSelected{
    [self.delegate sectionSelected:self.tag resignResponder:YES];
    [self select];
}

-(void)upateCellWithFrame :(CGRect)frame{
    self.frame=frame;
    self.alpha= 1;
    if(![self.textLabel.text isEqualToString:@"Keep pulling to add."]){
    [self awakeFromNib];
    self.textLabel.text=@"Keep pulling to add or release to stop";
    self.iconImageView.image = [UIImage imageNamed:@"50-plus"];
    self.countLabel.text = @"1";
    }
}

@end
