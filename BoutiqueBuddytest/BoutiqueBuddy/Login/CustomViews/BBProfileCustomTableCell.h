//
//  APWSignInTableViewCell.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 02/08/11.
//  Copyright 2011 RustedGenius. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @class APWSignInTableViewCell
 @abstract UITableViewCell Class
 @discussion This class creates table view cells used in the forms in the entire application.
 */

@interface BBProfileCustomTableCell : UITableViewCell
{
    UILabel* _cellLabel;                       //UILabel to display the name of the field to be entered.
    UILabel* _cellDataLabel;                   //UILabel to display the value of the field to be entered.
    UITextField* _cellTextField;               //UITextField to enter the value of the field.
    BOOL _isTableViewSignInTableView;          //Bool to check if the cell is used in sign in view controller.
    BOOL _isTableViewEditAddressTableView;     //Bool to check if the cell is used in edit address view controller.
}

@property(nonatomic, retain) UILabel* cellLabel;
@property(nonatomic, retain) UILabel* cellDataLabel;
@property(nonatomic, retain) UITextField* cellTextField;
@property BOOL isTableViewSignInTableView;
@property BOOL isTableViewEditAddressTableView;

@end