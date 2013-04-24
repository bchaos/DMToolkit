//
//  tempSideCellView.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "tempSideCellView.h"
#import "fontsAndColourConstants.h"
@implementation tempSideCellView

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
    self.textLabel.font=[fontsAndColourConstants ApexMedium:20];
    self.textLabel.text=@"New";
    imageView.image = [UIImage imageNamed:@"bar.png"];
    self.backgroundView.frame = self.frame;
    self.backgroundView = imageView;
    self.textLabel.textColor=[UIColor whiteColor];
    self.textLabel.backgroundColor=[UIColor clearColor];
}


-(void)upateCellWithFrame :(CGRect)frame{
    self.frame=frame;
    self.alpha= self.frame.size.height/70.0f;
    [self addLabel];
}

@end
