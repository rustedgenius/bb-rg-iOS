//
//  APWCreateAccountTVController.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright 2011 RustedGenius. All rights reserved.
//

#import "BBAddressProfileController.h"
#import "BBProfileCustomTableCell.h"
#import <QuartzCore/QuartzCore.h>

@interface BBAddressProfileController(private)
- (BOOL) validateEmail: (NSString *) candidate;
- (void) MoveTablePositionUp;
@end

@implementation BBAddressProfileController


@synthesize addressProfileTableView = _addressProfileTableView, addressTextField = _addressTextField, countryTextField = _countryTextField, stateTextField = _stateTextField, cityTextField = _cityTextField, zipTextField = _zipTextField,keyboardToolbar,nextPreviousControl, createAccountButtonIndexPath = _createAccountButtonIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self.navigationController customizeNavigationBarForViewController:self withLeftButtonName:kBackButtonTitle leftButtonImageName:nil leftButtonSelector:nil withRightButtonName:nil rightButtonImageName:nil rightButtonSelector:nil withTitle:@"Create Account" titleBarImageName:nil];
    
    //set up the view.
    UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    backView.backgroundColor = [UIColor clearColor];
    //    [self tableView].backgroundView = backView;
    //    [self.tableView setBackgroundView:_greybackgroundImageView];
    //    [self.view sendSubviewToBack:_greybackgroundImageView];
    
    _isRequiredErrorMsgInHeader = NO;
    _isValidEmail = YES;
    _isPasswordEntryEqual = YES;
    
    //Add observer for the textDidChange notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    _singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
	[_singleTap setNumberOfTapsRequired:1];
    _singleTap.cancelsTouchesInView = NO;
	[self.view addGestureRecognizer:_singleTap];
    
    //Notifications to track the keyboard.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear
{
    if (keyboardToolbar != nil)
    {
        keyboardToolbar.hidden = YES;
    }
    self.hidesBottomBarWhenPushed = NO;
    [_hideKeyboardButton removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self trackUserActionForCreateAccount];
}

//#pragma mark - Omniture Track
//- (void) trackUserActionForCreateAccount
//{
//    if(_delegate)
//    {
//        [[OmnitureAppMeasurement getAPWOmnitureSingleInstance] appMeasurementDetails:kAPWPageNameCreateAccount  channalName:kAPWChannelNameLoginRegisterForCheckout pageType:kAPWPageTypeCheckOut defaultVehicle:[[APWMyGarageVehiclesManager singleInstance]getDefaultVehicle]];
//    }
//    else
//    {
//        [[OmnitureAppMeasurement getAPWOmnitureSingleInstance] appMeasurementDetails:kAPWPageNameCreateAccount  channalName:kAPWChannelNameCreateAccount pageType:kAPWPageTypeCreateAccount defaultVehicle:[[APWMyGarageVehiclesManager singleInstance]getDefaultVehicle]];
//    }
//}

/*!
 @function leftButtonAction
 @abstract Returns to the previous screen.
 @discussion Returns to the previous screen.
 @param none
 @result none
 */

- (IBAction)onClickSkipButton:(id)sender {
}

- (IBAction)onClickUseLocationButton:(id)sender {
}

-(void) leftButtonAction:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma -
#pragma delegates implmentaion

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.textColor=UIColorFromRGB(0x707070);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //Hide the keyboard.
    [_hideKeyboardButton removeFromSuperview];
    [textField resignFirstResponder];
    return NO;
}

/*!
 @function textDidChange
 @abstract Changes the state of the create account button.
 @discussion Changes the state of the create account button according to the state of the textfields.
 @param notification
 @result none
 */

-(void)textDidChange:(NSNotification *) notification
{    
    //Change the state of the create account button.
    if ((!([_cityTextField.text length] == 0)) && (!([_zipTextField.text length] >= 5)) && (!([_addressTextField.text length] == 0)) && (!([_countryTextField.text length] == 0)) && (!([_stateTextField.text length] == 0)))
    {
        // Activate save button
    }
    if ((([_cityTextField.text length] == 0)) && (([_zipTextField.text length] == 0)) && (([_addressTextField.text length] == 0)) && (([_countryTextField.text length] == 0)) && (([_stateTextField.text length] == 0)))
    {
        // Disable save button
    }
}

/*!
 @function hideKeyBoard
 @abstract Hides the keyboard.
 @discussion Hides the keyboard.
 @param none
 @result none
 */

