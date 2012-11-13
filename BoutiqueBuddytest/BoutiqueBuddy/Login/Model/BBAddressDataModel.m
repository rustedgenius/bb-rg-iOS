//
//  BBAddressDataModel.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBAddressDataModel.h"

@implementation BBAddressDataModel

 
@synthesize address=_address;
@synthesize country=_country;
@synthesize state=_state;
@synthesize city=_city;
@synthesize zipCode=_zipCode;

- (id)init
{
    if(self = [super init])
    {
        self.address= nil;
        self.country= nil;
        self.state= nil;
        self.city= nil;
        self.zipCode= nil;
    }
    return self;
}


- (void)dealloc{
    [_address release];
    [_country release];
    [_state release];
    [_city release];
    [_zipCode release];
    [super dealloc];
}

@end
