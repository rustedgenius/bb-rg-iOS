//
//  BBProfileViewController.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBProfileViewController.h"
#import "BBAddressProfileController.h"

@interface BBProfileViewController ()
{
    NSMutableArray *arrayOfProfiles;
    int currentPosition;
}

@property(nonatomic, retain)NSMutableArray *arrayOfProfiles;

@end

@implementation BBProfileViewController

@synthesize arrayOfProfiles;
@synthesize nextPreviousControl;
@synthesize keyboardToolbar;
@synthesize profileTableView;
@synthesize skipButton;
@synthesize setAddressButton;

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
    // Do any additional setup after loading the view from its nib.
    
    self.arrayOfProfiles = [[NSMutableArray alloc] initWithObjects:@"I am",@"Name",@"Body Type",@"Height",@"Shoe Size US",@"Shoe Size UK", nil];
    
    //Notifications to track the keyboard.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewDidUnload
{
    [self setProfileTableView:nil];
    [self setSkipButton:nil];
    [self setSetAddressButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


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
//    UIView *responder = [self.view findFirstResponder];
//	int position = 0;
//    int sectionNum = 0;
//    if (responder == _reEnterPasswordTextField)
//    {
//        position= 1;
//        sectionNum = 1;
//    }
//    else if (responder == _passwordTextField)
//    {
//        position= 0;
//        sectionNum = 1;
//    }
//    else if (responder == _emailTextField)
//        position= 2;
//    else if (responder == _lastNameTextField)
//        position= 1;
//    else
//        return;
//    CGPoint point;
//    
//    switch (sectionNum) {
//        case 0:
//        {
//            point= CGPointMake(0, 10 + 44*position);
//        }
//            break;
//        case 1:
//        {
//            point= CGPointMake(0, 46*3 + 44*position);
//        }
//            break;
//        default:
//            break;
//    }
//    
//    
//    [_createAccountTableView setContentOffset:point animated:YES];
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
//	UIView *responder = [self.view findFirstResponder];
	//int position = 0;
    int sectionNum = 0;
    
    switch([(UISegmentedControl *)sender selectedSegmentIndex])
    {
		case 0:
            currentPosition = currentPosition -1;
            NSLog(@"PREV POS :: %d", currentPosition);
            //Previous button clicked.
//			if (responder == _firstNameTextField)
//            {
//                return;
//			}
//            else if (responder == _lastNameTextField)
//            {
//                sectionNum = 0;
//                position= 0;
//                [_firstNameTextField becomeFirstResponder];
//			}
//            else if (responder == _emailTextField)
//            {
//                sectionNum = 0;
//                position= 1;
//                [_lastNameTextField becomeFirstResponder];
//            }
//            else if (responder == _passwordTextField)
//            {
//                sectionNum = 0;
//                position= 2;
//                [_emailTextField becomeFirstResponder];
//            }
//            else if (responder == _reEnterPasswordTextField)
//            {
//                sectionNum = 1;
//                position= 0;
//                [_passwordTextField becomeFirstResponder];
//            }
            
			break;
		case 1:
			//Next button clicked.
                        currentPosition = currentPosition+1;
            NSLog(@"NEXT POS :: %d", currentPosition);
//			if (responder == _firstNameTextField)
//            {
//                sectionNum = 0;
//                position= 1;
//				[_lastNameTextField becomeFirstResponder];
//			}
//            else if (responder == _lastNameTextField)
//            {
//                sectionNum = 0;
//                position= 2;
//				[_emailTextField becomeFirstResponder];
//			}
//            else if (responder == _emailTextField)
//            {
//                sectionNum = 1;
//                position= 0;
//				[_passwordTextField becomeFirstResponder];
//			}
//            else if (responder == _passwordTextField)
//            {
//                sectionNum = 1;
//                position= 1;
//				[_reEnterPasswordTextField becomeFirstResponder];
//			}
//            else if (responder == _reEnterPasswordTextField)
//            {
//                [_reEnterPasswordTextField resignFirstResponder];
//                sectionNum = 1;
//                position = 1;
//            }
			break;
	}
    //Focus the first responder textfield.
    
    [self.profileTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentPosition inSection:sectionNum] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
    
//    if ([self.addressTextField isFirstResponder]) {
//        [self.addressTextField resignFirstResponder];
//    }
//    if ([self.countryTextField isFirstResponder]) {
//        [self.countryTextField resignFirstResponder];
//    }
//    if ([self.stateTextField isFirstResponder]) {
//        [self.stateTextField resignFirstResponder];
//    }
//    if ([self.cityTextField isFirstResponder]) {
//        [self.cityTextField resignFirstResponder];
//    }
//    if ([self.zipTextField isFirstResponder]) {
//        [self.zipTextField resignFirstResponder];
//    }
}


- (void)viewWillDisappear:(BOOL)animated{
    if (keyboardToolbar != nil)
    {
        keyboardToolbar.hidden = YES;
    }
    self.hidesBottomBarWhenPushed = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

#define kProfileCustomCellIdentifier @"profileCell"
#define kProfileCustomCellXibIphone @"BBProfileCustomTableCell_iPhone"
#define kProfileCustomCellXibIPad   @"BBProfileCustomTableCell_iPad"
#define kTapStateImage @""


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrayOfProfiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBProfileCustomTableCell *cell = (BBProfileCustomTableCell *)[tableView dequeueReusableCellWithIdentifier:kProfileCustomCellIdentifier];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iPhone 3.2 or later.
        // set up the iPad-specific view

        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kProfileCustomCellXibIPad owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            UIImageView * selecteBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kTapStateImage]];
            cell.selectedBackgroundView = selecteBG;
            [selecteBG release];
        }
    }
    else {
        // The device is an iPhone or iPod touch.
        // set up the iPhone/iPod Touch view
        if(cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kProfileCustomCellXibIphone owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
            UIImageView * selecteBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kTapStateImage]];
            cell.selectedBackgroundView = selecteBG;
            [selecteBG release];
        }
    }
    cell.cellTextField.placeholder = @"TESTING";
    return cell;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc{
    [nextPreviousControl release];
    [keyboardToolbar release];
    [arrayOfProfiles release];
    [profileTableView release];

    [skipButton release];
    [setAddressButton release];
    [super dealloc];
}

- (IBAction)onClickSkipButton:(id)sender {

}

#define kBBAddressProfileControlleriPhone @"BBAddressProfileController_iPhone"
#define kBBAddressProfileControlleriPad   @"BBAddressProfileController_iPad"

- (IBAction)onClickSetAddressButton:(id)sender {
    BBAddressProfileController*addressProfileController = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iPhone 3.2 or later.
        // set up the iPad-specific view
        addressProfileController = [[BBAddressProfileController alloc] initWithNibName:kBBAddressProfileControlleriPad bundle:[NSBundle mainBundle]];
    }
    else {
        // The device is an iPhone or iPod touch.
        // set up the iPhone/iPod Touch view
        addressProfileController = [[BBAddressProfileController alloc] initWithNibName:kBBAddressProfileControlleriPhone bundle:[NSBundle mainBundle]];
    }
    
    [self.navigationController pushViewController:addressProfileController animated:YES];
    [addressProfileController release];
}



@end
