//
//  BBMainController.h
//  BoutiqueBuddy
//
//  Created by Mandar on 07/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBBaseViewController.h"
#import "BBCategoryHandler.h"
#import "ShowProgressBar.h"

@interface BBMainController : BBBaseViewController<UIScrollViewDelegate>
{       
    IBOutlet UITableView            *categoryListView;
    NSMutableArray                    *categoryList;
    
    BBCategoryHandler               *categoryHandler;
    ShowProgressBar                 *showProgressBarObj;
}
@property(nonatomic, strong)IBOutlet UITableView *categoryListView;
@property(nonatomic, strong)NSMutableArray        *categoryList;

/**
 Performs the action of enabling or disabling the view's and navigation bar's interaction
 @param         aBOOL of tyoe BOOL
 @returns       It returns nothing.
 */
- (void)enableUserInteraction:(BOOL)aBOOL;
@end
