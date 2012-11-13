//
//  ShowProgressBar.m
//  AutoMDWorks
//
//  Created by Sumanta Rout on 5/10/10.
//  Copyright 2010 Cybage Software Pvt Ltd. All rights reserved.
//

#import "ShowProgressBar.h"

#define TIMER_INTERVAL 1

@implementation ShowProgressBar
@synthesize timer;
@synthesize ptrLoadingView;
@synthesize strLoadingText;

- (id) init
{
	self = [super init];
	if (self != nil) {
		strLoadingText = nil;;
	}
	return self;
}

- (void) initWithSuperView: (UIView *)aSuperView timeDelay:(NSTimeInterval)delay;
{
	timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO]; 
	timerStarted = TRUE;
	superview = aSuperView;	
	return ;
}

- (void)timerFireMethod:(NSTimer*)theTimer
{
	if(timerStarted == TRUE)
	{
		CGRect rect = CGRectMake(110,150,100,100);//18,128,284,140
		if( strLoadingText == nil )
		{
			strLoadingText = @"Loading...";
		}
		self.ptrLoadingView = [ProgressBarView loadingViewInView:superview displySize:rect displyText:strLoadingText];
	}
}
- (void) dealloc
{
	strLoadingText = nil;
	[super dealloc];
}

- (void) setStatus:(BOOL) status;
{
	timerStarted = status;
	if(status == FALSE)
	{			
		if(self.ptrLoadingView)
		{
			[self.ptrLoadingView removeView];
			self.ptrLoadingView = nil;
		}
	}
}

@end
