//
//  APWSignInTableViewCell.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 02/08/11.
//  Copyright 2011 RustedGenius. All rights reserved.
//

#import "BBProfileCustomTableCell.h"


@implementation BBProfileCustomTableCell

@synthesize cellLabel = _cellLabel, cellTextField = _cellTextField,cellDataLabel =_cellDataLabel,isTableViewSignInTableView = _isTableViewSignInTableView, isTableViewEditAddressTableView= _isTableViewEditAddressTableView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.textAlignment = UITextAlignmentLeft;
        _cellLabel.font = [UIFont systemFontOfSize:14];
        _cellLabel.hidden = YES;
        
        //Configure the label and textfield for the table cells.
        _cellDataLabel = [[UILabel alloc] init];
        _cellDataLabel.textAlignment = UITextAlignmentLeft;
        _cellDataLabel.font = [UIFont systemFontOfSize:16];
        [_cellDataLabel setHidden:YES];
        
        _cellTextField = [[UITextField alloc] init];
        _cellTextField.textAlignment = UITextAlignmentLeft;
        _cellTextField.font = [UIFont systemFontOfSize:16];
        _cellTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _cellTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _cellTextField.text = @"";
        
        [self.contentView addSubview:_cellLabel];
        [self.contentView addSubview:_cellTextField];
        [self.contentView addSubview:_cellDataLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect contentRect = self.contentView.bounds;
    CGFloat boundsX = contentRect.origin.x;
    
    //Set the frame of the label and textfield.
    CGRect frame;
    frame= CGRectMake(boundsX+20 ,5, 270, 30);
    _cellLabel.frame = frame;
    _cellTextField.frame = frame;
    _cellTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    frame= CGRectMake(boundsX+117 ,5, 160, 30);
    _cellDataLabel.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    [_cellDataLabel release];
    [_cellTextField release];
    [_cellLabel release];
    [super dealloc];
}

@end