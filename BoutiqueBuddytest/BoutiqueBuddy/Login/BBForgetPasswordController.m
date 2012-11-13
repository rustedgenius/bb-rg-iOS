//
//  BBForgetPasswordController.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBForgetPasswordController.h"
#import "Commons.h"

@interface BBForgetPasswordController ()

- (BOOL)validateEmailField:(NSString *)stringEmail;

@end

@implementation BBForgetPasswordController

@synthesize emailAddressField;
@synthesize btnForgetPassword;

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
}

- (void)viewDidUnload
{
    [self setEmailAddressField:nil];
    [self setBtnForgetPassword:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
        
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.emailAddressField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField setText:@""];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)validateEmailField:(NSString *)stringEmail
{
	NSString * newString=[stringEmail stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *emailRegexp =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
	NSPredicate * emailStrTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegexp];
	return [emailStrTest evaluateWithObject:newString];
}

- (void)dealloc {
    [emailAddressField release];
    [btnForgetPassword release];
    [super dealloc];
}

- (IBAction)onClickForgetPassword:(id)sender {
    if ([self validateEmailField:self.emailAddressField.text] && !([self.emailAddressField.text isEqualToString:@""])){
        [self resetPassword];
	}
	else{
		self.emailAddressField.text=@"";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid email address." delegate:self cancelButtonTitle:kOkButtonTitle otherButtonTitles:nil,nil];
		[alert show];
		[alert release];
	}
}

- (void)resetPassword{
    TRC_DBG(@"RESET PASSWORD");
    if (loginReqResHandler) {
        [loginReqResHandler release];
        loginReqResHandler.delegate = nil;
        loginReqResHandler = nil;
    }
    loginReqResHandler = [[BBLoginReqResHandler alloc] init];
    [loginReqResHandler requestToResetPassword:self.emailAddressField.text];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please check your email-ID to reset password." delegate:self cancelButtonTitle:kOkButtonTitle otherButtonTitles:nil,nil];
    [alert setTag:kTagResetSuccessfull];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // After sending reset mail pop to the main view controller.
    if (alertView.tag == kTagResetSuccessfull) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
