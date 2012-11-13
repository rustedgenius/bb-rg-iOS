//
//  BBCategoryHandler.m
//  BoutiqueBuddy
//
//  Created by Mandar on 11/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBCategoryHandler.h"

@implementation BBCategoryHandler
@synthesize categoryList;

- (void)makeCategoryRequestCall:(NSMutableArray *)favoriteList currentPage:(int)currentPage
{
    self.categoryList = nil;
    NSString * urlString=[NSString stringWithFormat:@"%@",kCategoryListURL];
    NSURL * categoryFetchURL = [NSURL URLWithString:urlString];
    TRC_DBG(@"Category Url...    %@", categoryFetchURL);
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:categoryFetchURL];
    [webService makeRequest:urlRequest];
}

- (void)handleReceivedData:(NSData *)data
{
    /*if(![self checkForErrors:data])
    {
        return;
    }*/
    [self parseGetCategories:data];
}


- (void)parseGetCategories:(NSData*)data
{
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSDictionary *resultDictionary = [resultString JSONValue];
    [resultString release];
    TRC_DBG(@"Get categories data  ::  %@/n",resultDictionary);
    
    NSError *error = nil;
    @try
    {
        categoryList = [[NSMutableArray alloc] initWithObjects:@"Furniture", @"Books", @"Dresses", @"Shoes", @"Handocrafts", @"Gadgets", nil];
    }
    @catch (NSException *exception)
    {
        TRC_DBG(exception.description);
        NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"Data Parsing Error",@"Error", nil];
        error = [NSError errorWithDomain:@"" code:11111 userInfo:userInfo];
        [userInfo release];
    }
    
    if([self.delegate respondsToSelector:@selector(parseComplete:handler:)])
    {
        [self.delegate parseComplete:error handler:self];
    }
}

- (void)dealloc
{
    [super dealloc];
    [categoryList release];
    categoryList = nil;
}
@end
