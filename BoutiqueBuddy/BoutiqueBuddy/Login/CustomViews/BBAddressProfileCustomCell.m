//
//  BBAddressProfileCustomCell.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/18/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import "BBAddressProfileCustomCell.h"

@implementation BBAddressProfileCustomCell

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

- (void)dealloc {
    [_cellTextField release];
    [super dealloc];
}
@end
