//
//  BBFavoriteModel.m
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBFavoriteModel.h"

@implementation BBFavoriteModel
@synthesize productName;
@synthesize productImage;

- (void)dealloc
{
    [super dealloc];
    [productImage release];
    productImage = nil;
    [productName release];
    productName = nil; 
}
@end
