//
//  fontsAndColourConstants.h
//  Ethicon Sugerical Care Master
//
//  Created by Bradford Farmer on 12/11/12.
//  Copyright (c) 2012 Bradford Farmer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface fontsAndColourConstants : NSObject
+(UIColor*)EthiconCoolGray2;
+(UIColor*)EthiconCoolGray8;
+(UIColor *)EthiconCoolGray11;
+(UIColor*)EthiconRed;
+(UIColor*)EthiconOrange;
+(UIColor*)EthiconDarkRed;
+(UIFont *)ApexBook:(int)size;
+(UIFont *)ApexMedium:(int)size;
+(UIFont *)ApexLight:(int)size;
+(UIFont *)ApexBold:(int)size;
+(UITableViewCell *)configureSubNavCell:(UITableViewCell *)cell;
+(UITableViewCell *)configureSubNavCellBlue:(UITableViewCell *)cell;
+(UITableViewCell *)configureSubNavCellWhite:(UITableViewCell *)cell;

@end
