//
//  BBProfileViewController.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBProfileViewController.h"
#import "BBAddressProfileCustomCell.h"
#import "BBAddressProfileController.h"
#import "Utililty.h"
#import	<QuartzCore/QuartzCore.h>

@interface BBProfileViewController ()
{
    NSMutableArray *arrayOfProfiles;
    int currentPosition;
}

- (void)drawLayerAroundView;

@property(nonatomic, retain)NSMutableArray *arrayOfProfiles;

@end

@implementation BBProfileViewController

@synthesize arrayOfProfiles;
@synthesize nextPreviousControl;
@synthesize keyboardToolbar;
@synthesize profileTableView;
@synthesize skipButton;
@synthesize setAddressButton;


@synthesize iAmTextField=_iAmTextField;
@synthesize nameTextField=_nameTextField;
@synthesize bodyTypeTextField=_bodyTypeTextField;
@synthesize heightTextField=_heightTextField;
@synthesize shoeSizeUSTextField=_shoeSizeUSTextField;
@synthesize shoeSizeUKTextField=_shoeSizeUKTextField;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)drawLayerAroundView
{
    CALayer * layer     = self.profileTableView.layer;
    layer.cornerRadius  = 8.0f;
    layer.masksToBounds = TRUE;
    layer.borderWidth   = 1.0f;
    layer.borderColor   = [UIColor darkGrayColor].CGColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self drawLayerAroundView];
    self.arrayOfProfiles = [[NSMutableArray alloc] initWithObjects:@"I am",@"Name",@"Body Type",@"Height",@"Shoe Size US",@"Shoe Size UK", nil];
    
    //Add observer for the textDidChange notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
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
    CGRect keyboardBounds = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    CGPoint beginCentre = CGPointMake(self.view.bounds.size.width/2, (self.view.bounds.size.height/2)+500);
	CGPoint endCentre = CGPointMake(self.view.bounds.size.width/2, [[UIScreen mainScreen] bounds].size.height - keyboardBounds.size.height/2);
    //keyboardBounds.size.height

	if (nil == keyboardToolbar)
    {
		if(nil == keyboardToolbar)
        {
            //Create the toolbar.
			keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width,44)];
            NSLog(@"Keyboard Toolbar Frame :: %@", keyboardToolbar);
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
 @function textDidChange
 @abstract Changes the state of the create account button.
 @discussion Changes the state of the create account button according to the state of the textfields.
 @param notification
 @result none
 */

