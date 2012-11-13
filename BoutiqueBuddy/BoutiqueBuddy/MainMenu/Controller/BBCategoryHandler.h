//
//  BBCategoryHandler.h
//  BoutiqueBuddy
//
//  Created by Mandar on 11/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "RequestResponseBase.h"

@interface BBCategoryHandler : RequestResponseBase
{
    NSMutableArray          *categoryList;
}
@property(nonatomic, strong)NSMutableArray          *categoryList;

/**
 Performs the functionality of making a call, to get all the category list
 @param     list of category in an array.
 @param     current page index or counter
 @returns   It returns nothing.
 */
- (void)makeCategoryRequestCall:(NSMutableArray *)favoriteList currentPage:(int)currentPage;

/**
 Performs the functionality of parsing the category list from the input binary data
 @param     data of type NSData(binary data)
 @returns   It returns nothing.
 */
- (void)parseGetCategories:(NSData*)data;
@end
