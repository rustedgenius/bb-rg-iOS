//
//  BBMyFavoritesRequestResponseHandler.m
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBMyFavoritesRequestResponseHandler.h"

@implementation BBMyFavoritesRequestResponseHandler
@synthesize favoriteList;

- (void)makeFavoritesRequestCall:(NSMutableArray *)favoriteList currentPage:(int)currentPage
{
    self.favoriteList = nil;
    NSString * urlString=[NSString stringWithFormat:@"%@",kfavouriteURL];
    NSURL * favoriteUrl = [NSURL URLWithString:urlString];
    //TRC_DBG(@"RecentSearch Url...    %@", recentSearchUrl);
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:favoriteUrl];
    [webService makeRequest:urlRequest];
}

- (void)handleReceivedData:(NSData *)data
{
    if(![self checkForErrors:data])
    {
        return;
    }
    [self parseGetFavorites:data];
}


- (void)parseGetFavorites:(NSData*)data
{
    NSString *resultString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSDictionary *resultDictionary = [resultString JSONValue];
    [resultString release];
    TRC_DBG(@"Get Saved favorite data  ::  %@/n",resultDictionary);
    
    NSError *error = nil;
    @try
    {
        //Create objects of BBFavoriteModel and add it in the mutable array.
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


- (void)dealloc{
    [super dealloc];
    [favoriteList release];
    favoriteList = nil;
}
@end
