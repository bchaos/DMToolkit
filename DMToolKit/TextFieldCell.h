//
//  TextFieldCell.h
//  DMToolKit
//
//  Created by Bradford Farmer on 4/26/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "textfieldWithEdgeInset.h"
@protocol textCellDelegate <NSObject>
-(void)save:(NSString *)name;
-(void)editingDidStart:(int)editingIndex;
-(void)sectionSelected:(int)selectionIndex resignResponder:(BOOL)resign;
@end
@interface TextFieldCell : UITableViewCell

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIButton *selectionButton;
-(void)setTextFieldText :(NSString *)text;
-(void)removeTextfieldFromCell;
-(void)select;
@property (nonatomic, assign) id <textCellDelegate> delegate;
@end
