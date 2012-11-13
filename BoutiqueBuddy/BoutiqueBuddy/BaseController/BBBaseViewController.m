//
//  BBBaseViewController.m
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBBaseViewController.h"
#import "BBMyFavoritesController.h"


#define kFavoriteListiPad                 @"BBMyFavoritesController_iPad"
#define kFavoriteListiPhone            @"BBMyFavoritesController_iPhone"

@interface BBBaseViewController ()

@end

@implementation BBBaseViewController
@synthesize btnSavedItems;
@synthesize btnChangePreferences;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [btnChangePreferences setTitle:kChangePreferences forState:UIControlStateNormal];
    btnChangePreferences.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    btnChangePreferences.titleLabel.textAlignment = UITextAlignmentCenter;
    
    [btnSavedItems setTitle:kSavedItems forState:UIControlStateNormal];
    btnSavedItems.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    btnSavedItems.titleLabel.textAlignment = UITextAlignmentCenter;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)loadSavedItems:(id)sender
{
    getFavoriteList = [[BBMyFavoritesRequestResponseHandler alloc] init];
    getFavoriteList.delegate = self;
    [getFavoriteList makeFavoritesRequestCall:nil currentPage:0];
}

- (IBAction)loadChangePreferences:(id)sender
{
        
}

- (void)loadFavoritesOnSuccess:(RequestResponseBase *)currenthandler
{
     if([currenthandler isKindOfClass:[BBMyFavoritesRequestResponseHandler class]])
    {
        BBMyFavoritesRequestResponseHandler *favoriteHandler = (BBMyFavoritesRequestResponseHandler *)currenthandler;
        BBMyFavoritesController *favoritesController = nil;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // The device is an iPad running iPhone 3.2 or later.
            // set up the iPad-specific view
            favoritesController = [[BBMyFavoritesController alloc] initWithNibName:kFavoriteListiPad bundle:nil];
        }
        else{
            favoritesController = [[BBMyFavoritesController alloc] initWithNibName:kFavoriteListiPhone bundle:nil];
        }
        [self.navigationController pushViewController:favoritesController animated:YES];
       [favoritesController loadWishListWithItems:favoriteHandler.favoriteList];
        favoritesController = nil;
    }
}

#pragma mark RequestResponse Delegate
- (void)parseComplete:(NSError *)error handler:(RequestResponseBase *)currenthandler
{
}

- (void)dealloc
{
    [super dealloc];
    getFavoriteList.delegate = nil;
    [getFavoriteList release];
    getFavoriteList = nil;
    
    [btnChangePreferences release];
    btnChangePreferences = nil;
    
    [btnSavedItems release];
    btnSavedItems = nil;
}
@end
