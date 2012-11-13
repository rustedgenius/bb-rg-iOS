//
//  BBForgetPasswordController.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 11/10/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBLoginReqResHandler.h"


@interface BBForgetPasswordController : UIViewController<UITextFieldDelegate>
{
    BBLoginReqResHandler * loginReqResHandler;
}

@property (retain, nonatomic) IBOutlet UITextField *emailAddressField;
@property (retain, nonatomic) IBOutlet UIButton *btnForgetPassword;

- (IBAction)onClickForgetPassword:(id)sender;

@end
