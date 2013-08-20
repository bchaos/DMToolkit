//
//  SidebarController1.m
//  ADVFlatUI
//
//  Created by Tope on 05/06/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//

#import "SidebarController1.h"
#import "fontsAndColourConstants.h"
#import <QuartzCore/QuartzCore.h>

@interface SidebarController1 (){
      NSString * actionFunction;
}

@property (nonatomic, strong) NSArray* items;

@end
static NSString *const kKeychainItemName = @"Google Drive Quickstart";
static NSString *const kClientID = @"438117934368-6lbqvsfggi8892vcscmeec28cm974k12.apps.googleusercontent.com";
static NSString *const kClientSecret = @"88d5A5wJUtWa7zp9TTxQaYyh";

@implementation SidebarController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.editableTextField.delegate=self;
    self.editableTextField.returnKeyType=UIReturnKeyDone;
    self.selectionTable.dataSource = self;
    self.selectionTable.delegate = self;
    
    self.view.backgroundColor = [fontsAndColourConstants MentorBlueGray];
    self.selectionTable.backgroundColor = [fontsAndColourConstants MentorBlueGray];
    self.selectionTable.separatorColor = [UIColor clearColor];
    
    NSString* boldFontName = @"Avenir-Black";
    NSString* fontName = @"Avenir-BlackOblique";
    
    self.profileNameLabel.textColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    self.profileNameLabel.font = [UIFont fontWithName:boldFontName size:14.0f];
    self.profileNameLabel.text = @"Lena Llellywyngot";
    
    self.profileLocationLabel.textColor = [UIColor colorWithRed:222.0/255 green:59.0/255 blue:47.0/255 alpha:1.0f];
    self.profileLocationLabel.font = [UIFont fontWithName:fontName size:12.0f];
    self.profileLocationLabel.text = @"London, UK";
    
    self.profileImageView.image = [UIImage imageNamed:@"profile.jpg"];
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 4.0f;
    self.profileImageView.layer.borderColor = [UIColor colorWithWhite:1.0f alpha:0.5f].CGColor;
    self.profileImageView.layer.cornerRadius = 35.0f;

	
}

- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *CellIdentifier = @"SidebarCell1";
    
    SidebarCell1* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Create cell
    if (cell == nil)
    {
        cell = [[SidebarCell1 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell clearsContextBeforeDrawing];
    
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    if(![self atMainMenu] && ![self atReferenceMenu]){
        NSManagedObject*item = self.SelectionFields[indexPath.row];
        cell.titleLabel.text=[item valueForKey:@"name"];
        cell.iconImageView.image=nil;
        cell.countLabel.alpha = 0;
        UILongPressGestureRecognizer * press= [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(editCell:)];
        [cell addGestureRecognizer:press];
        
    }else{
        cell.countLabel.alpha = 1;
        NSDictionary* item = self.SelectionFields[indexPath.row];
        cell.titleLabel.text = item[@"name"];
        cell.iconImageView.image = [UIImage imageNamed:item[@"icon"]];
        NSNumber* count = item[@"count"];
        cell.countLabel.text = [count stringValue];
      
    }
   

    cell.tag= indexPath.row;
    
    return cell;
}



- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
    int index=self.selectedCellIndex;
    
    [self openObjectAtIndex: index];
   
    [aTextfield resignFirstResponder];
    
    return YES;
}

- (IBAction)addNew:(UIPanGestureRecognizer *)sender {
    UITableViewCell * topCell;
    NSArray * visibleCells=[self.selectionTable visibleCells];
    if(visibleCells.count > 0) topCell = [visibleCells objectAtIndex:0];
    else {
        topCell= [[UITableViewCell alloc]init];
        topCell.tag=0;
    }
    
    if(self.newObjectAdded && self.isEditing){
        [self textFieldDidEndEditing: self.editableTextField];
    }
    [self.searchField resignFirstResponder];
    if(![self atMainMenu] && ![self atReferenceMenu]&&  topCell.tag ==0){
        if (self.tempCelliphone==nil){
    
                self.tempCelliphone = [[SidebarCell1 alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SidebarCell1"];
            

            self.tempCelliphone.frame =CGRectMake(0, 93, self.selectionTable.frame.size.width, 0);
            self.tempCelliphone.alpha=1.0;
            [self.view addSubview:self.tempCelliphone];
             self.tempCelliphone.textLabel.textColor=[UIColor whiteColor];
        }
        
        switch (sender.state) {
            case UIGestureRecognizerStateBegan:
                self.newObjectAdded=NO;
                [self.tempCelliphone upateCellWithFrame:CGRectMake(0, 93,  self.selectionTable.frame.size.width, [sender translationInView:self.selectionTable].y/2)];
                break;
            case UIGestureRecognizerStateChanged:
                if ( [sender translationInView:self.selectionTable].y /2> 0 && [sender translationInView:self.selectionTable].y/2 <  46 && !self.newObjectAdded){
                    [self.tempCelliphone upateCellWithFrame:CGRectMake(0, 93,  self.selectionTable.frame.size.width, [sender translationInView:self.selectionTable].y/2)];
                }
                else if ([sender translationInView:self.selectionTable].y/2 >  46 && !self.newObjectAdded ){
                    [self createNewObjectBasedOnCurrentmenu];
                    self.newObjectAdded=YES;
                    self.tempCelliphone.alpha=0.0;
                    [self.selectionTable reloadData];
                    
                    [UIView animateWithDuration:.3
                                          delay: 0.0
                                        options: UIViewAnimationOptionAllowUserInteraction
                                     animations:^{
                                         self.PulldownToAddLabel.alpha=0.0;
                                     }
                                     completion:^(BOOL finished){
                                         
                                     }];
                    
                    
                }
                else{
                    self.tempCelliphone.alpha=0.0;
                }
                
                break;
            case UIGestureRecognizerStateEnded:
                
                [self.tempCelliphone upateCellWithFrame:CGRectMake(0, 93,  self.selectionTable.frame.size.width, [sender translationInView:self.selectionTable].y/2)];
                [self.tempCelliphone removeFromSuperview];
                self.tempCelliphone=nil;
                if(self.newObjectAdded){
                    if(actionFunction !=nil){
                        [JE_ notifyName:actionFunction object:nil];
                    }
                    
                    self.selectedCellIndex=0;
                    if(![self atNoteMenu]) [self startEditing:self.editableTextField];
                    self.isEditing=true;
                    
                    
                    
                }
                break;
            default:
                break;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
