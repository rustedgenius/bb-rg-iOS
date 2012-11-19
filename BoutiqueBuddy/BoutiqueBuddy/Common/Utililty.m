//
//  Utililty.m
//  AutoMDWorks
//
//  Created by Pranav Verma on 10/12/11.
//  Copyright (c) 2011 Cybage. All rights reserved.
//

#import "Utililty.h"

@implementation Utililty

// Put his function into utility as it is used from many location.

+ (NSString *)formatDate:(NSString*)dateStr{
    
    NSString *formattedDate = [NSString stringWithString:@""];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd HH':'mm':'ss"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateStr];
    [dateFormatter release];
    
    if(dateFromString == nil)
    {
        formattedDate = dateStr;
    }
    else
    {
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MM/dd/YYYY"];
        formattedDate = [dateFormatter1 stringFromDate:dateFromString];
        [dateFormatter1 release];
    }
    
    return formattedDate;
}

+ (NSString*)stringByReplacingWhiteSpacesForString:(NSString*)inputString;{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [inputString stringByTrimmingCharactersInSet:whitespace];
    return trimmed;
}


+ (NSString *)covertMiltaryTimeToRegularTime:(NSString *) militaryTime
{
    int mTime = [militaryTime intValue];
    NSString * regularTime=nil;
    NSString *hourStr=nil;
    NSString *minStr=nil;
    if(mTime >= 1300)
    {
        int hour = (mTime-1200)/100;
        int min = (mTime-1200)-(hour*100);
        
        if(hour < 10)
            hourStr = [NSString stringWithFormat:@"0%d",hour];
        else
            hourStr = [NSString stringWithFormat:@"%d",hour];
        
        if(min < 10)
            minStr = [NSString stringWithFormat:@"0%d",min];
        else
            minStr = [NSString stringWithFormat:@"%d",min];
        
        regularTime = [NSString stringWithFormat:@"%@:%@ PM",hourStr,minStr];
    }
    else
    {
        int hour = mTime/100;
        int min = mTime-(hour*100);
        
        if(hour < 10)
            hourStr = [NSString stringWithFormat:@"0%d",hour];
        else
            hourStr = [NSString stringWithFormat:@"%d",hour];
        
        if(min < 10)
            minStr = [NSString stringWithFormat:@"0%d",min];
        else
            minStr = [NSString stringWithFormat:@"%d",min];
        
        regularTime = [NSString stringWithFormat:@"%@:%@ AM",hourStr,minStr];
    }
    
    return regularTime;
}




@end
