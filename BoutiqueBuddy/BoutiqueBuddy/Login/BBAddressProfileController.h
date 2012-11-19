//
//  APWCreateAccountTVController.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright 2011 RustedGenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestResponseBase.h"

/*!
 @class APWCreateAccountTVController
 @abstract Table view controller for the create a new account form.
 @discussion Table view controller for the create a new account form.
 */

@interface BBAddressProfileController : UIViewController<UITextFieldDelegate, RequestResponseBaseDelegate> {
    UITableView* _addressProfileTableView;                                        //Table view for the create a new account form.
    UITextField* _cityTextField;                                                //UITextField to enter the password.
    UITextField* _zipTextField;                                                 //UITextField to re-enter the password.
    UITextField* _addressTextField;                                             //UITextField to enter the first name.
    UITextField* _countryTextField;                                             //UITextField to enter the last name.
    UITextField* _stateTextField;                                               //UITextField to enter the email.
    BOOL _isRequiredErrorMsgInHeader;                                           //Bool to show or hide the error message.
    BOOL _isValidEmail;                                                         //Bool to validate the email id.
    BOOL _isPasswordEntryEqual;                                                 //Bool to validate the passwords.
    
    NSIndexPath *_createAccountButtonIndexPath;                                //IndexPath of the create account button.
    BOOL _navigationFromCart;                                                  //Bool to verify if the navigation is from cart page.
    UIButton *_hideKeyboardButton;                                             //Button to hide the keyboard.
    UITapGestureRecognizer *_singleTap;                                        //GestureRecognizer to capture a single tap.
    
    /****************tool bar for prev and next*************/
    
    IBOutlet UIToolbar *keyboardToolbar;                                       //UIToolbar above the keyboard.
    UISegmentedControl *nextPreviousControl;                                   //UISegmentedControl for next and previous button.
    BOOL keyboardToolbarShouldHide;                                            //Bool to hide the keyboard.
    
    IBOutlet UIButton *useLocationButton;
    IBOutlet UIButton *skipButton;
    IBOutlet UIButton *saveAddressButton;
    /*****************************************************/
}

@property(nonatomic, retain)IBOutlet UITableView* addressProfileTableView;
@property(nonatomic, retain)UITextField* cityTextField;
@property(nonatomic, retain)UITextField* zipTextField;
@property(nonatomic, retain)UITextField* addressTextField;
@property(nonatomic, retain)UITextField* countryTextField;
@property(nonatomic, retain)UITextField* stateTextField;
@property(nonatomic, copy)NSIndexPath *createAccountButtonIndexPath;
@property(nonatomic, retain)UISegmentedControl *nextPreviousControl;
@property(nonatomic, retain)UIToolbar *keyboardToolbar;

- (IBAction)onClickSkipButton:(id)sender;
- (IBAction)onClickUseLocationButton:(id)sender;
- (void) leftButtonAction:(id) sender;               //Method to cancel the requests andreturn to the previous screen.
- (IBAction)dismissKeyboard:(id)sender;              //Method to hide the keyboard.
- (IBAction)onClickSaveAddressButton:(id)sender;

@end
