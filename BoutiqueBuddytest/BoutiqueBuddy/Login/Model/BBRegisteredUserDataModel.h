//
//  BBRegisteredUserDataModel.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBRegisteredUserDataModel : NSObject
{
    NSString *_userName;
    NSString *_name;
    NSString *_password;
    NSString *_dateOfBirth;
    NSString *_emailAddress;
    
}

#pragma Properties
@property(nonatomic, copy)NSString *userName;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *password;
@property(nonatomic, copy)NSString *dateOfBirth;
@property(nonatomic, copy)NSString *emailAddress;

@end
