//
//  BBProfileViewController.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBProfileCustomTableCell.h"


@interface BBProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar; //UIToolbar above the keyboard.
    UISegmentedControl *nextPreviousControl;
    BOOL keyboardToolbarShouldHide;  
}

@property (nonatomic, retain) UISegmentedControl *nextPreviousControl;
@property (nonatomic, retain) UIToolbar *keyboardToolbar;
@property (retain, nonatomic) IBOutlet UITableView *profileTableView;
@property (retain, nonatomic) IBOutlet UIButton *skipButton;
@property (retain, nonatomic) IBOutlet UIButton *setAddressButton;
- (IBAction)onClickSkipButton:(id)sender;
- (IBAction)onClickSetAddressButton:(id)sender;

@end
