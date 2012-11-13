// URLs

#define kfavouriteURL       @"http://"
#define kCategoryListURL  @"http://"

// Titles
// NO Network connection
#define kNoNetwork                                         NSLocalizedString(@"Network not available",nil)
#define kServerError                                        NSLocalizedString(@"Server_Error",@"")

#define kInvalidData                                        NSLocalizedString(@"Invalid_Data_From_Server",@"")


//Login Screen
#define kEnterBoutique                                    NSLocalizedString(@"Enter Boutique",@"")
#define kBoutiqueBuddyTitle                            NSLocalizedString(@"Boutique Title",@"")
#define kRegistrationSuccessfulAlertTitle           NSLocalizedString(@"Congratulations!",nil)
#define kRegistrationSuccessfulAlertMessage     NSLocalizedString(@"You have been registered on BoutiqueBuddy",nil)
#define kUserName                                          NSLocalizedString(@"UserName",nil)
#define kPassword                                           NSLocalizedString(@"Password",nil)
#define kUserNamePlaceHolderText                   NSLocalizedString(@"Angelina",nil)
#define kPasswordPlaceHolderText                     NSLocalizedString(@"**********",nil)
#define kBBLogo @""
#define kLoginBgView @""

//Base controller
#define kChangePreferences                             NSLocalizedString(@"Change Preferences",@"")
#define kSavedItems                                        NSLocalizedString(@"View Saved Items",@"")

//Main Menu screen
#define kSelectCategory                                   NSLocalizedString(@"Select category",@"")

//FavoriteList/WishList Screen
#define kShareButtonTitle                                  NSLocalizedString(@"Share",@"")
#define kEnquireButtonTitle                               NSLocalizedString(@"Enquire",@"")

// Alert buttons
#define kOkButtonTitle NSLocalizedString(@"Ok",nil)
#define kCancelButtonTitle NSLocalizedString(@"Cancel",nil)

// Font Name
#define kFontNameRegular @"HelveticaNeue"
#define kFontNameBold @"HelveticaNeue-Bold"



// Custom NAvigationabar Screen Macros
#define kNavBarImage @"img-blue-bg.png"
#define kRightButtonBackGroundImage @""


// Alert Tags
#define kTagResetSuccessfull 1000

//Added dummy teext

// Hex Color
//Used to get color from hex number
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
