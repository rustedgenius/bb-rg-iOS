//
//  BBMyFavoritesController.m
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBMyFavoritesController.h"


#define kFavoriteTableCelliPhone        @"BBMyFavoriteTableCell_iPhone"
#define kFavoriteTableCelliPad            @"BBMyFavoriteTableCell_iPad"
@interface BBMyFavoritesController ()

@end

@implementation BBMyFavoritesController
@synthesize favoriteList;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -  Wish list
- (void)loadWishListWithItems:(NSMutableArray *)list
{
    self.favoriteList = list;
    [wishListTableView reloadData];
}

#pragma mark - UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 10;
    //return [categoryList count];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    BBMyFavoriteTableCell *cell=(BBMyFavoriteTableCell*)[ tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell==nil) {
        [[NSBundle mainBundle] loadNibNamed:kFavoriteTableCelliPhone owner:self options:nil];
        cell = favoriteTableCell;
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [cell setFavoriteData:nil];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 75;
}

- (void)dealloc
{
    [super dealloc];
    [favoriteList release];
    favoriteList = nil;
}
@end
