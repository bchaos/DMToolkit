//
//  borderedTextView.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/24/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "borderedTextView.h"

@implementation borderedTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    self.layer.borderWidth=1.5;
}


@end