-(void)textDidChange:(NSNotification *) notification
{
    //Change the state of the create account button.
    if ((!([self.iAmTextField.text length] == 0)) && (!([self.nameTextField.text length] >= 5)) && (!([self.heightTextField.text length] == 0)) && (!([self.shoeSizeUSTextField.text length] == 0)) && (!([self.shoeSizeUKTextField.text length] == 0)))
    {
        // Activate save button
    }
    else{
        //Deactivate the button
    }
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
    
    if ([self.iAmTextField isFirstResponder])
        position= 0;
    else if ([self.nameTextField isFirstResponder])
        position= 1;
    else if ([self.bodyTypeTextField isFirstResponder])
        position= 2;
    else if ([self.heightTextField isFirstResponder])
        position= 3;
    else if ([self.shoeSizeUSTextField isFirstResponder])
        position= 4;
    else if ([self.shoeSizeUKTextField  isFirstResponder])
        position= 5;
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
    
    [self.profileTableView setContentOffset:point animated:YES];
    [self.profileTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
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
    int sectionNum = 0;
    
    switch([(UISegmentedControl *)sender selectedSegmentIndex])
    {
		case 0:
            //Previous button clicked.
			if ([self.iAmTextField isFirstResponder])
            {
                [self dismissKeyboard:nil];
                return;
			}
            else if ([self.nameTextField isFirstResponder])
            {
                sectionNum = 0;
                [self.iAmTextField becomeFirstResponder];
			}
            else if ([self.bodyTypeTextField isFirstResponder])
            {
                sectionNum = 1;
                [self.nameTextField becomeFirstResponder];
            }
            else if ([self.heightTextField isFirstResponder])
            {
                sectionNum = 2;
                [self.bodyTypeTextField becomeFirstResponder];
            }
            else if ([self.shoeSizeUSTextField isFirstResponder])
            {
                sectionNum = 3;
                [self.heightTextField becomeFirstResponder];
            }
            else if ([self.shoeSizeUKTextField isFirstResponder])
            {
                sectionNum = 4;
                [self.shoeSizeUSTextField becomeFirstResponder];
            }
			break;
		case 1:
			//Next button clicked.
			if ([self.iAmTextField isFirstResponder])
            {
                [self.nameTextField becomeFirstResponder];
                return;
			}
            else if ([self.nameTextField isFirstResponder])
            {
                sectionNum = 0;
                [self.bodyTypeTextField becomeFirstResponder];
			}
            else if ([self.bodyTypeTextField isFirstResponder])
            {
                sectionNum = 1;
                [self.heightTextField becomeFirstResponder];
            }
            else if ([self.heightTextField isFirstResponder])
            {
                sectionNum = 2;
                [self.shoeSizeUSTextField becomeFirstResponder];
            }
            else if ([self.shoeSizeUSTextField isFirstResponder])
            {
                sectionNum = 3;
                [self.shoeSizeUKTextField becomeFirstResponder];
            }
            else if ([self.shoeSizeUKTextField isFirstResponder])
            {
                sectionNum = 4;
                [self dismissKeyboard:nil];
            }
			break;
	}
    //Focus the first responder textfield.
    [self.profileTableView setContentInset:UIEdgeInsetsMake(0, 0, 200, 0)];
    [self.profileTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sectionNum] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
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
    
    if ([self.iAmTextField isFirstResponder]) {
        [self.iAmTextField resignFirstResponder];
    }
    if ([self.nameTextField isFirstResponder]) {
        [self.nameTextField resignFirstResponder];
    }
    if ([self.bodyTypeTextField isFirstResponder]) {
        [self.bodyTypeTextField resignFirstResponder];
    }
    if ([self.heightTextField isFirstResponder]) {
        [self.heightTextField resignFirstResponder];
    }
    if ([self.shoeSizeUSTextField isFirstResponder]) {
        [self.shoeSizeUSTextField resignFirstResponder];
    }
    if ([self.shoeSizeUKTextField isFirstResponder]) {
        [self.shoeSizeUKTextField resignFirstResponder];
    }
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.arrayOfProfiles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
//    BBProfileCustomTableCell *addressProfileCell = (BBProfileCustomTableCell*)[tableView dequeueReusableCellWithIdentifier:kProfileCustomCellIdentifier];
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        // The device is an iPad running iPhone 3.2 or later.
//        // set up the iPad-specific view
//
//        if(addressProfileCell == nil)
//        {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kProfileCustomCellXibIPad owner:self options:nil];
//            addressProfileCell = [nib objectAtIndex:0];
//            
//            UIImageView * selecteBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kTapStateImage]];
//            addressProfileCell.selectedBackgroundView = selecteBG;
//            [selecteBG release];
//        }
//    }
//    else {
//        // The device is an iPhone or iPod touch.
//        // set up the iPhone/iPod Touch view
//        if(addressProfileCell == nil)
//        {
//            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:kProfileCustomCellXibIphone owner:self options:nil];
//            addressProfileCell = [nib objectAtIndex:0];
//            
//            UIImageView * selecteBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kTapStateImage]];
//            addressProfileCell.selectedBackgroundView = selecteBG;
//            [selecteBG release];
//        }
//    }
    

    BBProfileCustomTableCell* addressProfileCell;
    //Configure the cell.
    addressProfileCell = (BBProfileCustomTableCell*)[tableView dequeueReusableCellWithIdentifier:@"APWSignInCell"];
    if(addressProfileCell  == nil)
    {
        addressProfileCell = [[[BBProfileCustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"APWSignInCell"]autorelease ];
        addressProfileCell.cellLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:13];
    }

    if(indexPath.section == 0)
    {
        addressProfileCell.cellTextField.placeholder = @"I am";
        self.iAmTextField = addressProfileCell.cellTextField;
        self.iAmTextField.font = [UIFont systemFontOfSize:16.0];
        
    }
    else if(indexPath.section == 1)
    {
        addressProfileCell.cellTextField.placeholder = @"Name";
        self.nameTextField = addressProfileCell.cellTextField;
        self.nameTextField.font = [UIFont systemFontOfSize:16.0];
    }
    else if(indexPath.section == 2)
    {
        addressProfileCell.cellTextField.placeholder = @"Body Type";
        self.bodyTypeTextField = addressProfileCell.cellTextField;
        self.bodyTypeTextField.font = [UIFont systemFontOfSize:16.0];
    }
    else if(indexPath.section == 3)
    {
        addressProfileCell.cellTextField.placeholder = @"Height";
        self.heightTextField = addressProfileCell.cellTextField;
        self.heightTextField.font = [UIFont systemFontOfSize:16.0];
    }
    else if(indexPath.section == 4)
    {
        addressProfileCell.cellTextField.placeholder = @"Shoe size US";
        self.shoeSizeUSTextField = addressProfileCell.cellTextField;
        self.shoeSizeUSTextField.font = [UIFont systemFontOfSize:16.0];
        self.shoeSizeUSTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else if(indexPath.section == 5)
    {
        addressProfileCell.cellTextField.placeholder = @"Shoe size UK";
        self.shoeSizeUKTextField = addressProfileCell.cellTextField;
        self.shoeSizeUKTextField.font = [UIFont systemFontOfSize:16.0];
        self.shoeSizeUKTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    
    cell = addressProfileCell;
    return addressProfileCell;
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
    
    [_iAmTextField release];
    [_nameTextField release];
    [_bodyTypeTextField release];
    [_heightTextField release];
    [_shoeSizeUSTextField release];
    [_shoeSizeUKTextField release];
    
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
