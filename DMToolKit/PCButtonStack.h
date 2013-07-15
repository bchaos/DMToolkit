//
//  PCButtonStack.h
//  WoundClosure
//
//  Created by Joshua Kaden on 2/27/12.
//  Copyright (c) 2012 Propeller Communications. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCButtonStack : UIView

@property (assign, nonatomic) BOOL isHorizontal;
@property (assign, nonatomic) float gutter;
@property (strong, nonatomic) UIColor *borderColor;

- (void)addButton:(UIView *)button;
-(void)removeAllButtons;
@end
