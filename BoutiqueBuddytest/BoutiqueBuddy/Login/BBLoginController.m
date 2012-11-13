//
//  BBLoginController.m
//  BoutiqueBuddy
//
//  Created by Mandar on 07/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBLoginController.h"
#import "Commons.h"
#import "BBForgetPasswordController.h"
#import "BBProfileViewController.h"
#import "BBAddressProfileController.h"


@interface BBLoginController ()
{
    
}

- (void)configureView;

@end

@implementation BBLoginController
@synthesize lblEnterIntoBoutique;
@synthesize lblBoutiqueBuddyTitle;
@synthesize BBLogo;
@synthesize lblUserName;
@synthesize lblPassword;
@synthesize loginBgView;
@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize btnEnter;
@synthesize btnResetPassword;
@synthesize btnSignInWithTwitter;
@synthesize btnSignInWithFacebook;

@synthesize registeredUserDataModel = _registeredUserDataModel;

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
	// Do any additional setup after loading the view.
    [self configureView];
}

- (void)configureView{
    [lblEnterIntoBoutique setText:kEnterBoutique];
    [lblBoutiqueBuddyTitle setText:kBoutiqueBuddyTitle];
    [BBLogo setImage:[UIImage imageNamed:kBBLogo]];
    [loginBgView setImage:[UIImage imageNamed:kLoginBgView]];
    [lblUserName setText:kUserName];
    [lblPassword setText:kPassword];
    [userNameTextField setPlaceholder:kUserNamePlaceHolderText];
    [passwordTextField setPlaceholder:kUserNamePlaceHolderText];
}

- (void)viewDidUnload
{
    [self setBBLogo:nil];
    [self setLblUserName:nil];
    [self setLblPassword:nil];
    [self setUserNameTextField:nil];
    [self setPasswordTextField:nil];
    [self setBtnEnter:nil];
    [self setBtnResetPassword:nil];
    [self setBtnSignInWithTwitter:nil];
    [self setBtnSignInWithFacebook:nil];
    [self setLoginBgView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (IBAction)login:(id)sender{
    
    if (bbLoginReqResHandler == nil) {
        bbLoginReqResHandler = [[BBLoginReqResHandler alloc]init];
        bbLoginReqResHandler.delegate = self;
    }
    
    if (_registeredUserDataModel != nil) {
        [_registeredUserDataModel release];
    }
    _registeredUserDataModel = [[BBRegisteredUserDataModel alloc]init];
}


#define kBBForgetPasswordController @"BBForgetPasswordController"

- (IBAction)resetPassword:(id)sender {
    BBForgetPasswordController * forgetPasswordController = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iPhone 3.2 or later.
        // set up the iPad-specific view
        forgetPasswordController = [[BBForgetPasswordController alloc] initWithNibName:@"BBForgetPasswordController_iPad" bundle:[NSBundle mainBundle]];
    }
    else {
        // The device is an iPhone or iPod touch.
        // set up the iPhone/iPod Touch view
        forgetPasswordController = [[BBForgetPasswordController alloc] initWithNibName:@"BBForgetPasswordController_iPhone" bundle:[NSBundle mainBundle]];
    }
    
    [self.navigationController pushViewController:forgetPasswordController animated:YES];
    [forgetPasswordController release];
}

#define kBBProfileViewControlleriPad    @"BBProfileViewController_iPad"
#define kBBProfileViewControlleriPhone  @"BBProfileViewController_iPhone"

- (IBAction)signInWithTwitter:(id)sender {
    // For Testing we will push the set profile screen from here
    
    BBProfileViewController*profileViewController = nil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // The device is an iPad running iPhone 3.2 or later.
        // set up the iPad-specific view
        profileViewController = [[BBProfileViewController alloc] initWithNibName:kBBProfileViewControlleriPad bundle:[NSBundle mainBundle]];
    }
    else {
        // The device is an iPhone or iPod touch.
        // set up the iPhone/iPod Touch view
        profileViewController = [[BBProfileViewController alloc] initWithNibName:kBBProfileViewControlleriPhone bundle:[NSBundle mainBundle]];
    }
    
    [self.navigationController pushViewController:profileViewController animated:YES];
    [profileViewController release];
}

- (IBAction)signInWithFacebook:(id)sender {
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark Request response delegate
- (void)parseComplete:(NSError*)error handler:(RequestResponseBase*)currenthandler
{
    
}

- (void)dealloc
{
    [BBLogo release];
    [lblUserName release];
    [lblPassword release];
    [userNameTextField release];
    [passwordTextField release];
    [btnEnter release];
    [btnResetPassword release];
    [btnSignInWithTwitter release];
    [btnSignInWithFacebook release];
    [loginBgView release];
    [super dealloc];
    [lblEnterIntoBoutique release];
    lblEnterIntoBoutique = nil;
    
    [lblBoutiqueBuddyTitle release];
    lblBoutiqueBuddyTitle = nil;
    
    [_registeredUserDataModel release];
}

@end
