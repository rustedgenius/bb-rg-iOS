//
//  BBMyFavoritesRequestResponseHandler.h
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "RequestResponseBase.h"

@interface BBMyFavoritesRequestResponseHandler : RequestResponseBase
{
    NSMutableArray          *favoriteList;
}
@property(nonatomic, strong)NSMutableArray          *favoriteList;
/**
 Performs the functionality of making a call to favorite list and fetching set of records.
 @param     list of favorites in an array.
 @param     current page index or counter
 @returns   It returns nothing.
 */
- (void)makeFavoritesRequestCall:(NSMutableArray *)favoriteList currentPage:(int)currentPage;

/**
 Performs the functionality of parsing the favorites list of items for the signed in user
 @param     data of type NSData(binary data)
 @returns   It returns nothing.
 */
- (void)parseGetFavorites:(NSData*)data;
@end
