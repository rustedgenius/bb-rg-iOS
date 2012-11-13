//
//  UINavigationController+APWCustomization.h
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 02/08/11.
//  Copyright 2011 RustedGenius. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "APWConstants.h"

//DEFINES
#define APWPickLogoWidth			24
#define APWPickLogoHeight		24
#define APWTitleLabelWidth		80
#define APWTitleLabelHeight		34
#define APWNavigationBarHeight   44
#define APWNavigationBarWidth    [UIApplication sharedApplication].keyWindow.frame.size.width
#define APW_Y_OFFSET				05

#define APW_NAVIGATION_BAR_TINT   UIColorFromRGB(0xaf2b1d)
#define GET_MAX_HEIGHT(height_one,height_two) height_one>height_two?height_one:height_two
#define kHomeButtonText @"      "

@interface UINavigationBar (CustomNavigationBar)
    - (void)drawRect:(CGRect)rect;
@end

@interface UINavigationController(CustomNavigationBar)

-(void)customizeNavigationBarForViewController:(UIViewController *)viewController
                            withLeftButtonName:(NSString *)leftButtonName
                           leftButtonImageName:(NSString *)leftButtonImageName 
                        leftButtonTapImageName:(NSString *)leftButtonTapImage
                			leftButtonSelector:(SEL)selectorForLeftButton
                           withRightButtonName:(NSString *)rightButtonName
                          rightButtonImageName:(NSString *)rightButtonImageName 
                        rightButtonTapImageName:(NSString *)rightButtonTapImage
                           rightButtonSelector:(SEL)selectorForRightButton
                                     withTitle:(NSString *)title
                             titleBarImageName:(NSString *) titleImgName;


@end


