//
//  PCButtonStack.m
//  WoundClosure
//
//  Created by Joshua Kaden on 2/27/12.
//  Copyright (c) 2012 Propeller Communications. All rights reserved.
//

#import "PCButtonStack.h"

#import <QuartzCore/QuartzCore.h>


@interface PCButtonStack ()

@property (strong, nonatomic) NSMutableArray *buttons;
@property (assign, nonatomic) CGPoint nextOrigin;

- (void)resizeFrame;

@end


@implementation PCButtonStack

@synthesize isHorizontal = m_isHorizontal;
@synthesize buttons = m_buttons;
@synthesize nextOrigin = m_nextOrigin;
@synthesize gutter = m_gutter;
@synthesize borderColor = m_borderColor;


//------------------------------------------------------------------------------
- (void)addButton:(UIView *)button {
    
    if (!self.buttons) {
        NSMutableArray *buttons = [[NSMutableArray alloc] init];
        self.buttons = buttons;
   
        
        self.nextOrigin = CGPointMake(0.0f, 0.0f);
    }
    
    CGRect frame = button.frame;
    frame.origin.x = self.nextOrigin.x;
    frame.origin.y = self.nextOrigin.y;
    button.frame = frame;
    
    if (self.isHorizontal) {
        self.nextOrigin = CGPointMake(self.nextOrigin.x + button.frame.size.width + self.gutter, self.nextOrigin.y);
    }
    else {
        self.nextOrigin = CGPointMake(self.nextOrigin.x, self.nextOrigin.y + button.frame.size.height + self.gutter);
    }
    
    if (self.borderColor) {
        button.layer.borderColor = [self.borderColor CGColor];
        button.layer.borderWidth = 1.0f;
    }
    
    [self.buttons addObject:button];
    [self resizeFrame];
    [self addSubview:button];
}

//------------------------------------------------------------------------------
- (void)resizeFrame {
    
    CGSize maxSize = CGSizeMake(0.0f, 0.0f);
    
    for (UIButton *button in self.buttons) {
        
        CGSize buttonSize = button.frame.size;
        
        if (self.isHorizontal) {
            
            maxSize.width += buttonSize.width + self.gutter;
            if (maxSize.height < buttonSize.height) {
                maxSize.height = buttonSize.height;
            }
        }
        else {
            
            maxSize.height += buttonSize.height + self.gutter;
            if (maxSize.width < buttonSize.width) {
                maxSize.width = buttonSize.width;
            }
        }
    }
    
    CGPoint origin = self.frame.origin;
    self.frame = CGRectMake(origin.x, origin.y, maxSize.width, maxSize.height);
}
//------------------------------------------------------------------------------
-(void)removeAllButtons{
    for (UIView * button in self.buttons){
        [button removeFromSuperview];
        
    }
    self.buttons=nil;
}


@end
