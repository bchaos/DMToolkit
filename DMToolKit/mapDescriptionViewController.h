//
//  mapDescriptionViewController.h
//  DMToolKit
//
//  Created by Bradford Farmer on 5/29/13.
//  Copyright (c) 2013 Bradford Farmer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol mapDescriptionDelegate <NSObject>
-(void)done;
-(void)go:(NSString *)fileName;
-(void)newGrid:(NSDictionary *)newGrid;
@end
@interface mapDescriptionViewController : UIViewController<UIWebViewDelegate>
- (IBAction)done:(id)sender;
- (IBAction)view:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *viewButton;
@property (nonatomic, assign) id <mapDescriptionDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary * gridInfo;
@property (strong, nonatomic) IBOutlet UIWebView *noteView;
@property (nonatomic, strong) NSString * filename;
@property (nonatomic, assign) BOOL hasViewButton;
@end
