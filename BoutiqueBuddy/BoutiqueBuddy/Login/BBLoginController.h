//
//  BBLoginController.h
//  BoutiqueBuddy
//
//  Created by Mandar on 07/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+CustomNavigationBar.h"
#import "RequestResponseBase.h"
#import "BBLoginReqResHandler.h"
#import "BBRegisteredUserDataModel.h"

@interface BBLoginController : UIViewController<RequestResponseBaseDelegate>
{
    IBOutlet UILabel    *lblEnterIntoBoutique;
    IBOutlet UILabel    *lblBoutiqueBuddyTitle;
    BBLoginReqResHandler *bbLoginReqResHandler;
    BBRegisteredUserDataModel *_registeredUserDataModel;
}

@property(nonatomic, strong)IBOutlet UILabel    *lblEnterIntoBoutique;
@property(nonatomic, strong)IBOutlet UILabel    *lblBoutiqueBuddyTitle;
@property (retain, nonatomic) IBOutlet UIImageView *BBLogo;

@property (retain, nonatomic) IBOutlet UIImageView *loginBgView;
@property (retain, nonatomic) IBOutlet UILabel *lblUserName;
@property (retain, nonatomic) IBOutlet UILabel *lblPassword;
@property (retain, nonatomic) IBOutlet UITextField *userNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

@property (retain, nonatomic) IBOutlet UIButton *btnEnter;
@property (retain, nonatomic) IBOutlet UIButton *btnResetPassword;
@property (retain, nonatomic) IBOutlet UIButton *btnSignInWithTwitter;
@property (retain, nonatomic) IBOutlet UIButton *btnSignInWithFacebook;

@property (retain, nonatomic)BBRegisteredUserDataModel *registeredUserDataModel;


/**
 Performs the functionlity of login to the Boutique Buddy
 @param sender or the button object.
 @returns event of login.
 */
- (IBAction)login:(id)sender;

/**
 Sends and email to the input email address mentioning the steps to reset the password
 @param sender or the button object.
 @returns event of resetPassword.
 */
- (IBAction)resetPassword:(id)sender;

/**
 Performs the functionlity of signing into Boutique Buddy using Twitter Acount
 @param sender or the button object.
 @returns event of Twitter Acount.
 */
- (IBAction)signInWithTwitter:(id)sender;

/**
 Performs the functionlity of signing into Boutique Buddy using Facebook account
 @param sender or the button object.
 @returns event of Facebook account.
 */
- (IBAction)signInWithFacebook:(id)sender;


@end
