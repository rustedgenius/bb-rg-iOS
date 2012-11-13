//
//  BBRegisteredUserDataModel.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBRegisteredUserDataModel.h"

@implementation BBRegisteredUserDataModel

@synthesize userName = _userName;
@synthesize name = _name;
@synthesize password = _password;
@synthesize dateOfBirth = _dateOfBirth;
@synthesize emailAddress = _emailAddress;

- (id)init
{
    if(self = [super init])
    {
        self.userName=nil;
        self.name=nil;
        self.password=nil;
        self.dateOfBirth=nil;
        self.emailAddress=nil;
    }
    return self;
}


- (void)dealloc{
    [_userName release];
    [_name release];
    [_password release];
    [_dateOfBirth release];
    [_emailAddress release];
    [super dealloc];
}


@end
