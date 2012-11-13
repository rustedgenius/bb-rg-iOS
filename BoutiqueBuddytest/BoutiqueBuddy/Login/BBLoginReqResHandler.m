//
//  BBLoginReqResHandler.m
//  BoutiqueBuddy
//
//  Created by Mandar on 08/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBLoginReqResHandler.h"


@interface BBLoginReqResHandler(){
    
}

/**
 Performs the functionlity of parsing the data received from the login request
 @param data received for the request.
 @returns void.
 */
- (void)parseLoginData:(NSData*)data;

/**
 Performs the functionlity of parsing the data received from the register request
 @param data received for the request.
 @returns void.
 */
- (void)parseRegisterData:(NSData*)data;

/**
 Performs the functionlity of parsing the data received from the twitter sign request
 @param data received for the request.
 @returns void.
 */
- (void)parseTwitterLoginData:(NSData*)data;

/**
 Performs the functionlity of parsing the data received from the facebook sign in  request
 @param data received for the request.
 @returns void.
 */
- (void)parseFaceBookLoginData:(NSData*)data;

/**
 Performs the functionlity of parsing the data received from the facebook sign in  request
 @param data received for the request.
 @returns void.
 */
- (void)parseResetPasswordData:(NSData*)data;

@end

@implementation BBLoginReqResHandler

@synthesize bbLoginRequestState = _bbLoginRequestState;
@synthesize bbRegisteredUserDataModel = _bbRegisteredUserDataModel;
@synthesize addressDataModel = _addressDataModel;

- (void)loginIntoBoutiqueBuddyWithUserName:(NSString*)userName password:(NSString*)password;
{
    self.bbLoginRequestState = kLoginWithUserNamePasswordRequest;
    
	/*
     //Optional fields in this request lat and long
     NSString* postData = [NSString stringWithFormat:@"email=%@&password=%@"
     ,self.userBasicDetails.email
     ,self.userBasicDetails.password
     ];
     
     NSData* data = [postData dataUsingEncoding:NSUTF8StringEncoding];
     
     NSURL* url = [NSURL URLWithString:[NSString	stringWithFormat:@"%@/signin",webserviceURL]];
     NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
     [theRequest setHTTPMethod:kPost];
     [theRequest setValue:kApplicationFormEncoded forHTTPHeaderField:kContentType];
     [theRequest setHTTPBody:data];
     
     
     [webService makeRequest:theRequest];
     */
	
}

- (void)registerUserWithName:(NSString*)name username:(NSString*)userName password:(NSString*)passwordemail:(NSString*)email dateOfbirth:(NSString*)dateOfBirth userModel:(BBRegisteredUserDataModel*)bbRegisteredUserDataModel
{
    self.bbLoginRequestState = kRegisterRequest;
    self.bbRegisteredUserDataModel = bbRegisteredUserDataModel;
    /*
     //Optional fields in this request lat and long
     NSString* postData = [NSString stringWithFormat:@"email=%@&password=%@"
     ,self.userBasicDetails.email
     ,self.userBasicDetails.password
     ];
     
     NSData* data = [postData dataUsingEncoding:NSUTF8StringEncoding];
     
     NSURL* url = [NSURL URLWithString:[NSString	stringWithFormat:@"%@/signin",webserviceURL]];
     NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
     [theRequest setHTTPMethod:kPost];
     [theRequest setValue:kApplicationFormEncoded forHTTPHeaderField:kContentType];
     [theRequest setHTTPBody:data];
     
     
     [webService makeRequest:theRequest];
     */
    
}

- (void)requestToResetPassword:(NSString*)emailAddress{
    
}


- (void)requestToSaveAddress:(NSString*)address country:(NSString*)country state:(NSString*)state city:(NSString*)city zipCode:(NSString*)zipCode addressModel:(BBAddressDataModel*)addressModel{
    self.bbLoginRequestState = kSaveAddressRequest;
    self.addressDataModel = addressModel;
}


/*!
 @function		handleReceivedData
 @abstract		response data for login request to server.
 @discussion		response data for login request to server.
 @param			data - response data
 @result			bool
 */

- (void)handleReceivedData: (NSData*)data
{
    if (![self checkForErrors:data]) {
        return;
    }
    
	NSString* responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
	TRC_DBG(@"%@",responseString);
    
    switch (self.bbLoginRequestState) {
        case kLoginWithUserNamePasswordRequest:{
            
        }break;
        case kRegisterRequest:{
            
        }break;
        case kSiginInWithTwitterRequest:{
            
        }break;
        case kSignInWithFacebookRequest:{
            
        }break;
        case kForgetPasswordRequest:{
            
        }break;
        default:{}break;
    }
}


- (void)parseLoginData:(NSData*)data{
    
}

- (void)parseRegisterData:(NSData*)data{
    
}

- (void)parseTwitterLoginData:(NSData*)data{
    
}

- (void)parseFaceBookLoginData:(NSData*)data{
    
}

- (void)parseResetPasswordData:(NSData*)data{
    
}

- (void)dealloc{
    [_bbRegisteredUserDataModel release];
    [_addressDataModel release];
    [super dealloc];
}

@end
