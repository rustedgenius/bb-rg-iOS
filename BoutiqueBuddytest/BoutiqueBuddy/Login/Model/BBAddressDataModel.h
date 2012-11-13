//
//  BBAddressDataModel.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBAddressDataModel : NSObject
{
    NSString *_address;
    NSString *_country;
    NSString *_state;
    NSString *_city;
    NSString *_zipCode;
    
}

#pragma Properties
@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *country;
@property(nonatomic, copy)NSString *state;
@property(nonatomic, copy)NSString *city;
@property(nonatomic, copy)NSString *zipCode;

@end
