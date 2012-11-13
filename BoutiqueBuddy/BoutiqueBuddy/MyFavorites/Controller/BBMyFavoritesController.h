//
//  BBMyFavoritesController.h
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBMyFavoriteTableCell.h"

@interface BBMyFavoritesController : UIViewController
{
    IBOutlet BBMyFavoriteTableCell *favoriteTableCell;
    IBOutlet UITableView                *wishListTableView;
    NSMutableArray                       *favoriteList;
}
@property(nonatomic, strong)NSMutableArray *favoriteList;
/**
 Performs the functionality of loading the list of products fetched as favorites
 @param         list of type NSMutableArray
 @returns        it returns nothing.
 */
- (void)loadWishListWithItems:(NSMutableArray *)list;
@end
