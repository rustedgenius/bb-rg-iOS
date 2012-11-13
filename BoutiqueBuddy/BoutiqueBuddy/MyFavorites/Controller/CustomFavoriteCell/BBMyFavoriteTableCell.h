//
//  BBMyFavoriteTableCell.h
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBFavoriteModel.h"

@interface BBMyFavoriteTableCell : UITableViewCell
{
    IBOutlet UIImageView    *productImageView;
    IBOutlet UIButton       *shareButton;
    IBOutlet UIButton       *enquireButton;
}
@property(nonatomic, strong)IBOutlet UIImageView    *productImageView;
@property(nonatomic, strong)IBOutlet UIButton       *shareButton;
@property(nonatomic, strong)IBOutlet UIButton       *enquireButton;

/**
 Performs the functionality of setting the product favorite information .
 @param     object of BBFavoriteModel.
 @returns    Retrns nothing.
 */
- (void)setFavoriteData:(BBFavoriteModel *)favoriteModelObject;
@end
