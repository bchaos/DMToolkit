//
//  textfieldWithEdgeInset.m
//  DMToolKit
//
//  Created by Bradford Farmer on 5/3/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "textfieldWithEdgeInset.h"

@implementation textfieldWithEdgeInset

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 6, 6);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 6, 6);
}

@end
