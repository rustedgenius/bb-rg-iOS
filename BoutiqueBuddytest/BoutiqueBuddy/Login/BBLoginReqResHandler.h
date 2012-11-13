//
//  BBLoginReqResHandler.h
//  BoutiqueBuddy
//
//  Created by Mandar on 08/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "RequestResponseBase.h"
#import "BBRegisteredUserDataModel.h"
#import "BBAddressDataModel.h"


typedef enum
{
    kLoginWithUserNamePasswordRequest,
    kRegisterRequest,
    kSiginInWithTwitterRequest,
    kSignInWithFacebookRequest,
    kForgetPasswordRequest,
    kSaveAddressRequest
}BBLoginRequestState;


@interface BBLoginReqResHandler : RequestResponseBase
{
    BBLoginRequestState    _bbLoginRequestState;
    BBRegisteredUserDataModel *_bbRegisteredUserDataModel;
    BBAddressDataModel *_addressDataModel;
}

@property(nonatomic, retain)BBAddressDataModel *addressDataModel;
@property(nonatomic)BBLoginRequestState bbLoginRequestState;
@property(nonatomic, retain)BBRegisteredUserDataModel *bbRegisteredUserDataModel;


/**
 Performs the functionlity of login to the Boutique Buddy
 @param sender or the button object.
 @returns event of login.
 */
- (void)loginIntoBoutiqueBuddyWithUserName:(NSString*)userName password:(NSString*)password;

/**
 Performs the functionlity of login to the Boutique Buddy
 @param sender or the button object.
 @returns event of login.
 */

- (void)registerUserWithName:(NSString*)name username:(NSString*)userName password:(NSString*)passwordemail:(NSString*)email dateOfbirth:(NSString*)dateOfBirth userModel:(BBRegisteredUserDataModel*)bbRegisteredUserDataModel;


/**
 Performs the functionlity of sending email from the backend with steps to reset the password.
 @param email address on which the reset mail will be sent.
 @returns event success response.
 */
- (void)requestToResetPassword:(NSString*)emailAddress;


/**
 Performs the functionlity of saving the address on the server
 @param address
 @param country
 @param state
 @param city
 @param zipCode
 @returns event success response.
 */

- (void)requestToSaveAddress:(NSString*)address country:(NSString*)country state:(NSString*)state city:(NSString*)city zipCode:(NSString*)zipCode addressModel:(BBAddressDataModel*)addressModel;

@end
