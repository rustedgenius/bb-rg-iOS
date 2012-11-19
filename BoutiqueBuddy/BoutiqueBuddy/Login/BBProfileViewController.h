//
//  BBProfileViewController.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBProfileCustomTableCell.h"


@interface BBProfileViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    IBOutlet UIToolbar *keyboardToolbar; //UIToolbar above the keyboard.
    UISegmentedControl *nextPreviousControl;
    BOOL keyboardToolbarShouldHide;
    
    UITextField * _iAmTextField;
    UITextField * _nameTextField;
    UITextField * _bodyTypeTextField;
    UITextField * _heightTextField;
    UITextField * _shoeSizeUSTextField;
    UITextField * _shoeSizeUKTextField;
}

@property (nonatomic, retain) UITextField * iAmTextField;
@property (nonatomic, retain) UITextField * nameTextField;
@property (nonatomic, retain) UITextField * bodyTypeTextField;
@property (nonatomic, retain) UITextField * heightTextField;
@property (nonatomic, retain) UITextField * shoeSizeUSTextField;
@property (nonatomic, retain) UITextField * shoeSizeUKTextField;

@property (nonatomic, retain) UISegmentedControl *nextPreviousControl;
@property (nonatomic, retain) UIToolbar *keyboardToolbar;
@property (retain, nonatomic) IBOutlet UITableView *profileTableView;
@property (retain, nonatomic) IBOutlet UIButton *skipButton;
@property (retain, nonatomic) IBOutlet UIButton *setAddressButton;


- (IBAction)onClickSkipButton:(id)sender;
- (IBAction)onClickSetAddressButton:(id)sender;

@end
