//
//  BBMainController.m
//  BoutiqueBuddy
//
//  Created by Mandar on 07/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBMainController.h"
#import <QuartzCore/QuartzCore.h>


CGFloat const kCellHeight = 45.0f;
CGFloat const kSectionHeaderHeight = 20.0f;

#define kCategoryTitleFrame     CGRectMake(5, 0.0, 150.0, 20.0)

#define VIEW_X                                                  0
#define VIEW_Y                                                  0
#define VIEW_W                                                  320
#define VIEW_H                                                  480
#define REFRESH_HEADER_HEIGHT                      52.0f

@interface BBMainController ()
{
    BOOL isDragging;
    BOOL isLoading;
	NSString *_textPull;
    NSString *_textRelease;
    NSString *_textLoading;
	UIView *_refreshHeaderView;
    UILabel *_refreshLabel;
    UIImageView *_refreshArrow;
    UIActivityIndicatorView *_refreshSpinner;
    int currentPage;
}
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;

@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@end

@implementation BBMainController
@synthesize categoryListView;
@synthesize categoryList;
@synthesize textPull = _textPull;
@synthesize textRelease = _textRelease;
@synthesize textLoading = _textLoading;
@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize refreshLabel = _refreshLabel;
@synthesize refreshArrow = _refreshArrow;
@synthesize refreshSpinner = _refreshSpinner;


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
    categoryHandler = [[BBCategoryHandler alloc] init];
    categoryHandler.delegate = self;
    [categoryHandler makeCategoryRequestCall:nil currentPage:0];
    [self setupStrings];
	[self addPullToRefreshHeader];
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

#pragma mark - UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.    return [categoryList count];
    //return [categoryList count];
    return 10;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //Table header title or view
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, kSectionHeaderHeight)] autorelease];
    [headerView setBackgroundColor:[UIColor lightGrayColor]];
    
    //Creating label for setting the table header title.
    UILabel *lblSelectCategory = [ [UILabel alloc ] initWithFrame:kCategoryTitleFrame];
    lblSelectCategory.textAlignment =  UITextAlignmentLeft;
    lblSelectCategory.textColor = [UIColor whiteColor];
    lblSelectCategory.backgroundColor = [UIColor clearColor];
    lblSelectCategory.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
    [headerView addSubview:lblSelectCategory];
    [lblSelectCategory setText:kSelectCategory];
    [lblSelectCategory release];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kSectionHeaderHeight;
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *categoryCellIdentifier = @"CategoryCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [categoryList objectAtIndex:indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"Item name %d", indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kCellHeight;
}

#pragma mark ShowingProgressbar
/*
 *       @functionName         : displayProgressBar
 *       @parameters            : nil
 *       @return                   : void
 *       @description            : This function will display a progress bar.
 */

-(void)displayProgressBar
{
    showProgressBarObj = [[ShowProgressBar alloc] init];
    [showProgressBarObj initWithSuperView:self.view timeDelay:0];
}


/**
 *       @functionName       : displayProgressBar
 *       @parameters          : nil
 *       @return                  : void
 *       @description           : This function will remove the progress bar.
 */

- (void)removeProgressBar
{
    if( showProgressBarObj )
    {
        [showProgressBarObj setStatus:FALSE];
        [showProgressBarObj release];
        showProgressBarObj=nil;
    }
}

#pragma mark ScrollViewDelegate

- (void)setupStrings{
	self.textPull = [[NSString alloc] initWithString:@"Pull down to refresh..."];
	self.textRelease = [[NSString alloc] initWithString:@"Release to refresh..."];
	self.textLoading = [[NSString alloc] initWithString:@"Loading..."];
}

- (void)addPullToRefreshHeader {
    self.refreshHeaderView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_X, VIEW_X - REFRESH_HEADER_HEIGHT, VIEW_W, REFRESH_HEADER_HEIGHT)];
    self.refreshHeaderView.backgroundColor = [UIColor clearColor];
	
    self.refreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_X, VIEW_X, VIEW_W, REFRESH_HEADER_HEIGHT)];
    self.refreshLabel.backgroundColor = [UIColor clearColor];
    self.refreshLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.refreshLabel.textAlignment = UITextAlignmentCenter;
	
    self.refreshArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blackArrow.png"]];
    self.refreshArrow.frame = CGRectMake(floorf((REFRESH_HEADER_HEIGHT - 27) / 2),
                                         (floorf(REFRESH_HEADER_HEIGHT - 44) / 2),
                                         27, 44);
	
    self.refreshSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.refreshSpinner.frame = CGRectMake(floorf(floorf(REFRESH_HEADER_HEIGHT - 20) / 2), floorf((REFRESH_HEADER_HEIGHT - 20) / 2), 20, 20);
    self.refreshSpinner.hidesWhenStopped = YES;
	
    [self.refreshHeaderView addSubview:self.refreshLabel];
    [self.refreshHeaderView addSubview:self.refreshArrow];
    [self.refreshHeaderView addSubview:self.refreshSpinner];
    [self.categoryListView addSubview:self.refreshHeaderView];
}