-(void)hideKeyBoard
{
    //Hide keyboard.
    [_stateTextField resignFirstResponder];
    [_cityTextField resignFirstResponder];
    [_zipTextField resignFirstResponder];
    [_addressTextField resignFirstResponder];
    [_countryTextField resignFirstResponder];
}

/*!
 @function singleTapGestureCaptured
 @abstract Called when the screen is tapped once.
 @discussion Hides the keyboard.
 @param none
 @result none
 */

-(void)singleTapGestureCaptured:(UITapGestureRecognizer *)touch
{
    if (touch.view == _stateTextField)
    {
        return;
    }
    if (touch.view == _cityTextField)
    {
        return;
    }
    [self hideKeyBoard];
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL aBool = FALSE;
    if (textField == _zipTextField)
    {
        if(range.location<5 && [string length]<5)
        {
            aBool = TRUE;
        }
    }
    return aBool;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    BBProfileCustomTableCell* signInCell;
    //Configure the cell.
    signInCell = (BBProfileCustomTableCell*)[tableView dequeueReusableCellWithIdentifier:@"APWSignInCell"];
    if(signInCell  == nil)
    {
        signInCell = [[[BBProfileCustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"APWSignInCell"]autorelease ];
        signInCell.cellLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    }
    signInCell.isTableViewSignInTableView = YES;
    if(indexPath.row == 0)
    {
        signInCell.cellTextField.placeholder = @"Address";
        self.addressTextField = signInCell.cellTextField;
        _addressTextField.font = [UIFont systemFontOfSize:16.0];
        
    }
    else if(indexPath.row == 1)
    {
        signInCell.cellTextField.placeholder = @"Country";
        self.countryTextField = signInCell.cellTextField;
        _countryTextField.font = [UIFont systemFontOfSize:16.0];
    }
    else if(indexPath.row == 2)
    {
        signInCell.cellTextField.placeholder = @"State";
        self.stateTextField = signInCell.cellTextField;
        _stateTextField.font = [UIFont systemFontOfSize:16.0];
    }
    else if(indexPath.row == 3)
    {
        signInCell.cellTextField.placeholder = @"City";
        self.cityTextField = signInCell.cellTextField;
        _countryTextField.font = [UIFont systemFontOfSize:16.0];
    }
    else if(indexPath.row == 4)
    {
        signInCell.cellTextField.placeholder = @"ZipCode";
        self.zipTextField = signInCell.cellTextField;
        _stateTextField.font = [UIFont systemFontOfSize:16.0];
        self.zipTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    cell = signInCell;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 42;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if(indexPath.section == 2)
    //    {
    //        //Create account button press
    //        if([_cityTextField.text length] < 8)
    //        {
    //            //Check password.
    //            UIAlertView* alert = [[UIAlertView alloc ] initWithTitle:nil message:kPasswordsLength delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //            [alert show];
    //            [alert release];
    //            return;
    //        }
    //        //Validate all the entered data.
    //        _isValidEmail = [self validateEmail:_stateTextField.text];
    //        _isRequiredErrorMsgInHeader = !_isValidEmail;
    //        _isPasswordEntryEqual = [_cityTextField.text isEqualToString:_zipTextField.text];
    //        if(_isValidEmail && _isPasswordEntryEqual)
    //        {
    //            //If the data is valid..
    //            if(_progressHud == nil)
    //            {
    //                UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //                _progressHud = [[APWProgressHUD alloc] initWithWindow:window];
    //                [window addSubview:_progressHud];
    //                _progressHud.delegate = self;
    //            }
    //            else
    //            {
    //                [_progressHud hide:YES];
    //            }
    //            // Show the HUD while the provided method executes in a new thread
    //            [_progressHud show:YES];
    //            [_progressHud setLabelFont:[UIFont boldSystemFontOfSize:12.0]];
    //            _progressHud.labelText = kAPWProgessBarLoadingLabel;
    //
    //            //Send request to create a new account.
    //            _accountRequestHandler=[[APWAccountRequestHandler alloc] initWithRequestForCreatingAccount:self firstName:_addressTextField.text lastName:_countryTextField.text emailID:_stateTextField.text password:_cityTextField.text];
    //            [_accountRequestHandler submitRequestToServer];
    //            [addressProfileTableView reloadData];
    //        }
    //        else
    //        {
    //            if(!_isPasswordEntryEqual)
    //            {
    //                //Show alertview for password
    //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:kPasswordsMismatch delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //                [alert show];
    //                [alert release];
    //            }
    //            [addressProfileTableView reloadData];
    //        }
    //    }
}


- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    textField.text = @"";
    return YES;
}


#pragma mark -
#pragma mark Button Action Method

/*!
 @function keyboardWillShow
 @abstract Called when the keyboard appears.
 @discussion Adds another toolbar of next, previous and done button on the keyboard.
 @param notification object.
 @result none.
 */

- (void)keyboardWillShow:(NSNotification *)notification
{
    /******************************Code For Tool Bar of Next and Prev*******************************/
    CGPoint beginCentre = CGPointMake(160, 588);
	CGPoint endCentre = CGPointMake(160, [[UIScreen mainScreen] bounds].size.height - 108);
	CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
	if (nil == keyboardToolbar)
    {
		if(nil == keyboardToolbar)
        {
            //Create the toolbar.
			keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
			keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
			keyboardToolbar.tintColor = [UIColor darkGrayColor];
			
			UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
			UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
			
			UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous",@"Previous form field"),                                                                                     NSLocalizedString(@"Next",@"Next form field"),nil]];
            
			control.segmentedControlStyle = UISegmentedControlStyleBar;
			control.tintColor = [UIColor darkGrayColor];
			control.momentary = YES;
			[control addTarget:self action:@selector(nextPrevious:) forControlEvents:UIControlEventValueChanged];
			
			UIBarButtonItem *controlItem = [[UIBarButtonItem alloc] initWithCustomView:control];
			self.nextPreviousControl = control;
			NSArray *items = [[NSArray alloc] initWithObjects:controlItem, flex, barButtonItem, nil];
			[keyboardToolbar setItems:items];
			[control release];
			[barButtonItem release];
			[flex release];
			[items release];
			[controlItem release];
			keyboardToolbar.frame = CGRectMake(beginCentre.x - (keyboardBounds.size.width/2),
											   beginCentre.y - (keyboardBounds.size.height/2) - keyboardToolbar.frame.size.height,
											   keyboardToolbar.frame.size.width,
											   keyboardToolbar.frame.size.height);
			
			UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window addSubview:keyboardToolbar];
		}
	}
	
    //Animate the toolbar with the keyboard.
	[UIView beginAnimations:@"RS_showKeyboardAnimation" context:nil];
	[UIView setAnimationCurve:animationCurve];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0)
        [UIView setAnimationDuration:0.31];
	else
        [UIView setAnimationDuration:0.26];
	keyboardToolbar.alpha = 1.0;
	keyboardToolbar.frame = CGRectMake(endCentre.x - (keyboardBounds.size.width/2),
									   endCentre.y - (keyboardBounds.size.height/2) - keyboardToolbar.frame.size.height - self.view.frame.origin.y,
									   keyboardToolbar.frame.size.width,
									   keyboardToolbar.frame.size.height);
	
	[UIView commitAnimations];
	
	keyboardToolbarShouldHide = YES;
    //[self ]
    //[self performSelectorOnMainThread:@selector(MoveTablePositionUp) withObject:nil waitUntilDone:NO];
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    [self MoveTablePositionUp];
}
/*!
 @function MoveTablePositionUp
 @abstract Called when the first responder changes.
 @discussion Moves the first responder textfield to celter of the screen.
 @param nones.
 @result none.
 */

