//
//  ReachabilityManger.h
//  Common
//
//  Created by Mandar on 05/05/11.
//  Copyright (c) 2012 Rustedgenius. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

/*!
 @class         NetworkManager
 @abstract      This class is implemented to get the current network status.  
 @discussion    This class is implemented to get the current network status.
 */
@interface NetworkManager : NSObject {

    int             activeConnections;
	bool            reachableStaus;	
    Reachability    *internetReach;
    Reachability    *wifiReach;
}

@property(nonatomic,assign)	bool reachableStaus;
@property(assign)           int activeConnections;

+ (id)sharedManager;
- (bool)isReachable;

//Start listening for reachability notifications on the current run loop
- (BOOL)startNotifier;
- (void)stopNotifier;

- (void)releaseFromActiveConnections;
- (void)addToActiveConnections;

@end