- (void)startLoading {
    isLoading = YES;
	
    // Show the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    self.categoryListView.contentInset = UIEdgeInsetsMake(REFRESH_HEADER_HEIGHT, VIEW_X, VIEW_X, VIEW_X);
    self.refreshLabel.text = self.textLoading;
    self.refreshArrow.hidden = YES;
    [self.refreshSpinner startAnimating];
    [UIView commitAnimations];
}

- (void)stopLoading {
    isLoading = NO;
    // Hide the header
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(stopLoadingComplete:finished:context:)];
   // self.recentSearchesListTable.contentInset = UIEdgeInsetsZero;
    [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
    [UIView commitAnimations];
}

- (void)stopLoadingComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    // Reset the header
    self.refreshLabel.text = self.textPull;
    self.refreshArrow.hidden = NO;
    [self.refreshSpinner stopAnimating];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (isLoading){
		return;
	}
    isDragging = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading) {
        // Update the content inset, good for section headers
        if (scrollView.contentOffset.y > 0)
            self.categoryListView.contentInset = UIEdgeInsetsZero;
        else if (scrollView.contentOffset.y >= -REFRESH_HEADER_HEIGHT)
            self.categoryListView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (isDragging && scrollView.contentOffset.y < 0) {
        // Update the arrow direction and label
        [UIView beginAnimations:nil context:NULL];
        if (scrollView.contentOffset.y < -REFRESH_HEADER_HEIGHT) {
            // User is scrolling above the header
            self.refreshLabel.text = self.textRelease;
            [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        } else { // User is scrolling somewhere within the header
            self.refreshLabel.text = self.textPull;
            [self.refreshArrow layer].transform = CATransform3DMakeRotation(M_PI * 2, 0, 0, 1);
        }
        [UIView commitAnimations];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (isLoading) return;
    isDragging = NO;
    if (scrollView.contentOffset.y <= -REFRESH_HEADER_HEIGHT) {
		// Released above the header
        [self onClickingRefreshButton];
    }
}


/**
 *       @functionName            : onClickingRefreshButton
 *       @parameters              : (id)sender
 *       @return                  : IBAction
 *       @description             : This method give call to api which will fetch another 5 posted
 question.
 */

- (IBAction)onClickingRefreshButton{
    currentPage = currentPage+1;
    
    // Check if the user is signed in
    if(nil){
        // Start Loading animation for the pull down arrow.
        [self startLoading];
        // Display progress bar and user interaction.
        [self displayProgressBar];
        [self enableUserInteraction:NO];
        //[self createRecentSearchRequest];
       // [quoteRequestHandler recentSearch:self.recentSearchList currentUserId:[CurrentStatus sharedInstance].userid forPage:currentPage];
    }
    else
    {
        // Start Loading animation for the pull down arrow.
        [self stopLoading];
        // Display progress bar and user interaction.
        [self removeProgressBar];
        [self enableUserInteraction:YES];
    }
}

- (void)enableUserInteraction:(BOOL)aBOOL
{
    [self.navigationController.navigationBar setUserInteractionEnabled:aBOOL];
    [self.view setUserInteractionEnabled:aBOOL];
}

#pragma mark CategoryList Handler
- (void)parseComplete:(NSError *)error handler:(RequestResponseBase *)currenthandler
{
    /**
    if(error)
    {
        NSString *errorString = [[error userInfo] valueForKey:@"error"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    else*/
    if([currenthandler isKindOfClass:[BBCategoryHandler class]])
    {
        BBCategoryHandler *categoryHandlerLocal = (BBCategoryHandler *)currenthandler;
        TRC_DBG(@"count: %d", [categoryHandlerLocal.categoryList count]);
        self.categoryList = categoryHandlerLocal.categoryList;
        [categoryListView reloadData];
    }
    else if([currenthandler isKindOfClass:[BBMyFavoritesRequestResponseHandler class]])
    {
        [self loadFavoritesOnSuccess:currenthandler];
    }
}

@end
