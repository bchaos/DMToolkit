//
//  fontsAndColourConstants.m
//  Ethicon Sugerical Care Master
//
//  Created by Bradford Farmer on 12/11/12.
//  Copyright (c) 2012 Bradford Farmer. All rights reserved.
//

#import "fontsAndColourConstants.h"

@implementation fontsAndColourConstants

+(UIColor *)EthiconCoolGray8{
    return [UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:1.0f];
}

+(UIColor *)EthiconCoolGray11{
        return [UIColor colorWithRed:113.0f/255.0f green:112.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
}

+(UIColor*)EthiconCoolGray2{
        return [UIColor colorWithRed:231.0f/255.0f green:232.0f/255.0f blue:233.0f/255.0f alpha:1.0f];
}

+(UIColor*)EthiconRed{
    return [UIColor colorWithRed:238.0f/255.0f green:58.0f/255.0f blue:67.0f/255.0f alpha:1.0f];
}

+(UIColor*)EthiconDarkRed{
    return [UIColor colorWithRed:(175.0f/255.0) green:(39.0f/255.0) blue:(47.0f/255.0) alpha:1];
}

+(UIColor*)MentorBlueGray{
    return [UIColor colorWithRed:(204.0f/255.0) green:(219.0f/255.0) blue:(232.0f/255.0) alpha:1];
}
+(UIColor*)EthiconOrange{
    return [UIColor colorWithRed:(255.0f/255.0) green:(183.0f/255.0) blue:(24.0f/255.0) alpha:1];
}

+(UIFont *)ApexBook:(int)size{
    return [UIFont fontWithName:@"ApexSans-Book" size:size];
}

+(UIFont *)ApexMedium:(int)size{
 return [UIFont fontWithName:@"ApexSans-Medium" size:size];
}

+(UIFont *)ApexLight:(int)size{
    return [UIFont fontWithName:@"ApexSans-Light" size:size];
}

+(UIFont *)ApexBold:(int)size{
    return [UIFont fontWithName:@"ApexSans-Bold" size:size];
}

+(UIFont *)AwesomeFontWithSize:(int)size{
    return [UIFont fontWithName:@"FontAwesome" size:size];
}

+(UIFont *)DNDFont:(int)size{
    return [UIFont fontWithName:@"souvenir_gothic_becker_ant_demi" size:size];
}
+(UITableViewCell *)configureSubNavCell:(UITableViewCell *)cell{
    
    [cell.textLabel setTextColor:[self EthiconDarkRed]];
    cell.textLabel.backgroundColor=[UIColor whiteColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [self EthiconDarkRed];
    cell.selectedBackgroundView = selectionColor;
    return cell;
}

+(UITableViewCell *)configureSubNavCellWhite:(UITableViewCell *)cell{
   // [cell.textLabel setTextColor:[UIColor blackColor]];
  
    cell.textLabel.backgroundColor= [UIColor whiteColor];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = selectionColor;
    //selectionColor.backgroundColor = [UIColor blueColor];
   // cell.selectedBackgroundView= selectionColor;
    
    return cell;
}

+(UITableViewCell *)configureSubNavCellBlue:(UITableViewCell *)cell{
    [cell.textLabel setTextColor:[UIColor blackColor]];
    cell.backgroundColor= [self  MentorBlueGray];
    cell.textLabel.backgroundColor= [self  MentorBlueGray];
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [self  MentorBlueGray];
   
    cell.backgroundView = selectionColor;
    
    selectionColor.backgroundColor = [UIColor blueColor];
    cell.selectedBackgroundView= selectionColor;
    
    return cell;
}


@end
