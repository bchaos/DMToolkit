//
//  FeatAndSkillsCell.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "FeatAndSkillsCell.h"
#import "fontsAndColourConstants.h"
@implementation FeatAndSkillsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addLabel];
    }
    return self;
}

-(void)addLabel{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
    self.textLabel.font=[fontsAndColourConstants ApexBook:14];
    self.textLabel.text=@"New";
    imageView.image = [UIImage imageNamed:@"FeatsAndSkills.png"];
    self.backgroundView.frame = self.frame;
    self.backgroundView = imageView;
    self.textLabel.textColor=[UIColor whiteColor];
    self.textLabel.backgroundColor=[UIColor clearColor];
}


-(void)upateCellWithFrame :(CGRect)frame{
    self.frame=frame;
    self.alpha= self.frame.size.height/50.0f;
   // [self addLabel];
}


@end