-(void) MoveTablePositionUp
{
	int position = 0;
    
    if ([self.addressTextField isFirstResponder])
        position= 0;
    else if ([self.countryTextField isFirstResponder])
        position= 1;
    else if ([self.stateTextField isFirstResponder])
        position= 2;
    else if ([self.cityTextField isFirstResponder])
        position= 3;
    else if ([self.zipTextField isFirstResponder])
        position= 4;
    else
        return;
    CGPoint point;
    
    switch (0) {
        case 0:
        {
            point= CGPointMake(0, 10 + 44*position);
        }
            break;
        default:
            break;
    }
    
    [self.addressProfileTableView setContentOffset:point animated:YES];
    [self.addressProfileTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

/**************************Key board Hide Notification***********************/

/*!
 @function keyboardWillHide
 @abstract Called when the keyboard dissappears.
 @discussion Removes the toolbar of next, previous and done button.
 @param notification object.
 @result none.
 */

- (void)keyboardWillHide:(NSNotification *)notification
{
	if (nil == keyboardToolbar || !keyboardToolbarShouldHide)
    {
		return;
	}
    //Hide the toolbar.
	keyboardToolbar.alpha = 0.0;
	CGPoint endCentre = CGPointMake(160, 588);
	CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
	NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	
	[UIView beginAnimations:@"RS_hideKeyboardAnimation" context:nil];
	[UIView setAnimationCurve:animationCurve];
	[UIView setAnimationDuration:animationDuration];
    
	keyboardToolbar.frame = CGRectMake(endCentre.x - (keyboardBounds.size.width/2),
									   endCentre.y - (keyboardBounds.size.height/2) - keyboardToolbar.frame.size.height,
									   keyboardToolbar.frame.size.width,
									   keyboardToolbar.frame.size.height);
	
	[UIView commitAnimations];
}

/***************************Tool bar Next and Prev Method***********************************/

/*!
 @function nextPrevious
 @abstract Called when the next previous segment is clicked.
 @discussion Changes the first responder textfield..
 @param sender.
 @result none.
 */

- (IBAction)nextPrevious:(id)sender
{
	int position = 0;
    int sectionNum = 0;
    
    switch([(UISegmentedControl *)sender selectedSegmentIndex])
    {
		case 0:
            //Previous button clicked.
			if ([self.addressTextField isFirstResponder])
            {
                [self dismissKeyboard:nil];
                return;
			}
            else if ([self.countryTextField isFirstResponder])
            {
                position= 0;
                [self.addressTextField becomeFirstResponder];
			}
            else if ([self.stateTextField isFirstResponder])
            {
                position= 1;
                [self.countryTextField becomeFirstResponder];
            }
            else if ([self.cityTextField isFirstResponder])
            {
                position= 2;
                [self.stateTextField becomeFirstResponder];
            }
            else if ([self.zipTextField isFirstResponder])
            {
                position= 3;
                [self.cityTextField becomeFirstResponder];
            }
            
			break;
		case 1:
			//Next button clicked.
			if ([self.addressTextField isFirstResponder])
            {
                position= 1;
                [self.countryTextField becomeFirstResponder];
			}
            else if ([self.countryTextField isFirstResponder])
            {
                position= 2;
                [self.stateTextField becomeFirstResponder];
			}
            else if ([self.stateTextField isFirstResponder])
            {
                position= 3;
                [self.cityTextField becomeFirstResponder];
            }
            else if ([self.cityTextField isFirstResponder])
            {
                position= 4;
                [self.zipTextField becomeFirstResponder];
            }
            else if ([self.zipTextField isFirstResponder])
            {
                [self dismissKeyboard:nil];
                return;
            }break;
	}
    //Focus the first responder textfield.
    
    [self.addressProfileTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:sectionNum] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

/*!
 @function dismissKeyboard
 @abstract Called when the done button is clicked.
 @discussion Hisdes the keyboard.
 @param sender.
 @result none.
 */

- (IBAction)dismissKeyboard:(id)sender
{
    if (keyboardToolbar) {
        [keyboardToolbar removeFromSuperview];
        keyboardToolbar = nil;
    }

    if ([self.addressTextField isFirstResponder]) {
        [self.addressTextField resignFirstResponder];
    }
    if ([self.countryTextField isFirstResponder]) {
        [self.countryTextField resignFirstResponder];
    }
    if ([self.stateTextField isFirstResponder]) {
        [self.stateTextField resignFirstResponder];
    }
    if ([self.cityTextField isFirstResponder]) {
        [self.cityTextField resignFirstResponder];
    }
    if ([self.zipTextField isFirstResponder]) {
        [self.zipTextField resignFirstResponder];
    }
}


- (void)viewDidUnload
{
    [saveAddressButton release];
    saveAddressButton = nil;
    [skipButton release];
    skipButton = nil;
    [useLocationButton release];
    useLocationButton = nil;
    [super viewDidUnload];
    self.addressProfileTableView = nil;
    self.addressTextField = nil;
    self.countryTextField = nil;
    self.stateTextField = nil;
    self.cityTextField = nil;
    self.zipTextField = nil;
}


- (void)dealloc
{
    if (_hideKeyboardButton)
    {
        [_hideKeyboardButton release];
    }
    [nextPreviousControl release];
    [keyboardToolbar release];
    [_singleTap release];
    [_addressTextField release];
    [_countryTextField release];
    [_stateTextField release];
    [_cityTextField release];
    [_zipTextField release];
    [_addressProfileTableView release];
    [_createAccountButtonIndexPath release];
    [saveAddressButton release];
    [skipButton release];
    [useLocationButton release];
    [super dealloc];
}

- (IBAction)onClickSaveAddressButton:(id)sender {
    
}

#pragma mark Request Response delegate
- (void)parseComplete:(NSError*)error handler:(RequestResponseBase*)currenthandler;
{
    
}
@end
