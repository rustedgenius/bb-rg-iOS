//
//  ShowProgressBar.h
//  AutoMDWorks
//
//  Created by Sumanta Rout on 5/10/10.
//  Copyright 2010 Cybage Software Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProgressBarView.h"

@class ProgressBarView;

@interface ShowProgressBar : NSObject 
{
	NSString *strLoadingText;
	NSTimer *timer;
	BOOL timerStarted;
	
	ProgressBarView *ptrLoadingView; 
	UIView *superview;
}
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) NSString *strLoadingText;
@property (nonatomic, assign) ProgressBarView *ptrLoadingView;

- (void) initWithSuperView: (UIView *)aSuperView timeDelay:(NSTimeInterval)delay;
- (void) setStatus:(BOOL) status;
@end

