//
//  BBBaseViewController.h
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Commons.h"
#import "BBMyFavoritesRequestResponseHandler.h"

@interface BBBaseViewController : UIViewController<RequestResponseBaseDelegate>
{
    IBOutlet UIButton   *btnSavedItems;
    IBOutlet UIButton   *btnChangePreferences;
    
    BBMyFavoritesRequestResponseHandler *getFavoriteList;
}
@property(nonatomic, strong)IBOutlet UIButton   *btnSavedItems;
@property(nonatomic, strong)IBOutlet UIButton   *btnChangePreferences;

/**
 Performs the functionality of loading the saved items or wishlist
 @param   sender of type id
 @returns   ibaction
 */
- (IBAction)loadSavedItems:(id)sender;

/**
 Performs the functionality of loading the settings screen for editing the preferences.
 @param   sender of type id
 @returns   ibaction
 */
- (IBAction)loadChangePreferences:(id)sender;

/**
 Performs the functionality of loading the favorites screen on the navigation controller
 @param     currentHandler of type RequestResponse.
 @returns   It returns nothing.
 */
- (void)loadFavoritesOnSuccess:(RequestResponseBase *)currenthandler;
@end
