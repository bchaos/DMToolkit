//
//  TextFieldCell.m
//  DMToolKit
//
//  Created by Bradford Farmer on 4/26/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import "TextFieldCell.h"
#import "fontsAndColourConstants.h"
@implementation TextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}
-(void)addSelectionButton{
   _selectionButton= [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width-70, 0, 70,  self.frame.size.height)];
    [_selectionButton addTarget:self action:@selector(sectionSelected) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_selectionButton];
}
-(void)addResignNotifier{
    [JE_ notifyObserver:self selector:@selector(resignResponder) name:@"resignFirstResponder"];
      
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTextFieldText:(NSString *)text{
    if(self.textField==nil){
       self.textField= [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width-70, self.frame.size.height)];
        [self addSubview:self.textField];
        self.textField.placeholder= @"New";
        self.textField.font=[fontsAndColourConstants ApexMedium:20];
        self.textField.tag=1001;
        self.textField.textColor=[UIColor whiteColor];
        [self.textField addTarget:self action:@selector(save) forControlEvents:UIControlEventEditingChanged ];
        [self.textField addTarget:self action:@selector(startedEditing) forControlEvents:UIControlEventEditingDidBegin];
       
    }
    self.textField.text=text;
    [self addSelectionButton];
    [self addResignNotifier];
    [self deselect];
    
}

-(void)select{
    [JE_ notifyObserver:self selector:@selector(deselect) name:@"deselect"];
    ( (UIImageView *)self.backgroundView).image=[UIImage imageNamed:@"bar_selected.png" ];
}
-(void)deselect{
     ( (UIImageView *)self.backgroundView).image=[UIImage imageNamed:@"bar.png" ];
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
@end
