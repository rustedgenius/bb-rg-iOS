//
//  BBAppDelegate.h
//  BoutiqueBuddy
//
//  Created by Mandar on 07/11/12.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBAppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController      *navigationController;
}
@property (strong, nonatomic) UIWindow                    *window;
@property (strong, nonatomic) UINavigationController      *navigationController;
@end
