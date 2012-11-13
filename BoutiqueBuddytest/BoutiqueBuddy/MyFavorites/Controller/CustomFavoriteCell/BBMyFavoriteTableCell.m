//
//  BBMyFavoriteTableCell.m
//  BoutiqueBuddy
//
//  Created by Mandar on 10/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBMyFavoriteTableCell.h"
#import "Commons.h"

@implementation BBMyFavoriteTableCell
@synthesize productImageView;
@synthesize shareButton;
@synthesize enquireButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFavoriteData:(BBFavoriteModel *)favoriteModelObject
{
    [shareButton setTitle:kShareButtonTitle forState:UIControlStateNormal];
    [enquireButton setTitle:kEnquireButtonTitle forState:UIControlStateNormal];
    [productImageView setImage:[UIImage imageNamed:@"2.png"]];
}

- (void)dealloc
{
    [super dealloc];
    [productImageView release];
    productImageView = nil;
    [shareButton release];
    shareButton = nil;
    [enquireButton release];
    enquireButton = nil;
}
@end
