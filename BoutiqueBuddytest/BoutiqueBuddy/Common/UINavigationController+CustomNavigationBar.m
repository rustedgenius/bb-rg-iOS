//
//  UINavigationController+APWCustomization.m
//  BoutiqueBuddy
//
//  Created by Vimlesh Bhatt on 02/08/11.
//  Copyright 2011 RustedGenius. All rights reserved.
//

#import "UINavigationController+CustomNavigationBar.h"
#import "Commons.h"

@implementation UINavigationBar (CustomNavigationBar)


- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:kNavBarImage];
        [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end


@implementation UINavigationController (APWCustomization)

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
                             titleBarImageName:(NSString *) titleImgName
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 50000
    if([viewController.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [viewController .navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
        [viewController.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:kNavBarImage] forBarMetrics:UIBarMetricsDefault];
    }
#endif
    
    if (rightButtonName == nil) {
        viewController.navigationItem.rightBarButtonItem = nil;
    }
    
    if (leftButtonName == nil) {
        viewController.navigationItem.leftBarButtonItem = nil;
    }
    
    if(rightButtonName !=nil || rightButtonImageName !=nil)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if(rightButtonImageName !=nil)
        {
            UIImage *butImage = [UIImage imageNamed:rightButtonImageName];
            UIImage *tapImage = [UIImage imageNamed:rightButtonTapImage];
            [button sizeToFit];
            [button setBackgroundImage:butImage forState:UIControlStateNormal];
            [button setBackgroundImage:tapImage forState:UIControlStateSelected];
            [button setBackgroundImage:tapImage forState:UIControlStateHighlighted];
        }
        else
        {
            // Square default image
            UIImage *butImage = [UIImage imageNamed:kRightButtonBackGroundImage];
            [button sizeToFit];
            [button setBackgroundImage:butImage forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"btn_top_nav_square_tap.png"] forState:UIControlStateHighlighted];

        }
        
        if(rightButtonName !=nil)
        {
            [button setTitle:[NSString stringWithFormat:@" %@ ",rightButtonName] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont fontWithName:kFontNameBold size:13] ];
            [button.titleLabel setShadowOffset:CGSizeMake(0, 1)];
            [button.titleLabel setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
            CGSize stringsize = [rightButtonName sizeWithFont:[UIFont fontWithName:kFontNameBold size:13]];
            [button setFrame:CGRectMake(5,0,stringsize.width+10, 30)];
        }
        
        [button addTarget:viewController action:selectorForRightButton forControlEvents:UIControlEventTouchUpInside];
        button.tag = 200;
        button.adjustsImageWhenDisabled = NO;
        UIBarButtonItem *rightButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
        viewController.navigationItem.rightBarButtonItem=rightButton;
        if(selectorForRightButton == nil)
            viewController.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    if(leftButtonName != nil || leftButtonImageName !=nil)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13] ];
        [button.titleLabel setShadowOffset:CGSizeMake(0, 1)];
        [button.titleLabel setShadowColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
        if(leftButtonImageName !=nil)
        {
            UIImage *butImage = [UIImage imageNamed:leftButtonImageName];
            UIImage *tapImage = [UIImage imageNamed:leftButtonTapImage];
            [button setBackgroundImage:butImage forState:UIControlStateNormal];
            [button setBackgroundImage:tapImage forState:UIControlStateSelected];
            [button setBackgroundImage:tapImage forState:UIControlStateHighlighted];
        }
        else
        {
            // Default Left Button Image
             UIImage *butImage = [UIImage imageNamed:@"btn_top_nav_back.png"];
            [button setBackgroundImage:butImage forState:UIControlStateNormal];
            [button setBackgroundImage:[UIImage imageNamed:@"btn_top_nav_back_tap.png"] forState:UIControlStateHighlighted];
        }
        
        NSString *leftButtonString = leftButtonName;
        if ([leftButtonName isEqualToString:@"Back"])
        {
            leftButtonString = [NSString stringWithFormat:@"  %@ ",leftButtonName];
        }
        
        [button setTitle:[NSString stringWithFormat:@"  %@  ",leftButtonString] forState:UIControlStateNormal];
        CGSize stringsize = [leftButtonString sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14]];
        button.frame = CGRectMake(0, 0, stringsize.width + 18, 30);
        if(selectorForLeftButton == nil)
        {
            viewController.navigationItem.backBarButtonItem.enabled = NO;
            [button addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [button addTarget:viewController action:selectorForLeftButton forControlEvents:UIControlEventTouchUpInside];
        }
        button.tag = 300;
        UIBarButtonItem *leftButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
        viewController.navigationItem.leftBarButtonItem=leftButton;
        [viewController.navigationItem.leftBarButtonItem setTitle:leftButtonName ];
        
    }
    
	if(titleImgName != nil)
    {
        UIImageView *titleImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 125, 44)];
        titleImageView.image=[UIImage imageNamed:titleImgName];
        [viewController.navigationItem setTitleView:titleImageView];
        [titleImageView release];
    }
    //Default Title.
    viewController.navigationItem.title = title;
    UILabel *label = [[UILabel alloc ]initWithFrame:CGRectMake(50, 20, 220, 44)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.shadowColor = [UIColor blackColor];
    label.textAlignment = UITextAlignmentCenter;
    [label setShadowOffset:CGSizeMake(0, 1)];
    label.text = title;
    viewController.navigationItem.titleView = label;
}

@end

