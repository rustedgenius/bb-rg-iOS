//
//  Utililty.h
//  AutoMDWorks
//
//  Created by Pranav Verma on 10/12/11.
//  Copyright (c) 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowProgressBar.h"

@interface Utililty : NSObject
{
}


+ (NSString*)getCurrentOsVersion;
+ (UIImageView *)getCellBGImage:(int)totalCount currentrow:(int)row;
+ (UIImageView *)setCellSelectionBG:(NSString *)bgImageName;
+ (void)showAlert:(NSString*)title message:(NSString*)message tag:(NSInteger)tag delegate:(id)delegate;
+ (void)showQuoteRequestIdFlushingAlert:(NSString*)title message:(NSString*)message tag:(NSInteger)tag delegate:(id)delegate; 
+ (NSString *)formatDate:(NSString*)dateStr;
+ (CGSize)calculateHeightForLabel:(NSString *)labelText forwidth:(int)width andSize:(int)fontSize andFontName:(NSString *)fontName;
+ (NSString*)stringByReplacingWhiteSpacesForString:(NSString*)inputString;
+ (NSString *)covertMiltaryTimeToRegularTime:(NSString *) militaryTime;
+ (void)drawLayerAroundView:(id)view;
@end
